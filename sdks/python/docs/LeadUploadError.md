# LeadUploadError


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**row** | **int** |  | 
**var_field** | **str** |  | [optional] 
**message** | **str** |  | 

## Example

```python
from agora_public_api.models.lead_upload_error import LeadUploadError

# TODO update the JSON string below
json = "{}"
# create an instance of LeadUploadError from a JSON string
lead_upload_error_instance = LeadUploadError.from_json(json)
# print the JSON string representation of the object
print(LeadUploadError.to_json())

# convert the object into a dict
lead_upload_error_dict = lead_upload_error_instance.to_dict()
# create an instance of LeadUploadError from a dict
lead_upload_error_from_dict = LeadUploadError.from_dict(lead_upload_error_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


