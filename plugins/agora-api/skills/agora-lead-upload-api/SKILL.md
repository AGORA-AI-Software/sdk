---
name: agora-lead-upload-api
description: Use Agora's public API to exchange an API key for a short-lived bearer token and upload leads to an authorized campaign. Use when generating customer-facing curl, Restish, or SDK examples for the public lead upload workflow.
---

# Agora Lead Upload API

Use this skill for Agora's public API-key workflow only. Do not mention internal, admin, dashboard, settings, Firebase-only, RUM ingest, or operational endpoints.

## Public Operations

- `loginWithApiKey`: `POST /api/v1/auth/api-key/token`
- `uploadLeads`: `POST /api/v1/leads/upload`

## Auth Flow

1. Send the long-lived API key only to the token exchange endpoint.
2. Store the returned bearer token in memory or secure local credential storage.
3. Use `Authorization: Bearer <token>` for lead upload.
4. Never log API keys, bearer tokens, Authorization headers, or real lead payloads.

## Curl Example

```bash
curl -sS -X POST https://core-dev.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}'
```

```bash
curl -sS -X POST https://core-dev.agoraai.tech/api/v1/leads/upload \
  -H "Authorization: Bearer $AGORA_ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -d '{
    "campaign_id": 1,
    "source": "api",
    "leads": [
      {
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "jane.doe@example.test",
        "phone": "+15551234567",
        "company": "Example Co",
        "title": "VP of Operations"
      }
    ],
    "compliance_acknowledged": true
  }'
```

## Guidance

- Prefer SDK examples when the user is building application code.
- Prefer Restish examples when the user asks for a CLI workflow without installing an Agora-specific binary.
- Prefer curl when debugging the raw HTTP contract.
- Use synthetic lead data in examples.
