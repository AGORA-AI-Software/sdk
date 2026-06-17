# \WebhooksAPI

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**CreateWebhookEndpoint**](WebhooksAPI.md#CreateWebhookEndpoint) | **Post** /campaigns/{campaign_id}/webhooks/endpoints | Create a webhook endpoint
[**DeleteWebhookEndpoint**](WebhooksAPI.md#DeleteWebhookEndpoint) | **Delete** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id} | Delete a webhook endpoint
[**ListWebhookDeliveries**](WebhooksAPI.md#ListWebhookDeliveries) | **Get** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/deliveries | List deliveries for a webhook endpoint
[**ListWebhookEndpoints**](WebhooksAPI.md#ListWebhookEndpoints) | **Get** /campaigns/{campaign_id}/webhooks/endpoints | List webhook endpoints
[**ListWebhookEventTypes**](WebhooksAPI.md#ListWebhookEventTypes) | **Get** /campaigns/{campaign_id}/webhooks/events | List webhook event types
[**RedeliverWebhookDelivery**](WebhooksAPI.md#RedeliverWebhookDelivery) | **Post** /campaigns/{campaign_id}/webhooks/deliveries/{delivery_id}/redeliver | Redeliver a webhook delivery
[**RegenerateWebhookSecret**](WebhooksAPI.md#RegenerateWebhookSecret) | **Post** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/regenerate-secret | Regenerate the signing secret
[**TestWebhookEndpoint**](WebhooksAPI.md#TestWebhookEndpoint) | **Post** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id}/test | Send a test ping to a webhook endpoint
[**UpdateWebhookEndpoint**](WebhooksAPI.md#UpdateWebhookEndpoint) | **Patch** /campaigns/{campaign_id}/webhooks/endpoints/{endpoint_id} | Update a webhook endpoint



## CreateWebhookEndpoint

> WebhookEndpointResponse CreateWebhookEndpoint(ctx, campaignId).WebhookEndpointCreate(webhookEndpointCreate).Execute()

Create a webhook endpoint



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	webhookEndpointCreate := *openapiclient.NewWebhookEndpointCreate("https://hooks.example.com/agora") // WebhookEndpointCreate | 

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.CreateWebhookEndpoint(context.Background(), campaignId).WebhookEndpointCreate(webhookEndpointCreate).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.CreateWebhookEndpoint``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `CreateWebhookEndpoint`: WebhookEndpointResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.CreateWebhookEndpoint`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 

### Other Parameters

Other parameters are passed through a pointer to a apiCreateWebhookEndpointRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------

 **webhookEndpointCreate** | [**WebhookEndpointCreate**](WebhookEndpointCreate.md) |  | 

### Return type

[**WebhookEndpointResponse**](WebhookEndpointResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## DeleteWebhookEndpoint

> DeleteWebhookEndpoint(ctx, campaignId, endpointId).Execute()

Delete a webhook endpoint



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	endpointId := int32(56) // int32 | ID of the webhook endpoint.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	r, err := apiClient.WebhooksAPI.DeleteWebhookEndpoint(context.Background(), campaignId, endpointId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.DeleteWebhookEndpoint``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**endpointId** | **int32** | ID of the webhook endpoint. | 

### Other Parameters

Other parameters are passed through a pointer to a apiDeleteWebhookEndpointRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------



### Return type

 (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## ListWebhookDeliveries

> []WebhookDeliveryResponse ListWebhookDeliveries(ctx, campaignId, endpointId).Success(success).Limit(limit).Execute()

List deliveries for a webhook endpoint



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	endpointId := int32(56) // int32 | ID of the webhook endpoint.
	success := true // bool | Filter by delivery outcome. Omit to return all deliveries. (optional)
	limit := int32(56) // int32 | Maximum number of deliveries to return. (optional) (default to 50)

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.ListWebhookDeliveries(context.Background(), campaignId, endpointId).Success(success).Limit(limit).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.ListWebhookDeliveries``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `ListWebhookDeliveries`: []WebhookDeliveryResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.ListWebhookDeliveries`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**endpointId** | **int32** | ID of the webhook endpoint. | 

### Other Parameters

Other parameters are passed through a pointer to a apiListWebhookDeliveriesRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------


 **success** | **bool** | Filter by delivery outcome. Omit to return all deliveries. | 
 **limit** | **int32** | Maximum number of deliveries to return. | [default to 50]

### Return type

[**[]WebhookDeliveryResponse**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## ListWebhookEndpoints

> []WebhookEndpointResponse ListWebhookEndpoints(ctx, campaignId).Execute()

List webhook endpoints



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.ListWebhookEndpoints(context.Background(), campaignId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.ListWebhookEndpoints``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `ListWebhookEndpoints`: []WebhookEndpointResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.ListWebhookEndpoints`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 

### Other Parameters

Other parameters are passed through a pointer to a apiListWebhookEndpointsRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------


### Return type

[**[]WebhookEndpointResponse**](WebhookEndpointResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## ListWebhookEventTypes

> []string ListWebhookEventTypes(ctx, campaignId).Execute()

List webhook event types



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.ListWebhookEventTypes(context.Background(), campaignId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.ListWebhookEventTypes``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `ListWebhookEventTypes`: []string
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.ListWebhookEventTypes`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 

### Other Parameters

Other parameters are passed through a pointer to a apiListWebhookEventTypesRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------


### Return type

**[]string**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## RedeliverWebhookDelivery

> WebhookDeliveryResponse RedeliverWebhookDelivery(ctx, campaignId, deliveryId).Execute()

Redeliver a webhook delivery



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	deliveryId := int32(56) // int32 | ID of the delivery to redeliver.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.RedeliverWebhookDelivery(context.Background(), campaignId, deliveryId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.RedeliverWebhookDelivery``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `RedeliverWebhookDelivery`: WebhookDeliveryResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.RedeliverWebhookDelivery`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**deliveryId** | **int32** | ID of the delivery to redeliver. | 

### Other Parameters

Other parameters are passed through a pointer to a apiRedeliverWebhookDeliveryRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------



### Return type

[**WebhookDeliveryResponse**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## RegenerateWebhookSecret

> RegenerateSecretResponse RegenerateWebhookSecret(ctx, campaignId, endpointId).Execute()

Regenerate the signing secret



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	endpointId := int32(56) // int32 | ID of the webhook endpoint.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.RegenerateWebhookSecret(context.Background(), campaignId, endpointId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.RegenerateWebhookSecret``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `RegenerateWebhookSecret`: RegenerateSecretResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.RegenerateWebhookSecret`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**endpointId** | **int32** | ID of the webhook endpoint. | 

### Other Parameters

Other parameters are passed through a pointer to a apiRegenerateWebhookSecretRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------



### Return type

[**RegenerateSecretResponse**](RegenerateSecretResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## TestWebhookEndpoint

> WebhookDeliveryResponse TestWebhookEndpoint(ctx, campaignId, endpointId).Execute()

Send a test ping to a webhook endpoint



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	endpointId := int32(56) // int32 | ID of the webhook endpoint.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.TestWebhookEndpoint(context.Background(), campaignId, endpointId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.TestWebhookEndpoint``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `TestWebhookEndpoint`: WebhookDeliveryResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.TestWebhookEndpoint`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**endpointId** | **int32** | ID of the webhook endpoint. | 

### Other Parameters

Other parameters are passed through a pointer to a apiTestWebhookEndpointRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------



### Return type

[**WebhookDeliveryResponse**](WebhookDeliveryResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## UpdateWebhookEndpoint

> WebhookEndpointResponse UpdateWebhookEndpoint(ctx, campaignId, endpointId).WebhookEndpointUpdate(webhookEndpointUpdate).Execute()

Update a webhook endpoint



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	campaignId := int32(56) // int32 | ID of the campaign.
	endpointId := int32(56) // int32 | ID of the webhook endpoint.
	webhookEndpointUpdate := *openapiclient.NewWebhookEndpointUpdate() // WebhookEndpointUpdate | 

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.WebhooksAPI.UpdateWebhookEndpoint(context.Background(), campaignId, endpointId).WebhookEndpointUpdate(webhookEndpointUpdate).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.UpdateWebhookEndpoint``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `UpdateWebhookEndpoint`: WebhookEndpointResponse
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.UpdateWebhookEndpoint`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**endpointId** | **int32** | ID of the webhook endpoint. | 

### Other Parameters

Other parameters are passed through a pointer to a apiUpdateWebhookEndpointRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------


 **webhookEndpointUpdate** | [**WebhookEndpointUpdate**](WebhookEndpointUpdate.md) |  | 

### Return type

[**WebhookEndpointResponse**](WebhookEndpointResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)

