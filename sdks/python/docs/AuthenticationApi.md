# agora_public_api.AuthenticationApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login_with_api_key**](AuthenticationApi.md#login_with_api_key) | **POST** /auth/api-key/token | Log in with an API key


# **login_with_api_key**
> ApiKeyTokenResponse login_with_api_key(api_key_token_request)

Log in with an API key

Logs in with a long-lived Agora API key and returns a short-lived bearer JWT. The API key is only sent to this endpoint and should not be used for normal API calls.

### Example


```python
import agora_public_api
from agora_public_api.models.api_key_token_request import ApiKeyTokenRequest
from agora_public_api.models.api_key_token_response import ApiKeyTokenResponse
from agora_public_api.rest import ApiException
from pprint import pprint

# Defining the host is optional and defaults to https://core.agoraai.tech/api/v1
# See configuration.py for a list of all supported configuration parameters.
configuration = agora_public_api.Configuration(
    host = "https://core.agoraai.tech/api/v1"
)


# Enter a context with an instance of the API client
with agora_public_api.ApiClient(configuration) as api_client:
    # Create an instance of the API class
    api_instance = agora_public_api.AuthenticationApi(api_client)
    api_key_token_request = {"api_key":"agora_live_REDACTED"} # ApiKeyTokenRequest | 

    try:
        # Log in with an API key
        api_response = api_instance.login_with_api_key(api_key_token_request)
        print("The response of AuthenticationApi->login_with_api_key:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling AuthenticationApi->login_with_api_key: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **api_key_token_request** | [**ApiKeyTokenRequest**](ApiKeyTokenRequest.md)|  | 

### Return type

[**ApiKeyTokenResponse**](ApiKeyTokenResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Short-lived bearer token. |  -  |
**401** | The API key is invalid, expired, or revoked. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

