# WebhookDeliveryResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**endpoint_id** | **int** |  | 
**event_type** | **str** |  | 
**payload** | **object** | Full JSON payload that was sent to the endpoint. | 
**response_status** | **int** | HTTP status code returned by the endpoint, or null if the request failed to connect. | [optional] 
**response_body** | **str** | First 1 KB of the response body. | [optional] 
**duration_ms** | **int** | Round-trip time in milliseconds. | [optional] 
**is_successful** | **bool** | True if the endpoint returned a 2xx status within 10 seconds. | 
**attempt_number** | **int** | 1 for the original delivery, 2 for the automatic retry. | 
**delivered_at** | **datetime** |  | 
**redelivery_of_id** | **int** | ID of the original delivery if this is a manual redeliver, otherwise null. | [optional] 

## Example

```python
from agora_public_api.models.webhook_delivery_response import WebhookDeliveryResponse

# TODO update the JSON string below
json = "{}"
# create an instance of WebhookDeliveryResponse from a JSON string
webhook_delivery_response_instance = WebhookDeliveryResponse.from_json(json)
# print the JSON string representation of the object
print(WebhookDeliveryResponse.to_json())

# convert the object into a dict
webhook_delivery_response_dict = webhook_delivery_response_instance.to_dict()
# create an instance of WebhookDeliveryResponse from a dict
webhook_delivery_response_from_dict = WebhookDeliveryResponse.from_dict(webhook_delivery_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


