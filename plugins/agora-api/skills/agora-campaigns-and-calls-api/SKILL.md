---
name: agora-campaigns-and-calls-api
description: Discover, provision, clone, configure, and audit AGORA campaigns (blueprints, statuses, scripts, action buttons, auto-email/auto-SMS rules, readiness checks) and query paginated call outcomes, transcripts, and AI analysis via the AGORA Public API. Use when a user wants to list accessible campaigns, automate campaign setup, check launch readiness, or sync call outcomes/transcripts into a CRM or data warehouse.
---

# AGORA Campaigns & Calls API

Covers the **Campaigns** (23 endpoints) and **Calls** (1 endpoint) public API surface.

> **Client Note:** These endpoints are live on `https://core.agoraai.tech` and `https://core-dev.agoraai.tech`. Call them via `curl`, an HTTP client, or `restish` connected to `/openapi.json` (generated SDK packages do not yet include Campaigns/Calls client classes).

---

## Auth Flow

All endpoints require a 300s bearer JWT from `POST /api/v1/auth/api-key/token`:

```bash
TOKEN=$(curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}' | jq -r .access_token)
```

---

## 1. Discover Accessible Campaigns (Start Here)

Always call `listAccessibleCampaigns` first to obtain valid `campaign_id` values authorized for the API key:

```bash
curl -sS "https://core.agoraai.tech/api/v1/campaigns/accessible?page=1&per_page=50" \
  -H "Authorization: Bearer ${TOKEN}"
```

---

## 2. Campaign Provisioning, Blueprints & Cloning

| Task | Method & Path | Notes |
|---|---|---|
| List curated starter packs | `GET /api/v1/campaigns/blueprints` | Returns starter packs (Recruiting, Clinical Intake, B2B SaaS, Informed Consent). |
| Provision full campaign (10 subsystems) | `POST /api/v1/campaigns/provision` | Declarative `CampaignBlueprintRequest`. Set `"dry_run": true` to validate without writing! |
| Create minimal campaign | `POST /api/v1/campaigns/` | Requires `company_id`, `name`, `campaign_type`, `pricing_model`. |
| Export campaign as blueprint | `GET /api/v1/campaigns/{campaign_id}/blueprint` | Export full config to clone/version in Git. |
| Update campaign via blueprint | `PUT /api/v1/campaigns/{campaign_id}/blueprint` | Declarative update of an existing campaign. |
| Apply starter pack | `POST /api/v1/campaigns/{campaign_id}/apply-blueprint` | Body: `{"blueprint_key": "...", "override_service_name": "...", "calendly_scheduling_url": "..."}`. |
| Clone campaign | `POST /api/v1/campaigns/{campaign_id}/clone` | Body: `{"new_name": "...", "include_automations": true, "include_scoring_rules": true, "include_custom_fields": true, "attach_shared_company_phones": false}`. |
| Duplicate campaign | `POST /api/v1/campaigns/{campaign_id}/duplicate` | Quick duplicate into DRAFT status. Required body: `{"new_name": "..."}`. |

See [`references/campaign-blueprints.md`](references/campaign-blueprints.md) for declarative blueprint, status, script, action-button, and automation-rule payloads.

### Dry-Run Blueprint Provision Example

Valid `campaign_type` values: `inbound`, `outbound`, `hybrid`. Valid `pricing_model` values: `commission`, `subscription`, `pay_per_call`, `pay_per_outcome`.

```bash
curl -sS -X POST https://core.agoraai.tech/api/v1/campaigns/provision \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Q4 Outbound SaaS",
    "dry_run": true,
    "auto_launch": false,
    "campaign_type": "outbound",
    "pricing_model": "commission"
  }'
```

---

## 3. Campaign Readiness & Sub-Resources

### Check Readiness Before Launching

```bash
# 8-domain setup scorecard (telephony, pipeline, action_buttons, scripts, education, messaging, booking, ai_rules)
curl -sS "https://core.agoraai.tech/api/v1/campaigns/${CAMPAIGN_ID}/readiness" \
  -H "Authorization: Bearer ${TOKEN}"

# Launch blockers & phone configuration validation
curl -sS "https://core.agoraai.tech/api/v1/campaigns/${CAMPAIGN_ID}/launch-readiness" \
  -H "Authorization: Bearer ${TOKEN}"
```

### Pipeline Statuses, Scripts, Action Buttons & Automation Rules

| Sub-Resource | Read | Create |
|---|---|---|
| **Pipeline Statuses** | `GET /api/v1/campaigns/{campaign_id}/statuses?include_counts=true` | `POST /api/v1/campaigns/{campaign_id}/statuses` (`name`, `code`, ...) |
| **Scripts** | `GET /api/v1/campaigns/{campaign_id}/scripts` (`category`, `is_active`, `lead_id`) | `POST /api/v1/campaigns/{campaign_id}/scripts` (`name`, `category`, `content`) |
| **Agent Action Buttons** | `GET /api/v1/campaigns/{campaign_id}/agent-action-buttons` | `POST /api/v1/campaigns/{campaign_id}/agent-action-buttons` (`button_position`, `button_type`, `button_name`) |
| **Auto-Email Rules** | `GET /api/v1/campaigns/{campaign_id}/auto-email-rules` | `POST .../auto-email-rules/disposition` or `.../auto-email-rules/status` |
| **Auto-SMS Rules** | `GET /api/v1/campaigns/{campaign_id}/auto-sms-rules` | `POST .../auto-sms-rules/disposition` or `.../auto-sms-rules/status` |

---

## 4. Querying Calls & Syncing Outcomes (`GET /api/v1/calls/`)

Deterministic, paginated call intelligence for CRM/warehouse sync.

- **`since` / `updated_since` (ISO-8601 UTC):** Matches on the call's effective last update so async transcripts, AI summaries/analysis, and dispositions arriving after `started_at` are never missed.
- **Keyset pagination (`after_id`):** Pair `after_id` with `sort_by=id&sort_dir=asc`. The response populates `next_after_id` **only** when `sort_by=id&sort_dir=asc` and a full page (`len(calls) == per_page`) is returned; otherwise `next_after_id` is `null`.
- **Recordings boundary:** Responses include `has_recording` (boolean) and `web_app_url` (deep link to authenticated playback in the AGORA Web App). Raw audio URLs are intentionally never returned.

```bash
# Incremental sync of calls updated since a watermark (keyset-paginated by id)
curl -sS "https://core.agoraai.tech/api/v1/calls/?campaign_id=${CAMPAIGN_ID}&since=2026-11-01T00:00:00Z&sort_by=id&sort_dir=asc&per_page=100" \
  -H "Authorization: Bearer ${TOKEN}"
```

### Available `GET /api/v1/calls/` Query Filters

`campaign_id`, `lead_id`, `since`, `until`, `updated_since`, `disposition`, `status`, `direction`, `after_id`, `page`, `per_page`, `sort_by`, `sort_dir`.

### Response Shape (`PublicCallListResponse`)

```json
{
  "calls": [
    {
      "id": 9012,
      "campaign_id": 1,
      "lead_id": 4401,
      "external_id": "crm-10042",
      "phone_number": "+15551234567",
      "phone_to": "+15551234567",
      "phone_from": "+15550001111",
      "direction": "outbound",
      "status": "completed",
      "disposition": "interested",
      "outcome": "appointment_booked",
      "started_at": "2026-11-01T15:10:00Z",
      "ended_at": "2026-11-01T15:14:22Z",
      "updated_at": "2026-11-01T15:15:05Z",
      "duration_seconds": 262,
      "talk_time_seconds": 215,
      "callback_requested": false,
      "transcript": "...",
      "ai_summary": "...",
      "has_recording": true,
      "web_app_url": "https://app.agoraai.tech/company/calls/9012"
    }
  ],
  "total": 1,
  "page": 1,
  "per_page": 100,
  "total_pages": 1,
  "next_after_id": null
}
```

---

## Guidance

- Always start with `GET /api/v1/campaigns/accessible` rather than guessing `campaign_id`.
- Always use `"dry_run": true` before mutating or provisioning a production campaign with `POST /api/v1/campaigns/provision`.
- Before launching a campaign, check both `/readiness` and `/launch-readiness`.
- For CRM call ingestion, store `updated_at` and `next_after_id` as watermarks and refresh the 300s bearer JWT on `401`.
