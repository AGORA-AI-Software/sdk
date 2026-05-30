# ApiKeyTokenResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**access_token** | **str** | Short-lived bearer JWT. Do not log this value. | 
**token_type** | **str** |  | 
**expires_in** | **int** |  | 

## Example

```python
from agora_public_api.models.api_key_token_response import ApiKeyTokenResponse

# TODO update the JSON string below
json = "{}"
# create an instance of ApiKeyTokenResponse from a JSON string
api_key_token_response_instance = ApiKeyTokenResponse.from_json(json)
# print the JSON string representation of the object
print(ApiKeyTokenResponse.to_json())

# convert the object into a dict
api_key_token_response_dict = api_key_token_response_instance.to_dict()
# create an instance of ApiKeyTokenResponse from a dict
api_key_token_response_from_dict = ApiKeyTokenResponse.from_dict(api_key_token_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


