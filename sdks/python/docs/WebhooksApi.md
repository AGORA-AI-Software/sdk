# agora_public_api.WebhooksApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_webhook_endpoint_health**](WebhooksApi.md#get_webhook_endpoint_health) | **GET** /webhooks/{campaign_id}/endpoints/{endpoint_id}/health | Get delivery health for a webhook endpoint
[**list_webhook_endpoints**](WebhooksApi.md#list_webhook_endpoints) | **GET** /webhooks/{campaign_id}/endpoints | List webhook endpoints
[**list_webhook_event_types**](WebhooksApi.md#list_webhook_event_types) | **GET** /webhooks/{campaign_id}/events | List webhook event types


# **get_webhook_endpoint_health**
> WebhookEndpointHealth get_webhook_endpoint_health(campaign_id, endpoint_id)

Get delivery health for a webhook endpoint

Returns a delivery health snapshot for the endpoint: total/successful/failed
delivery counts, success rate, last delivery timestamp, and average response
time. Use this to monitor the reliability of your webhook integration — alert
on a dropping success rate or a stale `last_delivery_at`.


### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_endpoint_health import WebhookEndpointHealth
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
    api_instance = agora_public_api.WebhooksApi(api_client)
    campaign_id = 56 # int | ID of the campaign.
    endpoint_id = 56 # int | ID of the webhook endpoint.

    try:
        # Get delivery health for a webhook endpoint
        api_response = api_instance.get_webhook_endpoint_health(campaign_id, endpoint_id)
        print("The response of WebhooksApi->get_webhook_endpoint_health:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->get_webhook_endpoint_health: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **endpoint_id** | **int**| ID of the webhook endpoint. | 

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
**200** | Delivery health snapshot. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **list_webhook_endpoints**
> List[WebhookEndpointSummary] list_webhook_endpoints(campaign_id)

List webhook endpoints

Returns all webhook endpoints configured on a campaign. Does not include signing secrets — use the Agora dashboard to manage secrets.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_endpoint_summary import WebhookEndpointSummary
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
    api_instance = agora_public_api.WebhooksApi(api_client)
    campaign_id = 56 # int | ID of the campaign.

    try:
        # List webhook endpoints
        api_response = api_instance.list_webhook_endpoints(campaign_id)
        print("The response of WebhooksApi->list_webhook_endpoints:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->list_webhook_endpoints: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 

### Return type

[**List[WebhookEndpointSummary]**](WebhookEndpointSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | List of webhook endpoints. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **list_webhook_event_types**
> List[str] list_webhook_event_types(campaign_id)

List webhook event types

Returns all event type strings that can be subscribed to on a webhook endpoint.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
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
    api_instance = agora_public_api.WebhooksApi(api_client)
    campaign_id = 56 # int | ID of the campaign.

    try:
        # List webhook event types
        api_response = api_instance.list_webhook_event_types(campaign_id)
        print("The response of WebhooksApi->list_webhook_event_types:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->list_webhook_event_types: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 

### Return type

**List[str]**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | Array of event type strings. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

