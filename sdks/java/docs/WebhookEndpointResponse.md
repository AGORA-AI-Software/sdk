

# WebhookEndpointResponse


## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
|**id** | **Integer** |  |  |
|**campaignId** | **Integer** |  |  |
|**url** | **URI** |  |  |
|**description** | **String** |  |  [optional] |
|**subscribedEvents** | **List&lt;String&gt;** |  |  |
|**isEnabled** | **Boolean** |  |  |
|**createdAt** | **OffsetDateTime** |  |  |
|**secret** | **String** | Signing secret. Only returned on creation — store it securely. |  [optional] |
|**lastDeliveryIsSuccessful** | **Boolean** | Outcome of the most recent delivery attempt, or null if no deliveries yet. |  [optional] |



