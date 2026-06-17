# agora_public_api.WebhooksApi

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_webhook_endpoint**](WebhooksApi.md#create_webhook_endpoint) | **POST** /campaigns/{campaign_id}/webhooks/endpoints | Create a webhook endpoint
[**delete_webhook_endpoint**](WebhooksApi.md#delete_webhook_endpoint) | **DELETE** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id} | Delete a webhook endpoint
[**list_webhook_deliveries**](WebhooksApi.md#list_webhook_deliveries) | **GET** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/deliveries | List deliveries for a webhook endpoint
[**list_webhook_endpoints**](WebhooksApi.md#list_webhook_endpoints) | **GET** /campaigns/{campaign_id}/webhooks/endpoints | List webhook endpoints
[**list_webhook_event_types**](WebhooksApi.md#list_webhook_event_types) | **GET** /campaigns/{campaign_id}/webhooks/events | List webhook event types
[**redeliver_webhook_delivery**](WebhooksApi.md#redeliver_webhook_delivery) | **POST** /campaigns/{campaign_id}/webhooks/deliveries/{delivery_id}/redeliver | Redeliver a webhook delivery
[**regenerate_webhook_secret**](WebhooksApi.md#regenerate_webhook_secret) | **POST** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/regenerate-secret | Regenerate the signing secret
[**test_webhook_endpoint**](WebhooksApi.md#test_webhook_endpoint) | **POST** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/test | Send a test ping to a webhook endpoint
[**update_webhook_endpoint**](WebhooksApi.md#update_webhook_endpoint) | **PATCH** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id} | Update a webhook endpoint


# **create_webhook_endpoint**
> WebhookEndpointResponse create_webhook_endpoint(campaign_id, webhook_endpoint_create)

Create a webhook endpoint

Registers a new webhook endpoint on a campaign. Returns the endpoint with its signing secret — store it securely, it will not be shown again.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_endpoint_create import WebhookEndpointCreate
from agora_public_api.models.webhook_endpoint_response import WebhookEndpointResponse
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
    webhook_endpoint_create = {"url":"https://hooks.example.com/agora","description":"Production lead handler","subscribed_events":["lead.created","lead.status_changed"],"is_enabled":true} # WebhookEndpointCreate | 

    try:
        # Create a webhook endpoint
        api_response = api_instance.create_webhook_endpoint(campaign_id, webhook_endpoint_create)
        print("The response of WebhooksApi->create_webhook_endpoint:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->create_webhook_endpoint: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **webhook_endpoint_create** | [**WebhookEndpointCreate**](WebhookEndpointCreate.md)|  | 

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
**201** | Endpoint created. The &#x60;secret&#x60; field is only returned here — store it securely. |  -  |
**400** | Invalid event type or request body. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **delete_webhook_endpoint**
> delete_webhook_endpoint(campaign_id, endpoint_id)

Delete a webhook endpoint

Permanently deletes a webhook endpoint and all its delivery history.

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
    endpoint_id = 56 # int | ID of the webhook endpoint.

    try:
        # Delete a webhook endpoint
        api_instance.delete_webhook_endpoint(campaign_id, endpoint_id)
    except Exception as e:
        print("Exception when calling WebhooksApi->delete_webhook_endpoint: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **endpoint_id** | **int**| ID of the webhook endpoint. | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**204** | Endpoint deleted. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **list_webhook_deliveries**
> List[WebhookDeliveryResponse] list_webhook_deliveries(campaign_id, endpoint_id, success=success, limit=limit)

List deliveries for a webhook endpoint

Returns the delivery history for a webhook endpoint, ordered by most recent first.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_delivery_response import WebhookDeliveryResponse
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
    success = True # bool | Filter by delivery outcome. Omit to return all deliveries. (optional)
    limit = 50 # int | Maximum number of deliveries to return. (optional) (default to 50)

    try:
        # List deliveries for a webhook endpoint
        api_response = api_instance.list_webhook_deliveries(campaign_id, endpoint_id, success=success, limit=limit)
        print("The response of WebhooksApi->list_webhook_deliveries:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->list_webhook_deliveries: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **endpoint_id** | **int**| ID of the webhook endpoint. | 
 **success** | **bool**| Filter by delivery outcome. Omit to return all deliveries. | [optional] 
 **limit** | **int**| Maximum number of deliveries to return. | [optional] [default to 50]

### Return type

[**List[WebhookDeliveryResponse]**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

### HTTP response details

| Status code | Description | Response headers |
|-------------|-------------|------------------|
**200** | List of deliveries, most recent first. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **list_webhook_endpoints**
> List[WebhookEndpointResponse] list_webhook_endpoints(campaign_id)

List webhook endpoints

Returns all webhook endpoints registered on a campaign.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_endpoint_response import WebhookEndpointResponse
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

[**List[WebhookEndpointResponse]**](WebhookEndpointResponse.md)

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

# **redeliver_webhook_delivery**
> WebhookDeliveryResponse redeliver_webhook_delivery(campaign_id, delivery_id)

Redeliver a webhook delivery

Re-sends a previously delivered (or failed) event to the original endpoint. Creates a new delivery record linked to the original via `redelivery_of_id`.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_delivery_response import WebhookDeliveryResponse
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
    delivery_id = 56 # int | ID of the delivery to redeliver.

    try:
        # Redeliver a webhook delivery
        api_response = api_instance.redeliver_webhook_delivery(campaign_id, delivery_id)
        print("The response of WebhooksApi->redeliver_webhook_delivery:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->redeliver_webhook_delivery: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **delivery_id** | **int**| ID of the delivery to redeliver. | 

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
**200** | New delivery record for the redelivery attempt. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **regenerate_webhook_secret**
> RegenerateSecretResponse regenerate_webhook_secret(campaign_id, endpoint_id)

Regenerate the signing secret

Rotates the HMAC-SHA256 signing secret for a webhook endpoint. The old secret stops working immediately. Store the new secret securely — it will not be shown again.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.regenerate_secret_response import RegenerateSecretResponse
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
        # Regenerate the signing secret
        api_response = api_instance.regenerate_webhook_secret(campaign_id, endpoint_id)
        print("The response of WebhooksApi->regenerate_webhook_secret:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->regenerate_webhook_secret: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **endpoint_id** | **int**| ID of the webhook endpoint. | 

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
**200** | New signing secret. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **test_webhook_endpoint**
> WebhookDeliveryResponse test_webhook_endpoint(campaign_id, endpoint_id)

Send a test ping to a webhook endpoint

Sends a synthetic `ping` event to the endpoint URL and records the delivery result. Useful for verifying connectivity and signature verification before going live.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_delivery_response import WebhookDeliveryResponse
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
        # Send a test ping to a webhook endpoint
        api_response = api_instance.test_webhook_endpoint(campaign_id, endpoint_id)
        print("The response of WebhooksApi->test_webhook_endpoint:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->test_webhook_endpoint: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **endpoint_id** | **int**| ID of the webhook endpoint. | 

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
**200** | Delivery record for the test ping. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **update_webhook_endpoint**
> WebhookEndpointResponse update_webhook_endpoint(campaign_id, endpoint_id, webhook_endpoint_update)

Update a webhook endpoint

Updates one or more fields on an existing webhook endpoint. Omitted fields are unchanged.

### Example

* Bearer (JWT) Authentication (bearerAuth):

```python
import agora_public_api
from agora_public_api.models.webhook_endpoint_response import WebhookEndpointResponse
from agora_public_api.models.webhook_endpoint_update import WebhookEndpointUpdate
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
    webhook_endpoint_update = {"is_enabled":false} # WebhookEndpointUpdate | 

    try:
        # Update a webhook endpoint
        api_response = api_instance.update_webhook_endpoint(campaign_id, endpoint_id, webhook_endpoint_update)
        print("The response of WebhooksApi->update_webhook_endpoint:\n")
        pprint(api_response)
    except Exception as e:
        print("Exception when calling WebhooksApi->update_webhook_endpoint: %s\n" % e)
```



### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **campaign_id** | **int**| ID of the campaign. | 
 **endpoint_id** | **int**| ID of the webhook endpoint. | 
 **webhook_endpoint_update** | [**WebhookEndpointUpdate**](WebhookEndpointUpdate.md)|  | 

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
**200** | Updated endpoint. |  -  |
**400** | Invalid event type or request body. |  -  |
**401** | Missing, invalid, or expired bearer token. |  -  |
**403** | Bearer token is not authorized for this campaign. |  -  |
**404** | Resource not found or does not belong to this campaign. |  -  |

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

