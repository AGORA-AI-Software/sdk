

# WebhookEndpointCreate


## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
|**url** | **URI** | HTTPS URL Agora will POST events to. |  |
|**description** | **String** | Optional human-readable label for this endpoint. |  [optional] |
|**subscribedEvents** | **List&lt;String&gt;** | Event types to subscribe to. Use &#x60;listWebhookEventTypes&#x60; for valid values. |  [optional] |
|**isEnabled** | **Boolean** | Whether the endpoint should receive deliveries. |  [optional] |



