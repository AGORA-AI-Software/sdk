---
name: agora-restish-cli
description: Generate Restish CLI commands for the AGORA Public API across all 38 live endpoints (auth, compliance, campaigns, leads, calls, webhooks). Use when a user wants to explore, test, or automate the AGORA API from the terminal without writing application code or installing an AGORA-specific binary.
---

# AGORA Restish CLI

[Restish](https://rest.sh) is an OpenAPI-aware HTTP CLI. Connect it directly to the live `/openapi.json` spec to expose all **38 public endpoints** interactively, or use the repo-local config in `restish/agora.restish.json`.

---

## Mode 1: Connect to the Live OpenAPI Spec (Recommended — All 38 Endpoints)

Connect Restish directly to `https://core.agoraai.tech/openapi.json` so every live domain (Authentication, Compliance, Campaigns, Leads, Calls, Webhooks) is available as a CLI command:

```bash
# Connect production profile (reads bearer JWT from $AGORA_ACCESS_TOKEN)
restish api connect agora https://core.agoraai.tech \
  --spec https://core.agoraai.tech/openapi.json \
  --yes --replace \
  'prompt.credentials.AGORA_API_KEY.token: env:AGORA_ACCESS_TOKEN'

# Inspect all 38 available operations
restish agora --help
```

### Auth & Compliance Flow (Live Spec)

```bash
# 1. Exchange API key for a 300-second bearer JWT
export AGORA_ACCESS_TOKEN=$(restish agora exchange-api-key-for-token \
  'api_key: agora_live_REDACTED' -f body.access_token -r)

# 2. Discover your authorized campaign IDs
restish agora list-accessible-campaigns

# 3. Fetch the current DNC/TCPA compliance disclaimer version (unauthenticated)
DISCLAIMER_VERSION=$(restish agora get-lead-upload-disclaimer -f body.version -r)
```

### Common Commands (Live Spec)

```bash
# Upload a synthetic lead (disclaimer_version is required!)
restish agora upload-leads "{
  \"campaign_id\": 1,
  \"source\": \"api\",
  \"duplicate_strategy\": \"fill_empty\",
  \"compliance_acknowledged\": true,
  \"disclaimer_version\": \"${DISCLAIMER_VERSION}\",
  \"leads\": [
    {
      \"first_name\": \"Jane\",
      \"last_name\": \"Doe\",
      \"email\": \"jane.doe@example.test\",
      \"phone\": \"+15551234567\"
    }
  ]
}"

# List calls updated since a timestamp
restish agora list-calls --campaign-id 1 --since 2026-11-01T00:00:00Z

# Check campaign readiness & launch-readiness
restish agora get-campaign-readiness-audit 1
restish agora get-campaign-launch-readiness 1

# List webhook endpoints & health
restish agora list-webhook-endpoints 1
restish agora get-webhook-endpoint-health 1 12

# Generate a request body template for any operation
restish agora upload-leads --rsh-generate-body
restish agora provision-campaign --rsh-generate-body
```

---

## Mode 2: Repo-Local Config (`restish/agora.restish.json` — Auto Token Exchange)

When running inside the `AGORA-AI-Software/sdk` checkout, `restish/agora.restish.json` is pre-configured with `scripts/get-token.sh` to exchange `AGORA_API_KEY` automatically on every call (covering the checked-in `openapi/agora-public-api.yaml` operations):

```bash
# Install repo-local restish binary
make install-restish

# Set your API key (exchanged automatically by scripts/get-token.sh)
export AGORA_API_KEY='agora_live_REDACTED'

# Run against production (default profile) or dev (--profile dev)
tools/restish/restish --rsh-config restish/agora.restish.json agora --help
tools/restish/restish --rsh-config restish/agora.restish.json agora list-webhook-endpoints 1
tools/restish/restish --rsh-config restish/agora.restish.json --profile dev agora list-webhook-endpoints 1
```

---

## Targeting Development (`core-dev.agoraai.tech`)

```bash
restish api connect agora-dev https://core-dev.agoraai.tech \
  --spec https://core-dev.agoraai.tech/openapi.json \
  --yes --replace \
  'prompt.credentials.AGORA_API_KEY.token: env:AGORA_ACCESS_TOKEN'
```

Or with the repo-local config: `restish --rsh-config restish/agora.restish.json --profile dev agora ...` (or `export RSH_PROFILE=dev`).

---

## Guidance

- Always fetch `disclaimer_version` from `get-lead-upload-disclaimer` before calling `upload-leads` — omitting it fails against the live API.
- Bearer JWTs expire in **300 seconds**. In Mode 1, re-run `exchange-api-key-for-token` if you receive `401`.
- Use `--rsh-generate-body` to inspect valid JSON/shorthand payloads for complex operations like `provision-campaign` or `update-lead-status`.
- Never log `AGORA_API_KEY`, `AGORA_ACCESS_TOKEN`, or real lead PII; use synthetic data (`example.test`, `+15551234567`).
- Prefer the production host (`core.agoraai.tech`); target `core-dev.agoraai.tech` only when asked.
