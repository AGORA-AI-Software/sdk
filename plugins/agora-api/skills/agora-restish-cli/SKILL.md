---
name: agora-restish-cli
description: Generate Restish CLI commands for the Agora public API. Use when a user wants to explore or automate the API from the terminal without writing application code or installing an Agora-specific binary.
---

# Agora Restish CLI

[Restish](https://rest.sh) is an OpenAPI-aware HTTP CLI. Use this skill when a user wants terminal workflows for the Agora API.

## Setup

```bash
# Install Restish (repo helper)
make install-restish

# Connect to the Agora API
make setup-restish

# Verify available commands
restish agora --help
```

Or connect manually:

```bash
restish api connect agora https://core.agoraai.tech \
  --spec openapi/agora-public-api.yaml \
  --yes --replace \
  'prompt.credentials.bearerAuth.token: env:AGORA_ACCESS_TOKEN'
```

## Auth Flow

```bash
# Exchange API key for bearer token
restish agora login-with-api-key '{"api_key":"agora_live_REDACTED"}'

# Set the token in your shell
export AGORA_ACCESS_TOKEN='paste-token-here'
```

## Upload Leads

```bash
restish agora upload-leads '{
  "campaign_id": 1,
  "source": "api",
  "leads": [
    {
      "first_name": "Jane",
      "last_name": "Doe",
      "email": "jane.doe@example.test",
      "phone": "+15551234567"
    }
  ],
  "compliance_acknowledged": true
}'
```

## Explore the API

```bash
# See all available operations
restish agora --help

# Generate a valid request body template for any operation
restish agora upload-leads --rsh-generate-body
restish agora login-with-api-key --rsh-generate-body
```

## Target the Development Environment

Use the `dev` profile to hit `core-dev.agoraai.tech`:

```bash
restish --profile dev agora upload-leads '...'
```

Or set it as an environment variable:

```bash
export RSH_PROFILE=dev
restish agora upload-leads '...'
```

## Guidance

- Restish is the right tool when the user wants CLI access without writing code.
- Use `--rsh-generate-body` to show users how to discover the request shape interactively.
- The `AGORA_ACCESS_TOKEN` env var is read by the Restish credential config — users do not need to pass it as a flag.
- Use synthetic data in all examples.
- Prefer the production host. Use the `dev` profile only when the user asks for it.
