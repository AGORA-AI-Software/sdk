# WebhookEndpointUpdate


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**url** | **str** | New destination URL. | [optional] 
**description** | **str** |  | [optional] 
**subscribed_events** | **List[str]** | Replaces the full subscribed event list. | [optional] 
**is_enabled** | **bool** |  | [optional] 

## Example

```python
from agora_public_api.models.webhook_endpoint_update import WebhookEndpointUpdate

# TODO update the JSON string below
json = "{}"
# create an instance of WebhookEndpointUpdate from a JSON string
webhook_endpoint_update_instance = WebhookEndpointUpdate.from_json(json)
# print the JSON string representation of the object
print(WebhookEndpointUpdate.to_json())

# convert the object into a dict
webhook_endpoint_update_dict = webhook_endpoint_update_instance.to_dict()
# create an instance of WebhookEndpointUpdate from a dict
webhook_endpoint_update_from_dict = WebhookEndpointUpdate.from_dict(webhook_endpoint_update_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


