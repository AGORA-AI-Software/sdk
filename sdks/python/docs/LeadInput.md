# LeadInput


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**first_name** | **str** |  | [optional] 
**last_name** | **str** |  | [optional] 
**email** | **str** |  | [optional] 
**phone** | **str** | E.164 formatted phone number is preferred. | 
**company** | **str** |  | [optional] 
**title** | **str** |  | [optional] 

## Example

```python
from agora_public_api.models.lead_input import LeadInput

# TODO update the JSON string below
json = "{}"
# create an instance of LeadInput from a JSON string
lead_input_instance = LeadInput.from_json(json)
# print the JSON string representation of the object
print(LeadInput.to_json())

# convert the object into a dict
lead_input_dict = lead_input_instance.to_dict()
# create an instance of LeadInput from a dict
lead_input_from_dict = LeadInput.from_dict(lead_input_dict)
```
[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


