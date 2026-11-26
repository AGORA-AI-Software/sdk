---
name: agora-public-api
description: Master reference and capability router for the AGORA Public API (all 38 live endpoints across Authentication, Compliance, Campaigns, Leads, Calls, and Webhooks). Use whenever a user asks what the AGORA Public API can or cannot do, wants to authenticate with an API key, explore accessible campaigns, build a CRM/ATS integration, or needs to pick the right AGORA API workflow (curl, Restish CLI, or generated SDKs).
---

# AGORA Public API

Authoritative capability map and workflow router for the **AGORA Public API** (`https://core.agoraai.tech` production, `https://core-dev.agoraai.tech` development).

Live machine-readable contract: `GET https://core.agoraai.tech/openapi.json` (interactive Swagger UI at `https://core.agoraai.tech/api-docs`).

---

## What the Public API Can Do (38 Live Endpoints, 6 Domains)

| Domain | Endpoints | Key Capabilities | Detailed Skill |
|---|---|---|---|
| **Authentication** | 1 | Exchange a long-lived `agora_live_...` API key for a short-lived bearer JWT (`POST /api/v1/auth/api-key/token`, 300s TTL). | This skill |
| **Compliance** | 2 | Fetch the current DNC/TCPA lead-upload agreement & required `version` (`GET /api/v1/legal/documents/lead-upload-compliance`) and version history (unauthenticated). | `agora-lead-upload-api` |
| **Leads** | 8 | Upload leads via JSON (`POST /api/v1/leads/upload`), poll async import jobs (`GET /api/v1/leads/upload/{import_id}`), list/filter leads (`GET /api/v1/leads/`), get/update/soft-delete leads (`GET`/`PATCH`/`DELETE /api/v1/leads/{lead_id}`), update contact profile (`/profile`), and transition pipeline status by code (`/status`). | `agora-lead-upload-api` |
| **Campaigns** | 23 | Discover authorized campaigns (`GET /api/v1/campaigns/accessible`), create/clone/duplicate campaigns, browse & apply Blueprint Starter Packs, atomically provision or export declarative 10-subsystem blueprints (`dry_run` supported), run readiness & launch-readiness audits, and manage statuses, scripts, agent action buttons, and auto-email/auto-SMS rules. | `agora-campaigns-and-calls-api` |
| **Calls** | 1 | Query deterministic paginated call outcomes, dispositions, transcripts, AI summaries, and CRM analysis (`GET /api/v1/calls/`) with `since` / `updated_since` and `after_id` keyset incremental sync. | `agora-campaigns-and-calls-api` |
| **Webhooks** | 3 | Read-only observability: list subscribable event types (8 events), list configured campaign endpoints (no secrets), and inspect per-endpoint delivery health & latency. | `agora-webhook-api` |

See [`references/endpoints.md`](references/endpoints.md) for the complete 38-endpoint table with methods, paths, `operationId`s, parameters, and response codes.

## What the Public API Cannot Do (Web App Only)

Do **not** invent endpoints for these operations — direct the user to the **AGORA Web App** instead:

- Creating, listing, or revoking API keys (**Settings → API Keys**).
- Creating, editing, disabling, deleting, testing, or rotating signing secrets for webhook endpoints.
- Direct audio recording downloads (call items expose `has_recording` and `web_app_url` for authenticated playback in the web app).
- Billing, user/seat management, agent payouts, or internal operational controls.

---

## Mandatory Authentication Flow (2-Step Exchange)

API keys **cannot** be passed directly as `Authorization: Bearer agora_live_...` — the backend rejects non-JWT tokens with HTTP `401`. Always exchange the key first:

```bash
# 1. Exchange long-lived API key for a 300-second bearer JWT
TOKEN=$(curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d "{\"api_key\":\"${AGORA_API_KEY}\"}" | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")

# 2. Discover campaigns authorized for this key
curl -sS https://core.agoraai.tech/api/v1/campaigns/accessible \
  -H "Authorization: Bearer ${TOKEN}"
```

### Auth & Security Rules

1. Send the long-lived API key **only** to `POST /api/v1/auth/api-key/token`.
2. Bearer tokens expire in **300 seconds (`expires_in: 300`)**. Cache in memory and automatically re-exchange before expiry or on HTTP `401`.
3. Never log API keys, bearer JWTs, `Authorization` headers, or real customer/lead PII.
4. Use synthetic data in examples (`example.test` emails, `+15551234567` phones, `agora_live_REDACTED` keys).

---

## Choosing the Right Client & Skill

| User Need | Use This Skill | Coverage |
|---|---|---|
| Raw HTTP / `curl` for compliance + lead upload + lead CRUD/status | `agora-lead-upload-api` | All 10 Compliance & Leads endpoints |
| Raw HTTP / `curl` for campaigns, blueprints, automations, or call sync | `agora-campaigns-and-calls-api` | All 24 Campaigns & Calls endpoints |
| Webhook endpoint inventory & delivery health monitoring | `agora-webhook-api` | All 3 Webhook endpoints (curl, Restish, SDKs) |
| Interactive terminal CLI without writing code | `agora-restish-cli` | All 38 endpoints when connected to `/openapi.json` |
| Generated typed SDKs (Python, TypeScript, Java, Go) | `agora-sdk-usage` | Currently 5 generated operations (auth, lead upload, 3 webhook endpoints); use HTTP/Restish for the other 33 endpoints |

---

## Error Recovery Matrix

| HTTP Status | Meaning | Required Recovery Action |
|---|---|---|
| `400 disclaimer_version_mismatch` | `disclaimer_version` on `POST /api/v1/leads/upload` is outdated or wrong. | Re-fetch `GET /api/v1/legal/documents/lead-upload-compliance`, surface the updated text if needed, and retry with the returned `version`. |
| `400 validation_error` | Disallowed field or invalid scope (e.g., missing `campaign_id` on upload, or setting fields other than `priority`/`notes`/`custom_fields` on `PATCH /api/v1/leads/{lead_id}`). | Inspect response `message` and restrict payload to allowed public fields. |
| `401` | Missing, malformed, or expired bearer JWT (or invalid/revoked API key). | If calling a resource endpoint, re-exchange the API key at `POST /api/v1/auth/api-key/token`. Never pass `agora_live_...` directly as Bearer. |
| `403` | Token is valid, but caller does not own the target company/campaign (agents cannot use public lead/campaign routes). | Verify accessible IDs via `GET /api/v1/campaigns/accessible`. |
| `404` | Resource does not exist or belongs to a campaign outside the caller's ownership scope. | Confirm IDs with `GET /api/v1/campaigns/accessible` or `GET /api/v1/leads/`. |
| `422` | Request schema validation failed (missing required field such as `disclaimer_version`, invalid types, or row-level lead errors). | Fix required fields and check `detail` or `errors[]` before retrying. |

## Environment Selection

- **Production (default):** `https://core.agoraai.tech`
- **Development:** `https://core-dev.agoraai.tech` (use only when explicitly asked for dev/staging testing)
- **Local:** `http://localhost:8000` (local Tilt stack)
