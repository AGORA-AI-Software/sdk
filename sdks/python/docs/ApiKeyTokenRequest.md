# ApiKeyTokenRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**api_key** | **str** | Agora API key. Never log or persist this value outside secure credential storage. | 

## Example

```python
from agora_public_api.models.api_key_token_request import ApiKeyTokenRequest

# TODO update the JSON string below
json = "{}"
# create an instance of ApiKeyTokenRequest from a JSON string
api_key_token_request_instance = ApiKeyTokenRequest.from_json(json)
# print the JSON string representation of the object
print(ApiKeyTokenRequest.to_json())

# convert the object into a dict
api_key_token_request_dict = api_key_token_request_instance.to_dict()
# create an instance of ApiKeyTokenRequest from a dict
api_key_token_request_from_dict = ApiKeyTokenRequest.from_dict(api_key_token_request_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


