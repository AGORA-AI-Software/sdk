# WebhookEndpointHealth


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**endpoint_id** | **int** |  | 
**url** | **str** |  | 
**is_enabled** | **bool** |  | 
**total_deliveries** | **int** | Total number of delivery attempts recorded. | 
**successful_deliveries** | **int** | Deliveries that received a 2xx response within 10 seconds. | 
**failed_deliveries** | **int** | Deliveries that timed out or received a non-2xx response. | 
**success_rate** | **float** | Ratio of successful to total deliveries (0–1). Null if no deliveries yet. | [optional] 
**last_delivery_at** | **datetime** | Timestamp of the most recent delivery attempt. | [optional] 
**last_delivery_is_successful** | **bool** | Outcome of the most recent delivery attempt. | [optional] 
**avg_duration_ms** | **float** | Average round-trip time in milliseconds across all recorded deliveries. | [optional] 

## Example

```python
from agora_public_api.models.webhook_endpoint_health import WebhookEndpointHealth

# TODO update the JSON string below
json = "{}"
# create an instance of WebhookEndpointHealth from a JSON string
webhook_endpoint_health_instance = WebhookEndpointHealth.from_json(json)
# print the JSON string representation of the object
print(WebhookEndpointHealth.to_json())

# convert the object into a dict
webhook_endpoint_health_dict = webhook_endpoint_health_instance.to_dict()
# create an instance of WebhookEndpointHealth from a dict
webhook_endpoint_health_from_dict = WebhookEndpointHealth.from_dict(webhook_endpoint_health_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


