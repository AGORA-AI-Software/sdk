---
name: agora-sdk-usage
description: Generate working application code using the AGORA Public API generated SDKs (Python, TypeScript, Java, Go). Use when a user is building a service, script, or integration for API-key authentication, compliant lead uploads (with disclaimer_version), or webhook health monitoring.
---

# AGORA SDK Usage

Produce ready-to-run, compile-verified code for the generated AGORA Public API SDKs.

## Current SDK Coverage vs. Full Live API

The generated SDK clients in `AGORA-AI-Software/sdk` currently wrap **5 operations**:

| Operation | SDK Method (Python / TS / Java / Go) |
|---|---|
| `POST /api/v1/auth/api-key/token` | `login_with_api_key` / `loginWithApiKey` / `loginWithApiKey` / `LoginWithApiKey` |
| `POST /api/v1/leads/upload` | `upload_leads` / `uploadLeads` / `uploadLeads` / `UploadLeads` |
| `GET /api/v1/webhooks/{campaign_id}/events` | `list_webhook_event_types` / `listWebhookEventTypes` / `listWebhookEventTypes` / `ListWebhookEventTypes` |
| `GET /api/v1/webhooks/{campaign_id}/endpoints` | `list_webhook_endpoints` / `listWebhookEndpoints` / `listWebhookEndpoints` / `ListWebhookEndpoints` |
| `GET /api/v1/webhooks/{campaign_id}/endpoints/{endpoint_id}/health` | `get_webhook_endpoint_health` / `getWebhookEndpointHealth` / `getWebhookEndpointHealth` / `GetWebhookEndpointHealth` |

> **Important:** The live AGORA Public API also exposes **33 additional endpoints** (Compliance disclaimer fetch, Leads CRUD/status/batch polling, Campaigns/Blueprints/Readiness/Automations, and Calls sync). Do **not** invent SDK client classes for those — call them via standard HTTP alongside the SDK bearer token (see `agora-public-api`, `agora-lead-upload-api`, and `agora-campaigns-and-calls-api`).

## Available SDKs & Installation

| Language | Package / Module | Notes |
|---|---|---|
| Python | `agora_public_api` (`sdks/python`) | `pip install -e ./sdks/python` (or `pip install agora-public-api` once published to PyPI) |
| TypeScript | `@agora-ai/public-api` (`sdks/typescript`) | Workspace/repo install (or `npm install @agora-ai/public-api` once published to npm) |
| Java | `ai.agora:agora-public-api` (`sdks/java`) | Local Maven build `mvn install` (or Maven Central once published) |
| Go | `github.com/AGORA-AI-Software/sdk/sdks/go` | `go get github.com/AGORA-AI-Software/sdk/sdks/go` (works directly via Git tags) |

## Mandatory Auth & Compliance Flow

1. Fetch the current DNC/TCPA agreement `version` from `GET https://core.agoraai.tech/api/v1/legal/documents/lead-upload-compliance` (unauthenticated). Never hardcode `"v1.0"`.
2. Call `loginWithApiKey` with the long-lived API key to get a **300-second** bearer JWT.
3. Configure the bearer token on the SDK client and pass both `compliance_acknowledged: true` and `disclaimer_version` on `uploadLeads`.
4. Refresh the bearer token on `401` and re-fetch the disclaimer on `400 disclaimer_version_mismatch`.

---

## Python

> Note: Generated model modules live under `agora_public_api.models` (**plural**), not `model`.

```python
import urllib.request
import json
import agora_public_api
from agora_public_api.api import authentication_api, leads_api
from agora_public_api.models.api_key_token_request import ApiKeyTokenRequest
from agora_public_api.models.lead_input import LeadInput
from agora_public_api.models.lead_upload_request import LeadUploadRequest

BASE_HOST = "https://core.agoraai.tech"

# 1. Fetch current compliance disclaimer version (unauthenticated)
with urllib.request.urlopen(f"{BASE_HOST}/api/v1/legal/documents/lead-upload-compliance") as resp:
    disclaimer_version = json.load(resp)["version"]

configuration = agora_public_api.Configuration(host=f"{BASE_HOST}/api/v1")

with agora_public_api.ApiClient(configuration) as client:
    # 2. Exchange API key for 300s bearer JWT
    auth = authentication_api.AuthenticationApi(client)
    token_response = auth.login_with_api_key(
        ApiKeyTokenRequest(api_key="agora_live_REDACTED")
    )

    # 3. Upload leads with compliance_acknowledged + disclaimer_version
    configuration.access_token = token_response.access_token
    leads = leads_api.LeadsApi(client)
    response = leads.upload_leads(
        LeadUploadRequest(
            campaign_id=1,
            leads=[
                LeadInput(
                    first_name="Jane",
                    last_name="Doe",
                    email="jane.doe@example.test",
                    phone="+15551234567",
                )
            ],
            compliance_acknowledged=True,
            disclaimer_version=disclaimer_version,
        )
    )
    print(response.status, response.import_id)
```

---

## TypeScript

```typescript
import { AuthenticationApi, LeadsApi, Configuration } from "@agora-ai/public-api";

const baseHost = "https://core.agoraai.tech";
const basePath = `${baseHost}/api/v1`;

// 1. Fetch current compliance disclaimer version (unauthenticated)
const disclaimerRes = await fetch(`${basePath}/legal/documents/lead-upload-compliance`);
const { version: disclaimerVersion } = (await disclaimerRes.json()) as { version: string };

// 2. Exchange API key for 300s bearer JWT
const auth = new AuthenticationApi(new Configuration({ basePath }));
const { accessToken } = await auth.loginWithApiKey({
  apiKeyTokenRequest: { apiKey: "agora_live_REDACTED" },
});

// 3. Upload leads with complianceAcknowledged + disclaimerVersion
const leads = new LeadsApi(new Configuration({ basePath, accessToken }));
const response = await leads.uploadLeads({
  leadUploadRequest: {
    campaignId: 1,
    leads: [{ firstName: "Jane", lastName: "Doe", email: "jane.doe@example.test", phone: "+15551234567" }],
    complianceAcknowledged: true,
    disclaimerVersion,
  },
});

console.log(response.status, response.importId);
```

---

## Java

```java
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.api.AuthenticationApi;
import ai.agora.publicapi.api.LeadsApi;
import ai.agora.publicapi.auth.HttpBearerAuth;
import ai.agora.publicapi.model.ApiKeyTokenRequest;
import ai.agora.publicapi.model.ApiKeyTokenResponse;
import ai.agora.publicapi.model.LeadInput;
import ai.agora.publicapi.model.LeadUploadRequest;
import ai.agora.publicapi.model.LeadUploadResponse;
import java.util.List;

// Fetch current version dynamically from GET https://core.agoraai.tech/api/v1/legal/documents/lead-upload-compliance
String disclaimerVersion = fetchCurrentDisclaimerVersion();

ApiClient client = new ApiClient();
client.setBasePath("https://core.agoraai.tech/api/v1");

AuthenticationApi auth = new AuthenticationApi(client);
ApiKeyTokenResponse tokenResponse = auth.loginWithApiKey(
    new ApiKeyTokenRequest().apiKey("agora_live_REDACTED")
);

((HttpBearerAuth) client.getAuthentication("bearerAuth"))
    .setBearerToken(tokenResponse.getAccessToken());

LeadsApi leads = new LeadsApi(client);
LeadUploadResponse response = leads.uploadLeads(
    new LeadUploadRequest()
        .campaignId(1)
        .leads(List.of(new LeadInput()
            .firstName("Jane")
            .lastName("Doe")
            .email("jane.doe@example.test")
            .phone("+15551234567")))
        .complianceAcknowledged(true)
        .disclaimerVersion(disclaimerVersion)
);

System.out.println(response.getStatus() + " " + response.getImportId());
```

---

## Go

> Note: `LeadInput.Phone` is a `string` value (not `*string`); use `agora.NewLeadInput("+15551234567")` or pass `Phone: "+15551234567"` directly.

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	agora "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	const baseURL = "https://core.agoraai.tech/api/v1"

	// 1. Fetch current compliance disclaimer version (unauthenticated)
	res, err := http.Get(baseURL + "/legal/documents/lead-upload-compliance")
	if err != nil {
		log.Fatal(err)
	}
	defer res.Body.Close()
	var disclaimer struct {
		Version string `json:"version"`
	}
	if err := json.NewDecoder(res.Body).Decode(&disclaimer); err != nil {
		log.Fatal(err)
	}

	cfg := agora.NewConfiguration()
	cfg.Servers = agora.ServerConfigurations{{URL: baseURL}}
	client := agora.NewAPIClient(cfg)
	ctx := context.Background()

	// 2. Exchange API key for 300s bearer JWT
	tokenResp, _, err := client.AuthenticationAPI.LoginWithApiKey(ctx).
		ApiKeyTokenRequest(*agora.NewApiKeyTokenRequest("agora_live_REDACTED")).
		Execute()
	if err != nil {
		log.Fatal(err)
	}
	ctx = context.WithValue(ctx, agora.ContextAccessToken, tokenResp.GetAccessToken())

	// 3. Upload leads with compliance_acknowledged + disclaimer_version
	req := agora.NewLeadUploadRequest(
		1,
		[]agora.LeadInput{*agora.NewLeadInput("+15551234567")},
		true,
	)
	req.SetDisclaimerVersion(disclaimer.Version)

	resp, _, err := client.LeadsAPI.UploadLeads(ctx).LeadUploadRequest(*req).Execute()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(resp.GetStatus(), resp.GetImportId())
}
```

---

## Guidance

- Use synthetic data in all examples (`example.test` emails, `+15551234567` phone numbers, `agora_live_REDACTED` keys).
- Never log API keys, bearer tokens, or real lead payloads.
- For webhook SDK usage, see `agora-webhook-api`.
- For Campaigns, Calls, or Leads CRUD/status endpoints not yet in the generated SDKs, use standard HTTP with the same bearer JWT (`agora-campaigns-and-calls-api` / `agora-lead-upload-api`).
- Prefer production (`https://core.agoraai.tech`); use `https://core-dev.agoraai.tech` only when explicitly requested.
