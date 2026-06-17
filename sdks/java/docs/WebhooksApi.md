# WebhooksApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**getWebhookEndpointHealth**](WebhooksApi.md#getWebhookEndpointHealth) | **GET** /webhooks/{campaign_id}/endpoints/{endpoint_id}/health | Get delivery health for a webhook endpoint |
| [**listWebhookEndpoints**](WebhooksApi.md#listWebhookEndpoints) | **GET** /webhooks/{campaign_id}/endpoints | List webhook endpoints |
| [**listWebhookEventTypes**](WebhooksApi.md#listWebhookEventTypes) | **GET** /webhooks/{campaign_id}/events | List webhook event types |


<a id="getWebhookEndpointHealth"></a>
# **getWebhookEndpointHealth**
> WebhookEndpointHealth getWebhookEndpointHealth(campaignId, endpointId)

Get delivery health for a webhook endpoint

Returns a delivery health snapshot for the endpoint: total/successful/failed delivery counts, success rate, last delivery timestamp, and average response time. Use this to monitor the reliability of your webhook integration — alert on a dropping success rate or a stale &#x60;last_delivery_at&#x60;. 

### Example
```java
// Import classes:
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.ApiException;
import ai.agora.publicapi.Configuration;
import ai.agora.publicapi.auth.*;
import ai.agora.publicapi.models.*;
import ai.agora.publicapi.api.WebhooksApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("https://core.agoraai.tech/api/v1");
    
    // Configure HTTP bearer authorization: bearerAuth
    HttpBearerAuth bearerAuth = (HttpBearerAuth) defaultClient.getAuthentication("bearerAuth");
    bearerAuth.setBearerToken("BEARER TOKEN");

    WebhooksApi apiInstance = new WebhooksApi(defaultClient);
    Integer campaignId = 56; // Integer | ID of the campaign.
    Integer endpointId = 56; // Integer | ID of the webhook endpoint.
    try {
      WebhookEndpointHealth result = apiInstance.getWebhookEndpointHealth(campaignId, endpointId);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#getWebhookEndpointHealth");
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
| **campaignId** | **Integer**| ID of the campaign. | |
| **endpointId** | **Integer**| ID of the webhook endpoint. | |

### Return type

[**WebhookEndpointHealth**](WebhookEndpointHealth.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Delivery health snapshot. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

<a id="listWebhookEndpoints"></a>
# **listWebhookEndpoints**
> List&lt;WebhookEndpointSummary&gt; listWebhookEndpoints(campaignId)

List webhook endpoints

Returns all webhook endpoints configured on a campaign. Does not include signing secrets — use the Agora dashboard to manage secrets.

### Example
```java
// Import classes:
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.ApiException;
import ai.agora.publicapi.Configuration;
import ai.agora.publicapi.auth.*;
import ai.agora.publicapi.models.*;
import ai.agora.publicapi.api.WebhooksApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("https://core.agoraai.tech/api/v1");
    
    // Configure HTTP bearer authorization: bearerAuth
    HttpBearerAuth bearerAuth = (HttpBearerAuth) defaultClient.getAuthentication("bearerAuth");
    bearerAuth.setBearerToken("BEARER TOKEN");

    WebhooksApi apiInstance = new WebhooksApi(defaultClient);
    Integer campaignId = 56; // Integer | ID of the campaign.
    try {
      List<WebhookEndpointSummary> result = apiInstance.listWebhookEndpoints(campaignId);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#listWebhookEndpoints");
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
| **campaignId** | **Integer**| ID of the campaign. | |

### Return type

[**List&lt;WebhookEndpointSummary&gt;**](WebhookEndpointSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | List of webhook endpoints. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |

<a id="listWebhookEventTypes"></a>
# **listWebhookEventTypes**
> List&lt;String&gt; listWebhookEventTypes(campaignId)

List webhook event types

Returns all event type strings that can be subscribed to on a webhook endpoint.

### Example
```java
// Import classes:
import ai.agora.publicapi.ApiClient;
import ai.agora.publicapi.ApiException;
import ai.agora.publicapi.Configuration;
import ai.agora.publicapi.auth.*;
import ai.agora.publicapi.models.*;
import ai.agora.publicapi.api.WebhooksApi;

public class Example {
  public static void main(String[] args) {
    ApiClient defaultClient = Configuration.getDefaultApiClient();
    defaultClient.setBasePath("https://core.agoraai.tech/api/v1");
    
    // Configure HTTP bearer authorization: bearerAuth
    HttpBearerAuth bearerAuth = (HttpBearerAuth) defaultClient.getAuthentication("bearerAuth");
    bearerAuth.setBearerToken("BEARER TOKEN");

    WebhooksApi apiInstance = new WebhooksApi(defaultClient);
    Integer campaignId = 56; // Integer | ID of the campaign.
    try {
      List<String> result = apiInstance.listWebhookEventTypes(campaignId);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#listWebhookEventTypes");
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
| **campaignId** | **Integer**| ID of the campaign. | |

### Return type

**List&lt;String&gt;**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Array of event type strings. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |

