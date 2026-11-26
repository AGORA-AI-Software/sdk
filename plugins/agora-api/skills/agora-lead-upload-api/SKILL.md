---
name: agora-lead-upload-api
description: Upload leads, acknowledge the versioned DNC/TCPA compliance disclaimer, poll async upload jobs, and manage lead records (list, inspect, update fields/profile/status, soft-delete) via the AGORA Public API. Use when debugging raw HTTP with curl, building a lead ingestion pipeline, handling disclaimer_version_mismatch, or managing leads without an SDK or CLI dependency.
---

# AGORA Lead Upload & Lifecycle API

Covers the **Compliance** (2 endpoints) and **Leads** (8 endpoints) public API surface.

> **Scope:** Public API-key workflows only. Creating/revoking API keys is done in the AGORA Web App (**Settings → API Keys**).

---

## Operations Covered

| Operation | Method & Path | Auth |
|---|---|---|
| `exchangeApiKeyForToken` | `POST /api/v1/auth/api-key/token` | API key in JSON body |
| `getLeadUploadDisclaimer` | `GET /api/v1/legal/documents/lead-upload-compliance` | None (public) |
| `listLeadUploadDisclaimerVersions` | `GET /api/v1/legal/documents/lead-upload-compliance/versions` | None (public) |
| `uploadLeads` | `POST /api/v1/leads/upload` | Bearer JWT |
| `get_upload_status` | `GET /api/v1/leads/upload/{import_id}` | Bearer JWT |
| `list_leads` | `GET /api/v1/leads/?campaign_id={id}` | Bearer JWT |
| `getLead` | `GET /api/v1/leads/{lead_id}` | Bearer JWT |
| `updateLead` | `PATCH /api/v1/leads/{lead_id}` | Bearer JWT |
| `updateLeadProfile` | `PATCH /api/v1/leads/{lead_id}/profile` | Bearer JWT |
| `updateLeadStatus` | `PATCH /api/v1/leads/{lead_id}/status` | Bearer JWT |
| `deleteLead` | `DELETE /api/v1/leads/{lead_id}` | Bearer JWT |

---

## Mandatory Lead Upload Flow (3 Steps)

1. **Exchange API key** (`POST /api/v1/auth/api-key/token`) for a 300s bearer JWT. Never send `agora_live_...` directly as a Bearer token.
2. **Fetch the current compliance agreement** (`GET /api/v1/legal/documents/lead-upload-compliance`, unauthenticated) and read `version` (do **not** hardcode `"v1.0"`).
3. **Upload leads** (`POST /api/v1/leads/upload`) passing `campaign_id`, `compliance_acknowledged: true`, and `disclaimer_version` echoed from Step 2. Poll `GET /api/v1/leads/upload/{import_id}` using the returned `import_id`.

### Step 1 — Exchange API Key

```bash
TOKEN=$(curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}' | jq -r .access_token)
```

### Step 2 — Fetch Current Compliance Agreement Version

```bash
DISCLAIMER_VERSION=$(curl -sS \
  https://core.agoraai.tech/api/v1/legal/documents/lead-upload-compliance \
  | jq -r .version)
```

### Step 3 — Upload Leads (`202 Accepted`)

```bash
curl -sS -X POST https://core.agoraai.tech/api/v1/leads/upload \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d "{
    \"campaign_id\": 1,
    \"source\": \"api\",
    \"duplicate_strategy\": \"fill_empty\",
    \"tags\": [\"q4-outbound\"],
    \"expose_custom_fields_to_agents\": false,
    \"update_existing_lead_status\": false,
    \"compliance_acknowledged\": true,
    \"disclaimer_version\": \"${DISCLAIMER_VERSION}\",
    \"leads\": [
      {
        \"external_id\": \"crm-10042\",
        \"first_name\": \"Jane\",
        \"last_name\": \"Doe\",
        \"email\": \"jane.doe@example.test\",
        \"phone\": \"+15551234567\",
        \"company_name\": \"Example Co\",
        \"job_title\": \"VP of Operations\",
        \"custom_fields\": { \"plan_tier\": \"enterprise\" }
      }
    ]
  }"
```

### Lead Upload Options Reference

- **`duplicate_strategy`** (preferred over legacy `skip_duplicates`):
  - `"skip"` — keep existing contact untouched (still enrolls into `campaign_id` if no active lead exists).
  - `"fill_empty"` — populate blank contact fields and new `custom_fields` keys; append non-duplicate `notes`; union `tags`.
  - `"overwrite"` — replace non-empty contact fields and matching `custom_fields` keys with incoming non-empty values (never wipes existing data with empty values).
- **Accepted per-lead fields**: `phone` (required, E.164 preferred), `external_id`, `first_name`, `last_name`, `email`, `company_name` (alias: `company`), `job_title` (alias: `title`), `department`, `address_line1`, `address_line2`, `city`, `state`, `zip_code` (alias: `zip`), `country`, `timezone`, `linkedin_url`, `website`, `mobile_phone`, `work_phone`, `notes`, `tags`, `status`, plus `custom_fields: {...}` or extra top-level keys.
- **`expose_custom_fields_to_agents: true`**: automatically adds uploaded custom field keys to the campaign's agent-visible allowlist.
- **`update_existing_lead_status: true`**: transitions existing leads to the row's `status` unless in a protected/terminal state (converted, DNC, active call, or pending future callback).

### Step 4 — Poll Upload Batch Status

```bash
curl -sS "https://core.agoraai.tech/api/v1/leads/upload/${IMPORT_ID}" \
  -H "Authorization: Bearer ${TOKEN}"
```

---

## Managing Existing Leads

### List & Filter Leads (Campaign-Scoped)

```bash
# Required: campaign_id. Supports status_value, external_id, import_id, search, after_id, page, per_page
curl -sS "https://core.agoraai.tech/api/v1/leads/?campaign_id=1&per_page=50" \
  -H "Authorization: Bearer ${TOKEN}"
```

### Get Lead Details

```bash
curl -sS "https://core.agoraai.tech/api/v1/leads/${LEAD_ID}" \
  -H "Authorization: Bearer ${TOKEN}"
```

### Update Campaign-Scoped Lead Fields

Public API callers may **only** update `priority`, `notes`, and `custom_fields` (other fields return `400 validation_error`). `custom_fields` merges non-destructively; pass `null` for a key to remove it.

```bash
curl -sS -X PATCH "https://core.agoraai.tech/api/v1/leads/${LEAD_ID}" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"priority":"high","notes":"Requested afternoon callback","custom_fields":{"plan_tier":"enterprise","old_key":null}}'
```

### Update Contact Profile Fields

```bash
curl -sS -X PATCH "https://core.agoraai.tech/api/v1/leads/${LEAD_ID}/profile" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"job_title":"SVP of Operations","email":"jane.doe@example.test","tags":["vip"]}'
```

### Transition Lead Pipeline Status (Use `to_status_code`)

Always discover valid status codes first via `GET /api/v1/campaigns/{campaign_id}/statuses`. Public API callers pass `to_status_code` (not `to_status_id`).

```bash
curl -sS -X PATCH "https://core.agoraai.tech/api/v1/leads/${LEAD_ID}/status" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"to_status_code":"not_interested","reason":"Confirmed via CRM sync"}'
```

### Soft-Delete a Lead (`204 No Content`)

Marks the lead deleted in the campaign while preserving the underlying contact record.

```bash
curl -sS -i -X DELETE "https://core.agoraai.tech/api/v1/leads/${LEAD_ID}" \
  -H "Authorization: Bearer ${TOKEN}"
```

---

## Guidance & Common Failure Modes

- **`400 disclaimer_version_mismatch`**: Re-fetch `GET /api/v1/legal/documents/lead-upload-compliance` and resend with the current `version`.
- **`401` during long batch runs**: Bearer tokens expire after **300 seconds**; re-run `POST /api/v1/auth/api-key/token` and retry.
- **`403` / `404`**: Caller's API key must belong to the owning Company Admin, owning TAM, or app owner for `campaign_id`. Discover valid IDs via `GET /api/v1/campaigns/accessible`.
- Never log API keys, bearer tokens, `Authorization` headers, or real lead PII. Use synthetic data (`example.test`, `+15551234567`) in examples.
- Prefer `agora-sdk-usage` for typed application code (note: generated SDKs currently cover auth, lead upload, and webhooks) and `agora-restish-cli` for interactive terminal workflows.
