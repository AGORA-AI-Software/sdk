# Agora Public API SDK

This repo contains Agora's public OpenAPI contract, generated SDKs, Restish CLI configuration, and AI-agent plugins for the API-key-authenticated public API.

**API Docs:** [core.agoraai.tech/api-docs](https://core.agoraai.tech/api-docs) · [core-dev.agoraai.tech/api-docs](https://core-dev.agoraai.tech/api-docs)

## SDKs

| Language | Location | Install |
|---|---|---|
| Python | [`sdks/python`](sdks/python/README.md) | `pip install agora-public-api` |
| TypeScript | [`sdks/typescript`](sdks/typescript/README.md) | `npm install @agora-ai/public-api` |
| Java | [`sdks/java`](sdks/java/README.md) | Maven: `ai.agora:agora-public-api` |
| Go | [`sdks/go`](sdks/go/README.md) | `go get github.com/AGORA-AI-Software/sdk/sdks/go` |

## CLI (Restish)

[Restish](https://rest.sh) is an OpenAPI-aware HTTP CLI — no Agora-specific binary required.

```bash
make install-restish
make setup-restish
```

See [restish/README.md](restish/README.md) for usage.

## Contents

- [Tutorial](#tutorial)
- [How-To Guides](#how-to-guides)
- [Reference](#reference)
- [Explanation](#explanation)

---

## Tutorial

This tutorial walks through exchanging an API key for a bearer token and uploading a lead — the two core operations of the public API.

### Step 1 — Exchange your API key for a bearer token

```bash
curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}'
```

The response contains an `access_token`. Set it in your shell:

```bash
export AGORA_ACCESS_TOKEN='paste-token-here'
```

### Step 2 — Upload a lead

```bash
curl -sS -X POST https://core.agoraai.tech/api/v1/leads/upload \
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

---

## How-To Guides

### Use the CLI (Restish)

Restish is the fastest way to explore the API without writing application code.

```bash
make install-restish
make setup-restish

# Authenticate
restish agora login-with-api-key '{"api_key":"agora_live_REDACTED"}'
export AGORA_ACCESS_TOKEN='paste-token-here'

# Upload leads
restish agora upload-leads \
  '{"campaign_id":1,"leads":[{"phone":"+15551234567"}],"compliance_acknowledged":true}'
```

Use the `dev` profile to target the development environment:

```bash
restish --profile dev agora upload-leads ...
```

### Use an SDK

Pick the SDK for your language and follow its README:

- [Python SDK →](sdks/python/README.md)
- [TypeScript SDK →](sdks/typescript/README.md)
- [Java SDK →](sdks/java/README.md)
- [Go SDK →](sdks/go/README.md)

### Regenerate SDKs from the OpenAPI contract

Install Docker or `openapi-generator-cli`, then:

```bash
make lint-openapi
make generate
```

### Refresh the OpenAPI contract from the live API

```bash
make fetch-openapi OPENAPI_URL=https://core.agoraai.tech/openapi.json
make lint-openapi
make generate
```

### Run SDK tests locally

```bash
# TypeScript
corepack enable && yarn install
yarn workspace @agora-ai/public-api build

# Java
cd sdks/java && mvn -B test

# Go
cd sdks/go && go test ./...

# Python
cd sdks/python && pip install -e ".[dev]" && pytest
```

---

## Reference

### OpenAPI contract

The checked-in contract is at [`openapi/agora-public-api.yaml`](openapi/agora-public-api.yaml).

Live endpoints:

| Environment | OpenAPI URL | Swagger UI |
|---|---|---|
| Production | `https://core.agoraai.tech/openapi.json` | https://core.agoraai.tech/api-docs |
| Development | `https://core-dev.agoraai.tech/openapi.json` | https://core-dev.agoraai.tech/api-docs |

### Available operations

| Operation | Method | Path |
|---|---|---|
| `loginWithApiKey` | `POST` | `/api/v1/auth/api-key/token` |
| `uploadLeads` | `POST` | `/api/v1/leads/upload` |

### SDK generation

```bash
make generate           # regenerate all SDKs + skills from openapi/agora-public-api.yaml
make generate-skills    # regenerate AI-agent skill content only
make lint-openapi       # validate the OpenAPI contract
make lint-plugin        # validate the AI-agent plugin manifests
```

### AI-agent plugins

Agent plugins live in [`plugins/agora-api`](plugins/agora-api). They expose reviewed skill content for AI agents that need to produce Agora API examples.

---

## Explanation

### Why two credentials?

API keys are long-lived secrets and should only be sent to the token exchange endpoint. All subsequent requests use the short-lived bearer token returned by that exchange. This limits the blast radius of a leaked token and avoids exposing the API key in request logs.

### Release pipeline

This repo uses [semantic-release](https://semantic-release.gitbook.io) via Yarn 4 PnP. Merging to `main` with a conventional commit message (`feat:`, `fix:`, etc.) triggers a release that:

1. Bumps version numbers across all SDK manifests
2. Updates `CHANGELOG.md`
3. Creates a GitHub release and tag
4. The Git tag doubles as the Go module release

TypeScript (npm), Python (PyPI), and Java (Maven Central) publishing should be added as registry-specific steps when package coordinates and credentials are finalized.

### Repository layout

```
openapi/          Public OpenAPI contract
sdks/             Generated SDK clients (Python, TypeScript, Java, Go)
sdk-overrides/    Hand-written files that replace generated equivalents after each generation run
plugins/          AI-agent plugin manifests and skills
restish/          Restish CLI configuration
scripts/          Generation, linting, release, and smoke-test scripts
```
