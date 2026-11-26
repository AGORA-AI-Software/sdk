---
name: agora-webhook-api
description: Query AGORA webhook configuration and delivery health via the public API (curl, Restish, and Python/TypeScript/Java/Go SDKs). Use when a user wants to list configured campaign webhook endpoints, enumerate subscribable webhook event types, or monitor delivery success rates and latency.
---

# AGORA Webhook API

Read-only public API for webhook observability (3 endpoints). Use this skill to inspect endpoint configuration and monitor delivery reliability.

> **Scope Boundary:** Creating, updating, disabling, deleting, testing, or rotating signing secrets for webhook endpoints is done through the **AGORA Web App** — those are not public API operations.

All operations require a 300-second bearer JWT exchanged via `POST /api/v1/auth/api-key/token`. Never pass `agora_live_...` directly as a Bearer token.

## Auth Flow

```bash
TOKEN=$(curl -sS -X POST https://core.agoraai.tech/api/v1/auth/api-key/token \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_REDACTED"}' | jq -r .access_token)
```

Discover valid `CAMPAIGN_ID` values with `GET /api/v1/campaigns/accessible`.

---

## Operations

### 1. List Available Event Types (`listWebhookEventTypes`)

```bash
curl -sS "https://core.agoraai.tech/api/v1/webhooks/${CAMPAIGN_ID}/events" \
  -H "Authorization: Bearer ${TOKEN}"
```

Restish:
```bash
restish agora list-webhook-event-types "${CAMPAIGN_ID}"
```

Current live event types (8 total):
```json
[
  "lead.created",
  "leads.bulk_created",
  "lead.status_changed",
  "lead.converted",
  "call.started",
  "call.completed",
  "call.outcome_recorded",
  "form.submitted"
]
```

---

### 2. List Webhook Endpoints (`listWebhookEndpoints`)

```bash
curl -sS "https://core.agoraai.tech/api/v1/webhooks/${CAMPAIGN_ID}/endpoints" \
  -H "Authorization: Bearer ${TOKEN}"
```

Restish:
```bash
restish agora list-webhook-endpoints "${CAMPAIGN_ID}"
```

Returns `WebhookEndpointSummary[]` (`id`, `campaign_id`, `url`, `description`, `subscribed_events`, `is_enabled`, `created_at`, `last_delivery_is_successful`). Signing secrets are never returned.

---

### 3. Get Delivery Health for an Endpoint (`getWebhookEndpointHealth`)

```bash
curl -sS \
  "https://core.agoraai.tech/api/v1/webhooks/${CAMPAIGN_ID}/endpoints/${ENDPOINT_ID}/health" \
  -H "Authorization: Bearer ${TOKEN}"
```

Restish:
```bash
restish agora get-webhook-endpoint-health "${CAMPAIGN_ID}" "${ENDPOINT_ID}"
```

Example response:
```json
{
  "endpoint_id": 12,
  "url": "https://hooks.example.test/agora",
  "is_enabled": true,
  "total_deliveries": 843,
  "successful_deliveries": 841,
  "failed_deliveries": 2,
  "success_rate": 0.9976,
  "last_delivery_at": "2026-11-17T14:22:01Z",
  "last_delivery_is_successful": true,
  "avg_duration_ms": 142.3
}
```

Alert when `success_rate < 0.95` (when `total_deliveries > 0`) or `last_delivery_at` is stale relative to expected event volume.

---

## SDK Examples

### Python

```python
import agora_public_api
from agora_public_api.api import authentication_api, webhooks_api
from agora_public_api.models.api_key_token_request import ApiKeyTokenRequest

configuration = agora_public_api.Configuration(host="https://core.agoraai.tech/api/v1")

with agora_public_api.ApiClient(configuration) as client:
    token = authentication_api.AuthenticationApi(client).login_with_api_key(
        ApiKeyTokenRequest(api_key="agora_live_REDACTED")
    )
    configuration.access_token = token.access_token

    hooks = webhooks_api.WebhooksApi(client)

    endpoints = hooks.list_webhook_endpoints(campaign_id=1)
    for ep in endpoints:
        health = hooks.get_webhook_endpoint_health(campaign_id=1, endpoint_id=ep.id)
        rate = f"{health.success_rate:.1%}" if health.success_rate is not None else "n/a"
        print(f"{ep.id}: {ep.url} — enabled={ep.is_enabled}, success={rate}, avg={health.avg_duration_ms}ms")
```

### TypeScript

```typescript
import { AuthenticationApi, WebhooksApi, Configuration } from "@agora-ai/public-api";

const basePath = "https://core.agoraai.tech/api/v1";
const { accessToken } = await new AuthenticationApi(new Configuration({ basePath })).loginWithApiKey({
  apiKeyTokenRequest: { apiKey: "agora_live_REDACTED" },
});

const hooks = new WebhooksApi(new Configuration({ basePath, accessToken }));

const endpoints = await hooks.listWebhookEndpoints({ campaignId: 1 });
for (const ep of endpoints) {
  const health = await hooks.getWebhookEndpointHealth({ campaignId: 1, endpointId: ep.id });
  const rate = health.successRate != null ? `${(health.successRate * 100).toFixed(1)}%` : "n/a";
  console.log(`${ep.url}: ${rate} success, ${health.avgDurationMs ?? 0}ms avg`);
}
```

### Java

```java
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.api.AuthenticationApi;
import ai.agora.publicapi.api.WebhooksApi;
import ai.agora.publicapi.auth.HttpBearerAuth;
import ai.agora.publicapi.model.ApiKeyTokenRequest;
import ai.agora.publicapi.model.ApiKeyTokenResponse;
import ai.agora.publicapi.model.WebhookEndpointHealth;
import ai.agora.publicapi.model.WebhookEndpointSummary;
import java.util.List;

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
    Double rate = health.getSuccessRate();
    System.out.printf("%s: %s success%n", ep.getUrl(), rate != null ? String.format("%.1f%%", rate * 100) : "n/a");
}
```

### Go

```go
package main

import (
	"context"
	"fmt"
	"log"

	agora "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	cfg := agora.NewConfiguration()
	cfg.Servers = agora.ServerConfigurations{{URL: "https://core.agoraai.tech/api/v1"}}
	client := agora.NewAPIClient(cfg)
	ctx := context.Background()

	token, _, err := client.AuthenticationAPI.LoginWithApiKey(ctx).
		ApiKeyTokenRequest(*agora.NewApiKeyTokenRequest("agora_live_REDACTED")).
		Execute()
	if err != nil {
		log.Fatal(err)
	}
	ctx = context.WithValue(ctx, agora.ContextAccessToken, token.GetAccessToken())

	endpoints, _, err := client.WebhooksAPI.ListWebhookEndpoints(ctx, 1).Execute()
	if err != nil {
		log.Fatal(err)
	}
	for _, ep := range endpoints {
		health, _, err := client.WebhooksAPI.GetWebhookEndpointHealth(ctx, 1, ep.GetId()).Execute()
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s: %.1f%% success, %.0fms avg\n",
			ep.GetUrl(), health.GetSuccessRate()*100, health.GetAvgDurationMs())
	}
}
```

---

## Guidance

- Call `listWebhookEndpoints` first to verify enabled endpoints before troubleshooting missing deliveries.
- Handle `null` values on `success_rate`, `last_delivery_at`, and `avg_duration_ms` when an endpoint has zero deliveries yet.
- Refresh the 300s bearer token if polling continuously in a monitoring job.
- Direct users to the AGORA Web App to create, edit, disable, delete, or rotate webhook signing secrets.
