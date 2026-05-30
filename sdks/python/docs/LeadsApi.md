# agora_public_api.LeadsApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**upload_leads**](LeadsApi.md#upload_leads) | **POST** /leads/upload | Upload leads


# **upload_leads**
> LeadUploadResponse upload_leads(lead_upload_request)

Upload leads

Uploads lead JSON into an authorized campaign using a short-lived bearer token obtained from API key exchange. Processing reuses Agora's contact upload pipeline.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.lead_upload_request import LeadUploadRequest
from agora_public_api.models.lead_upload_response import LeadUploadResponse
from agora_public_api.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://core.agoraai.tech/api/v1
# See configuration.py for a list of all supported configuration parameters.
configuration = agora_public_api.Configuration(
    host = "https://core.agoraai.tech/api/v1"
)

# The client must configure the authentication and authorization parameters
# in accordance with the API server security policy.
# Examples for each auth method are provided below, use the example that
# satisfies your auth use case.

# Configure Bearer authorization (JWT): bearerAuth
configuration = agora_public_api.Configuration(
    access_token = os.environ["BEARER_TOKEN"]
)

# Enter a context with an instance of the API client
with agora_public_api.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = agora_public_api.LeadsApi(api_client)
    lead_upload_request = {"campaign_id":1,"source":"api","leads":[{"first_name":"Jane","last_name":"Doe","email":"jane.doe@example.test","phone":"+15551234567","company":"Example Co","title":"VP of Operations"}],"compliance_acknowledged":true} # LeadUploadRequest | 

    try:
        # Upload leads
        api_response = api_instance.upload_leads(lead_upload_request)
        print("The response of LeadsApi->upload_leads:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling LeadsApi->upload_leads: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **lead_upload_request** | [**LeadUploadRequest**](LeadUploadRequest.md)|  | 

### Return type

[**LeadUploadResponse**](LeadUploadResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**202** | Upload accepted and queued or processed through the upload job pipeline. |  -  |
**400** | Request validation failed, such as missing campaign for API-token upload. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for the target campaign or company. |  -  |
**422** | Lead payload failed structured validation. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

