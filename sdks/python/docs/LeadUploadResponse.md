# LeadUploadResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **str** |  | 
**import_id** | **str** |  | 
**received_count** | **int** |  | 
**valid_count** | **int** |  | 
**invalid_count** | **int** |  | 
**errors** | [**List[LeadUploadError]**](LeadUploadError.md) |  | 

## Example

```python
from agora_public_api.models.lead_upload_response import LeadUploadResponse

# TODO update the JSON string below
json = "{}"
# create an instance of LeadUploadResponse from a JSON string
lead_upload_response_instance = LeadUploadResponse.from_json(json)
# print the JSON string representation of the object
print(LeadUploadResponse.to_json())

# convert the object into a dict
lead_upload_response_dict = lead_upload_response_instance.to_dict()
# create an instance of LeadUploadResponse from a dict
lead_upload_response_from_dict = LeadUploadResponse.from_dict(lead_upload_response_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


