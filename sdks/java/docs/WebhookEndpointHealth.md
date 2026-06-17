

# WebhookEndpointHealth


## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
|**endpointId** | **Integer** |  |  |
|**url** | **URI** |  |  |
|**isEnabled** | **Boolean** |  |  |
|**totalDeliveries** | **Integer** | Total number of delivery attempts recorded. |  |
|**successfulDeliveries** | **Integer** | Deliveries that received a 2xx response within 10 seconds. |  |
|**failedDeliveries** | **Integer** | Deliveries that timed out or received a non-2xx response. |  |
|**successRate** | **Float** | Ratio of successful to total deliveries (0–1). Null if no deliveries yet. |  [optional] |
|**lastDeliveryAt** | **OffsetDateTime** | Timestamp of the most recent delivery attempt. |  [optional] |
|**lastDeliveryIsSuccessful** | **Boolean** | Outcome of the most recent delivery attempt. |  [optional] |
|**avgDurationMs** | **Float** | Average round-trip time in milliseconds across all recorded deliveries. |  [optional] |



