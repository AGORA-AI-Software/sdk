---
name: agora-webhook-api
description: Query Agora webhook configuration and delivery health via the public API. Use when a user wants to list their webhook endpoints, check what event types are available, or monitor delivery health and success rates for a campaign's webhook integration.
---

# Agora Webhook API

Read-only public API for webhook observability. Use this skill to list endpoint configuration and check delivery health. Creating, updating, deleting, testing, or rotating secrets for endpoints is done through the Agora dashboard — those are not public API operations.

All operations require a bearer token from `loginWithApiKey`.

## Auth Flow

```bash
TOKEN=$(curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}' | jq -r .access_token)
```

Set `CAMPAIGN_ID` to the campaign you want to inspect.

---

## Operations

### List available event types

What events can I subscribe to?

```bash
curl -sS https://core.agoraai.tech/api/v1/webhooks/$CAMPAIGN_ID/events \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora list-webhook-event-types $CAMPAIGN_ID
```

Response:
```json
["lead.created", "leads.bulk_created", "lead.status_changed", "lead.converted",
 "call.started", "call.completed", "form.submitted"]
```

---

### List webhook endpoints

What endpoints are configured on my campaign?

```bash
curl -sS https://core.agoraai.tech/api/v1/webhooks/$CAMPAIGN_ID/endpoints \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora list-webhook-endpoints $CAMPAIGN_ID
```

Returns `WebhookEndpointSummary[]` — URL, subscribed events, enabled state, last delivery outcome. No secrets are included.

---

### Get delivery health for an endpoint

Is my endpoint healthy? What's the success rate?

```bash
curl -sS \
  https://core.agoraai.tech/api/v1/webhooks/$CAMPAIGN_ID/endpoints/$ENDPOINT_ID/health \
  -H "Authorization: Bearer $TOKEN"
```

Restish:
```bash
restish agora get-webhook-endpoint-health $CAMPAIGN_ID $ENDPOINT_ID
```

Example response:
```json
{
  "endpoint_id": 12,
  "url": "https://hooks.example.com/agora",
  "is_enabled": true,
  "total_deliveries": 843,
  "successful_deliveries": 841,
  "failed_deliveries": 2,
  "success_rate": 0.9976,
  "last_delivery_at": "2026-06-17T14:22:01Z",
  "last_delivery_is_successful": true,
  "avg_duration_ms": 142.3
}
```

Alert on `success_rate < 0.95` or `last_delivery_at` being stale relative to expected event volume.

---

## SDK Examples

### Python

```python
import agora_public_api
from agora_public_api.api import authentication_api, webhooks_api
from agora_public_api.model.api_key_token_request import ApiKeyTokenRequest

configuration = agora_public_api.Configuration(host="https://core.agoraai.tech/api/v1")

with agora_public_api.ApiClient(configuration) as client:
    token = authentication_api.AuthenticationApi(client).login_with_api_key(
        ApiKeyTokenRequest(api_key="agora_live_REDACTED")
    )
    configuration.access_token = token.access_token

    hooks = webhooks_api.WebhooksApi(client)

    # List endpoints
    endpoints = hooks.list_webhook_endpoints(campaign_id=1)
    for ep in endpoints:
        print(f"{ep.id}: {ep.url} — enabled={ep.is_enabled}")

    # Check health of a specific endpoint
    health = hooks.get_webhook_endpoint_health(campaign_id=1, endpoint_id=endpoints[0].id)
    print(f"Success rate: {health.success_rate:.1%}, avg latency: {health.avg_duration_ms}ms")
```

### TypeScript

```typescript
import { AuthenticationApi, WebhooksApi, Configuration } from "@agora-ai/public-api";

const config = new Configuration({ basePath: "https://core.agoraai.tech/api/v1" });
const { accessToken } = await new AuthenticationApi(config).loginWithApiKey({
  apiKeyTokenRequest: { apiKey: "agora_live_REDACTED" },
});

const hooks = new WebhooksApi(
  new Configuration({ basePath: "https://core.agoraai.tech/api/v1", accessToken })
);

const endpoints = await hooks.listWebhookEndpoints({ campaignId: 1 });
for (const ep of endpoints) {
  const health = await hooks.getWebhookEndpointHealth({ campaignId: 1, endpointId: ep.id });
  console.log(`${ep.url}: ${(health.successRate! * 100).toFixed(1)}% success, ${health.avgDurationMs}ms avg`);
}
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

List<WebhookEndpointSummary> endpoints = hooks.listWebhookEndpoints(1);
for (WebhookEndpointSummary ep : endpoints) {
    WebhookEndpointHealth health = hooks.getWebhookEndpointHealth(1, ep.getId());
    System.out.printf("%s: %.1f%% success%n", ep.getUrl(), health.getSuccessRate() * 100);
}
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

    endpoints, _, _ := client.WebhooksAPI.ListWebhookEndpoints(ctx, 1).Execute()
    for _, ep := range endpoints {
        health, _, _ := client.WebhooksAPI.GetWebhookEndpointHealth(ctx, 1, ep.GetId()).Execute()
        fmt.Printf("%s: %.1f%% success, %.0fms avg\n",
            ep.GetUrl(), health.GetSuccessRate()*100, health.GetAvgDurationMs())
    }
}
```

---

## Guidance

- Use `listWebhookEndpoints` to verify which endpoints are active before debugging a missing delivery.
- Use `getWebhookEndpointHealth` in monitoring/alerting pipelines — alert on `success_rate < 0.95` or stale `last_delivery_at`.
- Creating, updating, disabling, deleting, or rotating secrets for endpoints is done through the Agora dashboard.
- Use `listWebhookEventTypes` to enumerate valid values when building UI that lets users choose subscriptions.
