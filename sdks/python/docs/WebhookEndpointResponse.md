# WebhookEndpointResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**campaign_id** | **int** |  | 
**url** | **str** |  | 
**description** | **str** |  | [optional] 
**subscribed_events** | **List[str]** |  | 
**is_enabled** | **bool** |  | 
**created_at** | **datetime** |  | 
**secret** | **str** | Signing secret. Only returned on creation — store it securely. | [optional] 
**last_delivery_is_successful** | **bool** | Outcome of the most recent delivery attempt, or null if no deliveries yet. | [optional] 

## Example

```python
from agora_public_api.models.webhook_endpoint_response import WebhookEndpointResponse

# TODO update the JSON string below
json = "{}"
# create an instance of WebhookEndpointResponse from a JSON string
webhook_endpoint_response_instance = WebhookEndpointResponse.from_json(json)
# print the JSON string representation of the object
print(WebhookEndpointResponse.to_json())

# convert the object into a dict
webhook_endpoint_response_dict = webhook_endpoint_response_instance.to_dict()
# create an instance of WebhookEndpointResponse from a dict
webhook_endpoint_response_from_dict = WebhookEndpointResponse.from_dict(webhook_endpoint_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


