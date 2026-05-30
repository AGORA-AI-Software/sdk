# Agora Public API SDK

This repo stores Agora's public OpenAPI contract, generated SDKs, Restish CLI guidance, and AI-agent skills for the API-key-authenticated public API.

## Contents

- [Tutorial](#tutorial)
- [How-To Guides](#how-to-guides)
- [Reference](#reference)
- [Explanation](#explanation)
- [SDK Generation](#sdk-generation)
- [Restish Setup](#restish-setup)
- [Release Pipeline](#release-pipeline)
- [AI-Agent Plugins](#ai-agent-plugins)

## Tutorial

The first public workflow exchanges a long-lived API key for a short-lived bearer token, then uploads leads to an authorized campaign.

```bash
curl -sS -X POST https://core-dev.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}'
```

Set the returned token locally:

```bash
export AGORA_ACCESS_TOKEN='PASTE_REDACTED_ACCESS_TOKEN'
```

Upload one lead:

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

## How-To Guides

Use curl when validating raw HTTP behavior. Use Restish when you want an OpenAPI-aware CLI without an Agora-specific binary. Use a generated SDK for application code.

Restish setup:

```bash
make install-restish
make setup-restish
make restish-help
```

Log in with an API key and upload a lead:

```bash
tools/restish/restish --rsh-config restish/agora.restish.json \
  agora login-with-api-key \
  '{"api_key":"agora_live_REDACTED"}'

export AGORA_ACCESS_TOKEN='PASTE_REDACTED_ACCESS_TOKEN'

tools/restish/restish --rsh-config restish/agora.restish.json \
  agora upload-leads \
  '{"campaign_id":1,"leads":[{"phone":"+15551234567"}],"compliance_acknowledged":true}'
```

The exact Restish command names come from OpenAPI `operationId` values. Verify them after the public docs route is live:

```bash
restish agora --help
```

SDK usage starts by regenerating clients from the checked-in public contract:

```bash
make generate
```

Generated SDKs live under:

- `sdks/python`
- `sdks/typescript`
- `sdks/java`
- `sdks/go`

## Reference

The checked-in public contract is [openapi/agora-public-api.yaml](openapi/agora-public-api.yaml). It currently includes:

- `loginWithApiKey`: `POST /api/v1/auth/api-key/token`
- `uploadLeads`: `POST /api/v1/leads/upload`

Public docs targets:

- Production OpenAPI: `https://core.agoraai.tech/openapi.json`
- Development OpenAPI: `https://core-dev.agoraai.tech/openapi.json`
- Swagger UI: `/api-docs`

The public contract intentionally excludes internal, admin, dashboard, settings, Firebase-only, RUM ingest, and operational endpoints.

## Explanation

API keys are long-lived credentials and should only be sent to the token exchange endpoint. Normal API calls use the short-lived bearer token returned by that exchange.

Lead upload requires a bearer token authorized for the target campaign. Expected failures include invalid API key, invalid bearer token, missing campaign, unauthorized campaign, and validation errors.

Do not log API keys, bearer tokens, Authorization headers, or real lead payloads in examples, tests, generated skills, or SDK diagnostics.

## SDK Generation

Install either `openapi-generator-cli` locally or Docker. Then run:

```bash
make lint-openapi
make generate
```

To refresh the checked-in contract from a live public docs route:

```bash
make fetch-openapi OPENAPI_URL=https://core-dev.agoraai.tech/openapi.json
make lint-openapi
```

`make generate` runs SDK generation for Python, TypeScript, Java, and Go and refreshes the generated agent skill content.

### Build SDKs Locally

After installing tools in WSL, run:

```bash
# TypeScript, with Yarn 4+ Plug'n'Play and no node_modules
corepack enable
yarn install
yarn workspace @agora-ai/public-api build

# Java
cd sdks/java
mvn -B test
cd ../..

# Go
cd sdks/go
go test ./...
cd ../..
```

The Go SDK is distributed idiomatically by Git tag from this repository:

```bash
go get github.com/AGORA-AI-Software/sdk/sdks/go@v0.1.0
```

TypeScript, Python, and Java should be published to their native package registries once the public package names and credentials are finalized.

## Restish Setup

Restish setup follows the official `api connect --spec` workflow: https://rest.sh/docs/getting-started/connect-to-an-api/

Install Restish however you prefer, or use the repo-local helper:

```bash
make install-restish
```

Connect Restish manually against the checked-in spec:

```bash
tools/restish/restish --rsh-config restish/agora.restish.json \
  api connect agora https://core-dev.agoraai.tech \
  --spec openapi/agora-public-api.yaml \
  --yes --replace \
  'prompt.credentials.bearerAuth.token: env:AGORA_ACCESS_TOKEN'
```

Verify the generated command surface:

```bash
tools/restish/restish --rsh-config restish/agora.restish.json agora --help
tools/restish/restish --rsh-config restish/agora.restish.json agora login-with-api-key --rsh-generate-body
tools/restish/restish --rsh-config restish/agora.restish.json agora upload-leads --rsh-generate-body
```

When the public OpenAPI URL is live, replace `--spec openapi/agora-public-api.yaml` with `--spec https://core-dev.agoraai.tech/openapi.json`.

## Release Pipeline

This repo uses Yarn 4+ with Plug'n'Play (`nodeLinker: pnp`) and semantic-release.

```bash
corepack enable
yarn install
yarn release:verify
```

The GitHub Actions release workflow uses the same `actions/create-github-app-token` pattern as the Agora repos and authenticates as the `agora-gh-automation` GitHub App using `GH_APP_ID` and `GH_APP_PRIVATE_KEY` repository secrets.

The first release creates a repo tag, changelog, GitHub release, and synchronized SDK version metadata. That tag is the Go module release. Publishing TypeScript to npm, Python to PyPI, and Java to Maven Central should be added as registry-specific release steps when those package coordinates and credentials are ready.

## AI-Agent Plugins

Agent assets live in [plugins/agora-api](plugins/agora-api). The plugin exposes reviewed skill content for agents that need to produce public Agora API examples without relying on internal repositories.

Regenerate skill content from the current public API contract:

```bash
make generate-skills
```

Review generated skills before release. They must mention only public operations and use redacted credentials plus synthetic lead data.
