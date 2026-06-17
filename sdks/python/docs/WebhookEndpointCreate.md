# WebhookEndpointCreate


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**url** | **str** | HTTPS URL Agora will POST events to. | 
**description** | **str** | Optional human-readable label for this endpoint. | [optional] 
**subscribed_events** | **List[str]** | Event types to subscribe to. Use &#x60;listWebhookEventTypes&#x60; for valid values. | [optional] [default to []]
**is_enabled** | **bool** | Whether the endpoint should receive deliveries. | [optional] [default to True]

## Example

```python
from agora_public_api.models.webhook_endpoint_create import WebhookEndpointCreate

# TODO update the JSON string below
json = "{}"
# create an instance of WebhookEndpointCreate from a JSON string
webhook_endpoint_create_instance = WebhookEndpointCreate.from_json(json)
# print the JSON string representation of the object
print(WebhookEndpointCreate.to_json())

# convert the object into a dict
webhook_endpoint_create_dict = webhook_endpoint_create_instance.to_dict()
# create an instance of WebhookEndpointCreate from a dict
webhook_endpoint_create_from_dict = WebhookEndpointCreate.from_dict(webhook_endpoint_create_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


