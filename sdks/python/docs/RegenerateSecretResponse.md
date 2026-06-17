# RegenerateSecretResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**secret** | **str** | New HMAC-SHA256 signing secret. Store securely — not shown again. | 

## Example

```python
from agora_public_api.models.regenerate_secret_response import RegenerateSecretResponse

# TODO update the JSON string below
json = "{}"
# create an instance of RegenerateSecretResponse from a JSON string
regenerate_secret_response_instance = RegenerateSecretResponse.from_json(json)
# print the JSON string representation of the object
print(RegenerateSecretResponse.to_json())

# convert the object into a dict
regenerate_secret_response_dict = regenerate_secret_response_instance.to_dict()
# create an instance of RegenerateSecretResponse from a dict
regenerate_secret_response_from_dict = RegenerateSecretResponse.from_dict(regenerate_secret_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


