# WebhooksApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

| Method | HTTP request | Description |
|------------- | ------------- | -------------|
| [**createWebhookEndpoint**](WebhooksApi.md#createWebhookEndpoint) | **POST** /campaigns/{campaign_id}/webhooks/endpoints | Create a webhook endpoint |
| [**deleteWebhookEndpoint**](WebhooksApi.md#deleteWebhookEndpoint) | **DELETE** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id} | Delete a webhook endpoint |
| [**listWebhookDeliveries**](WebhooksApi.md#listWebhookDeliveries) | **GET** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/deliveries | List deliveries for a webhook endpoint |
| [**listWebhookEndpoints**](WebhooksApi.md#listWebhookEndpoints) | **GET** /campaigns/{campaign_id}/webhooks/endpoints | List webhook endpoints |
| [**listWebhookEventTypes**](WebhooksApi.md#listWebhookEventTypes) | **GET** /campaigns/{campaign_id}/webhooks/events | List webhook event types |
| [**redeliverWebhookDelivery**](WebhooksApi.md#redeliverWebhookDelivery) | **POST** /campaigns/{campaign_id}/webhooks/deliveries/{delivery_id}/redeliver | Redeliver a webhook delivery |
| [**regenerateWebhookSecret**](WebhooksApi.md#regenerateWebhookSecret) | **POST** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/regenerate-secret | Regenerate the signing secret |
| [**testWebhookEndpoint**](WebhooksApi.md#testWebhookEndpoint) | **POST** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/test | Send a test ping to a webhook endpoint |
| [**updateWebhookEndpoint**](WebhooksApi.md#updateWebhookEndpoint) | **PATCH** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id} | Update a webhook endpoint |


<a id="createWebhookEndpoint"></a>
# **createWebhookEndpoint**
> WebhookEndpointResponse createWebhookEndpoint(campaignId, webhookEndpointCreate)

Create a webhook endpoint

Registers a new webhook endpoint on a campaign. Returns the endpoint with its signing secret — store it securely, it will not be shown again.

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
    WebhookEndpointCreate webhookEndpointCreate = new WebhookEndpointCreate(); // WebhookEndpointCreate | 
    try {
      WebhookEndpointResponse result = apiInstance.createWebhookEndpoint(campaignId, webhookEndpointCreate);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#createWebhookEndpoint");
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
| **webhookEndpointCreate** | [**WebhookEndpointCreate**](WebhookEndpointCreate.md)|  | |

### Return type

[**WebhookEndpointResponse**](WebhookEndpointResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **201** | Endpoint created. The &#x60;secret&#x60; field is only returned here — store it securely. |  -  |
| **400** | Invalid event type or request body. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |

<a id="deleteWebhookEndpoint"></a>
# **deleteWebhookEndpoint**
> deleteWebhookEndpoint(campaignId, endpointId)

Delete a webhook endpoint

Permanently deletes a webhook endpoint and all its delivery history.

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
      apiInstance.deleteWebhookEndpoint(campaignId, endpointId);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#deleteWebhookEndpoint");
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

null (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **204** | Endpoint deleted. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

<a id="listWebhookDeliveries"></a>
# **listWebhookDeliveries**
> List&lt;WebhookDeliveryResponse&gt; listWebhookDeliveries(campaignId, endpointId, success, limit)

List deliveries for a webhook endpoint

Returns the delivery history for a webhook endpoint, ordered by most recent first.

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
    Boolean success = true; // Boolean | Filter by delivery outcome. Omit to return all deliveries.
    Integer limit = 50; // Integer | Maximum number of deliveries to return.
    try {
      List<WebhookDeliveryResponse> result = apiInstance.listWebhookDeliveries(campaignId, endpointId, success, limit);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#listWebhookDeliveries");
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
| **success** | **Boolean**| Filter by delivery outcome. Omit to return all deliveries. | [optional] |
| **limit** | **Integer**| Maximum number of deliveries to return. | [optional] [default to 50] |

### Return type

[**List&lt;WebhookDeliveryResponse&gt;**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | List of deliveries, most recent first. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

<a id="listWebhookEndpoints"></a>
# **listWebhookEndpoints**
> List&lt;WebhookEndpointResponse&gt; listWebhookEndpoints(campaignId)

List webhook endpoints

Returns all webhook endpoints registered on a campaign.

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
      List<WebhookEndpointResponse> result = apiInstance.listWebhookEndpoints(campaignId);
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

[**List&lt;WebhookEndpointResponse&gt;**](WebhookEndpointResponse.md)

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

<a id="redeliverWebhookDelivery"></a>
# **redeliverWebhookDelivery**
> WebhookDeliveryResponse redeliverWebhookDelivery(campaignId, deliveryId)

Redeliver a webhook delivery

Re-sends a previously delivered (or failed) event to the original endpoint. Creates a new delivery record linked to the original via &#x60;redelivery_of_id&#x60;.

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
    Integer deliveryId = 56; // Integer | ID of the delivery to redeliver.
    try {
      WebhookDeliveryResponse result = apiInstance.redeliverWebhookDelivery(campaignId, deliveryId);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#redeliverWebhookDelivery");
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
| **deliveryId** | **Integer**| ID of the delivery to redeliver. | |

### Return type

[**WebhookDeliveryResponse**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | New delivery record for the redelivery attempt. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

<a id="regenerateWebhookSecret"></a>
# **regenerateWebhookSecret**
> RegenerateSecretResponse regenerateWebhookSecret(campaignId, endpointId)

Regenerate the signing secret

Rotates the HMAC-SHA256 signing secret for a webhook endpoint. The old secret stops working immediately. Store the new secret securely — it will not be shown again.

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
      RegenerateSecretResponse result = apiInstance.regenerateWebhookSecret(campaignId, endpointId);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#regenerateWebhookSecret");
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

[**RegenerateSecretResponse**](RegenerateSecretResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | New signing secret. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

<a id="testWebhookEndpoint"></a>
# **testWebhookEndpoint**
> WebhookDeliveryResponse testWebhookEndpoint(campaignId, endpointId)

Send a test ping to a webhook endpoint

Sends a synthetic &#x60;ping&#x60; event to the endpoint URL and records the delivery result. Useful for verifying connectivity and signature verification before going live.

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
      WebhookDeliveryResponse result = apiInstance.testWebhookEndpoint(campaignId, endpointId);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#testWebhookEndpoint");
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

[**WebhookDeliveryResponse**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Delivery record for the test ping. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

<a id="updateWebhookEndpoint"></a>
# **updateWebhookEndpoint**
> WebhookEndpointResponse updateWebhookEndpoint(campaignId, endpointId, webhookEndpointUpdate)

Update a webhook endpoint

Updates one or more fields on an existing webhook endpoint. Omitted fields are unchanged.

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
    WebhookEndpointUpdate webhookEndpointUpdate = new WebhookEndpointUpdate(); // WebhookEndpointUpdate | 
    try {
      WebhookEndpointResponse result = apiInstance.updateWebhookEndpoint(campaignId, endpointId, webhookEndpointUpdate);
      System.out.println(result);
    } catch (ApiException e) {
      System.err.println("Exception when calling WebhooksApi#updateWebhookEndpoint");
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
| **webhookEndpointUpdate** | [**WebhookEndpointUpdate**](WebhookEndpointUpdate.md)|  | |

### Return type

[**WebhookEndpointResponse**](WebhookEndpointResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

### HTTP response details
| Status code | Description | Response headers |
|-------------|-------------|------------------|
| **200** | Updated endpoint. |  -  |
| **400** | Invalid event type or request body. |  -  |
| **401** | Missing, invalid, or expired bearer token. |  -  |
| **403** | Bearer token is not authorized for this campaign. |  -  |
| **404** | Resource not found or does not belong to this campaign. |  -  |

