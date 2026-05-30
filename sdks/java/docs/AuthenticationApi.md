# AuthenticationApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**loginWithApiKey**](AuthenticationApi.md#loginWithApiKey) | **POST** /auth/api-key/token | Log in with an API key |


<a id="loginWithApiKey"></a>
# **loginWithApiKey**
> ApiKeyTokenResponse loginWithApiKey(apiKeyTokenRequest)

Log in with an API key

Logs in with a long-lived Agora API key and returns a short-lived bearer JWT. The API key is only sent to this endpoint and should not be used for normal API calls.

### Example
```java
// Import classes:
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.ApiException;
import ai.agora.publicapi.Configuration;
import ai.agora.publicapi.models.*;
import ai.agora.publicapi.api.AuthenticationApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("https://core.agoraai.tech/api/v1");

    AuthenticationApi apiInstance = new AuthenticationApi(defaultClient);
    ApiKeyTokenRequest apiKeyTokenRequest = new ApiKeyTokenRequest(); // ApiKeyTokenRequest | 
    try {
      ApiKeyTokenResponse result = apiInstance.loginWithApiKey(apiKeyTokenRequest);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling AuthenticationApi#loginWithApiKey");
      System.err.println("Status code: " + e.getCode());
      System.err.println("Reason: " + e.getResponseBody());
      System.err.println("Response headers: " + e.getResponseHeaders());
      e.printStackTrace();
    }
  }
}
```

### Parameters

| Name | Type | Description  | Notes |
|------------- | ------------- | ------------- | -------------|
| **apiKeyTokenRequest** | [**ApiKeyTokenRequest**](ApiKeyTokenRequest.md)|  | |

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
| **200** | Short-lived bearer token. |  -  |
| **401** | The API key is invalid, expired, or revoked. |  -  |

