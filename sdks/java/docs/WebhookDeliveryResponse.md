

# WebhookDeliveryResponse


## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
|**id** | **Integer** |  |  |
|**endpointId** | **Integer** |  |  |
|**eventType** | **String** |  |  |
|**payload** | **Object** | Full JSON payload that was sent to the endpoint. |  |
|**responseStatus** | **Integer** | HTTP status code returned by the endpoint, or null if the request failed to connect. |  [optional] |
|**responseBody** | **String** | First 1 KB of the response body. |  [optional] |
|**durationMs** | **Integer** | Round-trip time in milliseconds. |  [optional] |
|**isSuccessful** | **Boolean** | True if the endpoint returned a 2xx status within 10 seconds. |  |
|**attemptNumber** | **Integer** | 1 for the original delivery, 2 for the automatic retry. |  |
|**deliveredAt** | **OffsetDateTime** |  |  |
|**redeliveryOfId** | **Integer** | ID of the original delivery if this is a manual redeliver, otherwise null. |  [optional] |



