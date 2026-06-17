

# WebhookEndpointSummary


## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
|**id** | **Integer** |  |  |
|**campaignId** | **Integer** |  |  |
|**url** | **URI** | Destination URL events are delivered to. |  |
|**description** | **String** |  |  [optional] |
|**subscribedEvents** | **List&lt;String&gt;** | Event types this endpoint is subscribed to. |  |
|**isEnabled** | **Boolean** |  |  |
|**createdAt** | **OffsetDateTime** |  |  |
|**lastDeliveryIsSuccessful** | **Boolean** | Outcome of the most recent delivery attempt, or null if no deliveries yet. |  [optional] |



