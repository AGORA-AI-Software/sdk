---
name: agora-webhook-api
description: Manage Agora campaign webhook endpoints and delivery history via the public API. Use when a user wants to create, update, delete, or inspect webhook endpoints, view delivery logs, send test pings, rotate secrets, or redeliver failed events.
---

# Agora Webhook API

Use this skill for Agora's webhook management API. All operations require a bearer token from `loginWithApiKey`. Do not mention internal dashboard, admin, or Firebase-only endpoints.

## Auth Flow

Same as all Agora public API calls — exchange your API key for a bearer token first:

```bash
TOKEN=$(curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}' | jq -r .access_token)
```

Set `CAMPAIGN_ID` to the campaign you want to manage.

---

## Operations

### List available event types

```bash
curl -sS https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/events \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora list-webhook-event-types $CAMPAIGN_ID
```

---

### Create a webhook endpoint

```bash
curl -sS -X POST https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -d '{
    "url": "https://hooks.example.com/agora",
    "description": "Production lead handler",
    "subscribed_events": ["lead.created", "lead.status_changed"],
    "is_enabled": true
  }'
```

Restish:
```bash
restish agora create-webhook-endpoint $CAMPAIGN_ID \
  '{"url":"https://hooks.example.com/agora","subscribed_events":["lead.created","lead.status_changed"],"is_enabled":true}'
```

> **Important:** The `secret` field in the response is only shown once. Store it securely — use it to verify `X-Agora-Signature-256` on incoming requests.

---

### List webhook endpoints

```bash
curl -sS https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora list-webhook-endpoints $CAMPAIGN_ID
```

---

### Update a webhook endpoint

```bash
curl -sS -X PATCH \
  https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints/$ENDPOINT_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json' \
  -d '{"is_enabled": false}'
```

Restish:
```bash
restish agora update-webhook-endpoint $CAMPAIGN_ID $ENDPOINT_ID '{"is_enabled":false}'
```

---

### Delete a webhook endpoint

```bash
curl -sS -X DELETE \
  https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints/$ENDPOINT_ID \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora delete-webhook-endpoint $CAMPAIGN_ID $ENDPOINT_ID
```

---

### Send a test ping

```bash
curl -sS -X POST \
  https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints/$ENDPOINT_ID/test \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora test-webhook-endpoint $CAMPAIGN_ID $ENDPOINT_ID
```

---

### List delivery history

```bash
# All deliveries (default 50)
curl -sS \
  "https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints/$ENDPOINT_ID/deliveries" \
  -H "Authorization: Bearer $TOKEN"

# Failed only
curl -sS \
  "https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints/$ENDPOINT_ID/deliveries?success=false&limit=20" \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora list-webhook-deliveries $CAMPAIGN_ID $ENDPOINT_ID
restish agora list-webhook-deliveries $CAMPAIGN_ID $ENDPOINT_ID --success=false --limit=20
```

---

### Redeliver a past delivery

```bash
curl -sS -X POST \
  https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/deliveries/$DELIVERY_ID/redeliver \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora redeliver-webhook-delivery $CAMPAIGN_ID $DELIVERY_ID
```

---

### Rotate the signing secret

```bash
curl -sS -X POST \
  https://core.agoraai.tech/api/v1/campaigns/$CAMPAIGN_ID/webhooks/endpoints/$ENDPOINT_ID/regenerate-secret \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora regenerate-webhook-secret $CAMPAIGN_ID $ENDPOINT_ID
```

> **Important:** The old secret stops working immediately. Update your receiver before rotating in production. See the [secret rotation guide](https://docs.agoraai.tech/webhooks/secret-rotation/).

---

## SDK Examples

### Python

```python
import agora_public_api
from agora_public_api.api import authentication_api, webhooks_api
from agora_public_api.model.api_key_token_request import ApiKeyTokenRequest
from agora_public_api.model.webhook_endpoint_create import WebhookEndpointCreate

configuration = agora_public_api.Configuration(host="https://core.agoraai.tech/api/v1")

with agora_public_api.ApiClient(configuration) as client:
    auth = authentication_api.AuthenticationApi(client)
    token = auth.login_with_api_key(ApiKeyTokenRequest(api_key="agora_live_REDACTED"))
    configuration.access_token = token.access_token

    hooks = webhooks_api.WebhooksApi(client)

    # Create endpoint
    endpoint = hooks.create_webhook_endpoint(
        campaign_id=1,
        webhook_endpoint_create=WebhookEndpointCreate(
            url="https://hooks.example.com/agora",
            subscribed_events=["lead.created", "lead.status_changed"],
            is_enabled=True,
        )
    )
    print(f"Created endpoint {endpoint.id}, secret={endpoint.secret}")

    # Send test ping
    delivery = hooks.test_webhook_endpoint(campaign_id=1, endpoint_id=endpoint.id)
    print(f"Test ping: {delivery.is_successful} ({delivery.response_status})")
```

### TypeScript

```typescript
import {
  AuthenticationApi,
  WebhooksApi,
  Configuration,
} from "@agora-ai/public-api";

const config = new Configuration({ basePath: "https://core.agoraai.tech/api/v1" });
const { accessToken } = await new AuthenticationApi(config).loginWithApiKey({
  apiKeyTokenRequest: { apiKey: "agora_live_REDACTED" },
});

const hooks = new WebhooksApi(
  new Configuration({ basePath: "https://core.agoraai.tech/api/v1", accessToken })
);

// Create endpoint
const endpoint = await hooks.createWebhookEndpoint({
  campaignId: 1,
  webhookEndpointCreate: {
    url: "https://hooks.example.com/agora",
    subscribedEvents: ["lead.created", "lead.status_changed"],
    isEnabled: true,
  },
});
console.log(`Created ${endpoint.id}, secret=${endpoint.secret}`);

// Test ping
const delivery = await hooks.testWebhookEndpoint({
  campaignId: 1,
  endpointId: endpoint.id,
});
console.log(`Test: ${delivery.isSuccessful} (${delivery.responseStatus})`);
```

### Java

```java
import ai.agora.publicapi.*;
import ai.agora.publicapi.api.*;
import ai.agora.publicapi.model.*;

ApiClient client = new ApiClient();
client.setBasePath("https://core.agoraai.tech/api/v1");

ApiKeyTokenResponse token = new AuthenticationApi(client)
    .loginWithApiKey(new ApiKeyTokenRequest().apiKey("agora_live_REDACTED"));
((HttpBearerAuth) client.getAuthentication("bearerAuth"))
    .setBearerToken(token.getAccessToken());

WebhooksApi hooks = new WebhooksApi(client);

// Create endpoint
WebhookEndpointResponse endpoint = hooks.createWebhookEndpoint(1,
    new WebhookEndpointCreate()
        .url("https://hooks.example.com/agora")
        .subscribedEvents(List.of("lead.created", "lead.status_changed"))
        .isEnabled(true));
System.out.println("Created " + endpoint.getId() + ", secret=" + endpoint.getSecret());

// Test ping
WebhookDeliveryResponse delivery = hooks.testWebhookEndpoint(1, endpoint.getId());
System.out.println("Test: " + delivery.getIsSuccessful() + " (" + delivery.getResponseStatus() + ")");
```

### Go

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

    token, _, _ := client.AuthenticationAPI.LoginWithApiKey(ctx).
        ApiKeyTokenRequest(agora.ApiKeyTokenRequest{ApiKey: "agora_live_REDACTED"}).
        Execute()
    ctx = context.WithValue(ctx, agora.ContextAccessToken, token.GetAccessToken())

    url := "https://hooks.example.com/agora"
    endpoint, _, _ := client.WebhooksAPI.CreateWebhookEndpoint(ctx, 1).
        WebhookEndpointCreate(agora.WebhookEndpointCreate{
            Url:               url,
            SubscribedEvents:  []string{"lead.created", "lead.status_changed"},
            IsEnabled:         agora.PtrBool(true),
        }).Execute()
    fmt.Printf("Created %d, secret=%s\n", endpoint.GetId(), endpoint.GetSecret())

    delivery, _, _ := client.WebhooksAPI.TestWebhookEndpoint(ctx, 1, endpoint.GetId()).Execute()
    fmt.Printf("Test: %v (%d)\n", delivery.GetIsSuccessful(), delivery.GetResponseStatus())
}
```

---

## Guidance

- Always store the `secret` from `createWebhookEndpoint` and `regenerateWebhookSecret` immediately — it is never shown again.
- Use `testWebhookEndpoint` to verify connectivity and signature verification before subscribing to real events.
- Use `listWebhookDeliveries` with `success=false` to triage failures — the `response_body` and `response_status` show what your server returned.
- When rotating secrets, update your receiver first, then call `regenerateWebhookSecret`. See the [rotation guide](https://docs.agoraai.tech/webhooks/secret-rotation/).
- Use synthetic data in all examples. Never log bearer tokens or signing secrets.
