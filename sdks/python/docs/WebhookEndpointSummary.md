# WebhookEndpointSummary


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**campaign_id** | **int** |  | 
**url** | **str** | Destination URL events are delivered to. | 
**description** | **str** |  | [optional] 
**subscribed_events** | **List[str]** | Event types this endpoint is subscribed to. | 
**is_enabled** | **bool** |  | 
**created_at** | **datetime** |  | 
**last_delivery_is_successful** | **bool** | Outcome of the most recent delivery attempt, or null if no deliveries yet. | [optional] 

## Example

```python
from agora_public_api.models.webhook_endpoint_summary import WebhookEndpointSummary

# TODO update the JSON string below
json = "{}"
# create an instance of WebhookEndpointSummary from a JSON string
webhook_endpoint_summary_instance = WebhookEndpointSummary.from_json(json)
# print the JSON string representation of the object
print(WebhookEndpointSummary.to_json())

# convert the object into a dict
webhook_endpoint_summary_dict = webhook_endpoint_summary_instance.to_dict()
# create an instance of WebhookEndpointSummary from a dict
webhook_endpoint_summary_from_dict = WebhookEndpointSummary.from_dict(webhook_endpoint_summary_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


