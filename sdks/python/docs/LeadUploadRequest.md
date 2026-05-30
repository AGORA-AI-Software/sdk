# LeadUploadRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**campaign_id** | **int** | Target campaign. Required for API-key-derived bearer tokens. | 
**source** | **str** |  | [optional] [default to 'api']
**leads** | [**List[LeadInput]**](LeadInput.md) |  | 
**tags** | **List[str]** |  | [optional] 
**skip_duplicates** | **bool** |  | [optional] [default to True]
**compliance_acknowledged** | **bool** | Must be true to confirm the caller has permission to upload these contacts. | 
**disclaimer_version** | **str** |  | [optional] [default to 'v1.0']

## Example

```python
from agora_public_api.models.lead_upload_request import LeadUploadRequest

# TODO update the JSON string below
json = "{}"
# create an instance of LeadUploadRequest from a JSON string
lead_upload_request_instance = LeadUploadRequest.from_json(json)
# print the JSON string representation of the object
print(LeadUploadRequest.to_json())

# convert the object into a dict
lead_upload_request_dict = lead_upload_request_instance.to_dict()
# create an instance of LeadUploadRequest from a dict
lead_upload_request_from_dict = LeadUploadRequest.from_dict(lead_upload_request_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


