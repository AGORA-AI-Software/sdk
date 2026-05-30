# LeadsApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**uploadLeads**](LeadsApi.md#uploadLeads) | **POST** /leads/upload | Upload leads |


<a id="uploadLeads"></a>
# **uploadLeads**
> LeadUploadResponse uploadLeads(leadUploadRequest)

Upload leads

Uploads lead JSON into an authorized campaign using a short-lived bearer token obtained from API key exchange. Processing reuses Agora&#39;s contact upload pipeline.

### Example
```java
// Import classes:
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.ApiException;
import ai.agora.publicapi.Configuration;
import ai.agora.publicapi.auth.*;
import ai.agora.publicapi.models.*;
import ai.agora.publicapi.api.LeadsApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("https://core.agoraai.tech/api/v1");
    
    // Configure HTTP bearer authorization: bearerAuth
    HttpBearerAuth bearerAuth = (HttpBearerAuth) defaultClient.getAuthentication("bearerAuth");
    bearerAuth.setBearerToken("BEARER TOKEN");

    LeadsApi apiInstance = new LeadsApi(defaultClient);
    LeadUploadRequest leadUploadRequest = new LeadUploadRequest(); // LeadUploadRequest | 
    try {
      LeadUploadResponse result = apiInstance.uploadLeads(leadUploadRequest);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling LeadsApi#uploadLeads");
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
| **leadUploadRequest** | [**LeadUploadRequest**](LeadUploadRequest.md)|  | |

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
| **202** | Upload accepted and queued or processed through the upload job pipeline. |  -  |
| **400** | Request validation failed, such as missing campaign for API-token upload. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for the target campaign or company. |  -  |
| **422** | Lead payload failed structured validation. |  -  |

