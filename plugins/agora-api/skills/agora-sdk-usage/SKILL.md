---
name: agora-sdk-usage
description: Generate application code using the Agora public API SDKs (Python, TypeScript, Java, Go). Use when a user is writing a service, script, or integration and needs working SDK snippets for authentication and lead upload.
---

# Agora SDK Usage

Use this skill to produce ready-to-run SDK code for the Agora public API.

## Available SDKs

| Language | Package |
|---|---|
| Python | `agora-public-api` (pip) |
| TypeScript | `@agora-ai/public-api` (npm) |
| Java | `ai.agora:agora-public-api` (Maven) |
| Go | `github.com/AGORA-AI-Software/sdk/sdks/go` |

## Auth Flow

1. Call `loginWithApiKey` with the long-lived API key to receive a short-lived bearer token.
2. Set the bearer token on the client before calling any other endpoint.
3. Never log API keys, bearer tokens, or real lead data.

---

## Python

```python
import agora_public_api
from agora_public_api.api import authentication_api, leads_api
from agora_public_api.model.api_key_token_request import ApiKeyTokenRequest
from agora_public_api.model.lead_upload_request import LeadUploadRequest
from agora_public_api.model.lead_input import LeadInput

configuration = agora_public_api.Configuration(
    host="https://core.agoraai.tech/api/v1"
)

with agora_public_api.ApiClient(configuration) as client:
    auth = authentication_api.AuthenticationApi(client)
    token_response = auth.login_with_api_key(
        ApiKeyTokenRequest(api_key="agora_live_REDACTED")
    )

    configuration.access_token = token_response.access_token
    leads = leads_api.LeadsApi(client)
    response = leads.upload_leads(
        LeadUploadRequest(
            campaign_id=1,
            leads=[LeadInput(
                first_name="Jane",
                last_name="Doe",
                email="jane.doe@example.test",
                phone="+15551234567",
            )],
            compliance_acknowledged=True,
        )
    )
    print(response.status)
```

---

## TypeScript

```typescript
import { AuthenticationApi, LeadsApi, Configuration } from "@agora-ai/public-api";

const config = new Configuration({ basePath: "https://core.agoraai.tech/api/v1" });

const auth = new AuthenticationApi(config);
const { accessToken } = await auth.loginWithApiKey({
  apiKeyTokenRequest: { apiKey: "agora_live_REDACTED" },
});

const leads = new LeadsApi(
  new Configuration({ basePath: "https://core.agoraai.tech/api/v1", accessToken })
);

const response = await leads.uploadLeads({
  leadUploadRequest: {
    campaignId: 1,
    leads: [{ firstName: "Jane", lastName: "Doe", phone: "+15551234567" }],
    complianceAcknowledged: true,
  },
});

console.log(response.status);
```

---

## Java

```java
import ai.agora.publicapi.*;
import ai.agora.publicapi.api.*;
import ai.agora.publicapi.auth.HttpBearerAuth;
import ai.agora.publicapi.model.*;
import java.util.List;

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
            .phone("+15551234567")))
        .complianceAcknowledged(true)
);

System.out.println(response.getStatus());
```

---

## Go

```go
package main

import (
    "context"
    "fmt"

    agora "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
    cfg := agora.NewConfiguration()
    cfg.Servers = agora.ServerConfigurations{{URL: "https://core.agoraai.tech/api/v1"}}
    client := agora.NewAPIClient(cfg)
    ctx := context.Background()

    tokenResp, _, err := client.AuthenticationAPI.LoginWithApiKey(ctx).
        ApiKeyTokenRequest(agora.ApiKeyTokenRequest{ApiKey: "agora_live_REDACTED"}).
        Execute()
    if err != nil {
        panic(err)
    }

    ctx = context.WithValue(ctx, agora.ContextAccessToken, tokenResp.GetAccessToken())

    phone := "+15551234567"
    resp, _, err := client.LeadsAPI.UploadLeads(ctx).
        LeadUploadRequest(agora.LeadUploadRequest{
            CampaignId:             1,
            Leads:                  []agora.LeadInput{{Phone: &phone}},
            ComplianceAcknowledged: true,
        }).
        Execute()
    if err != nil {
        panic(err)
    }

    fmt.Println(resp.GetStatus())
}
```

---

## Guidance

- Use synthetic data in all examples (`example.test` emails, `+15551234567` phone numbers).
- When the user has an existing HTTP client, show how to pass the bearer token as a header rather than reconfiguring the SDK client.
- When the user asks for error handling, show how to inspect the `ApiException` / error return and map status codes to retry or fail-fast behavior.
- Prefer the production host. Use `core-dev.agoraai.tech` only when the user explicitly asks for the development environment.
