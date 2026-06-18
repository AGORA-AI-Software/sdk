# \WebhooksAPI

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**GetWebhookEndpointHealth**](WebhooksAPI.md#GetWebhookEndpointHealth) | **Get** /webhooks/{campaign_id}/endpoints/{endpoint_id}/health | Get delivery health for a webhook endpoint
[**ListWebhookEndpoints**](WebhooksAPI.md#ListWebhookEndpoints) | **Get** /webhooks/{campaign_id}/endpoints | List webhook endpoints
[**ListWebhookEventTypes**](WebhooksAPI.md#ListWebhookEventTypes) | **Get** /webhooks/{campaign_id}/events | List webhook event types



## GetWebhookEndpointHealth

> WebhookEndpointHealth GetWebhookEndpointHealth(ctx, campaignId, endpointId).Execute()

Get delivery health for a webhook endpoint



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
	resp, r, err := apiClient.WebhooksAPI.GetWebhookEndpointHealth(context.Background(), campaignId, endpointId).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `WebhooksAPI.GetWebhookEndpointHealth``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `GetWebhookEndpointHealth`: WebhookEndpointHealth
	fmt.Fprintf(os.Stdout, "Response from `WebhooksAPI.GetWebhookEndpointHealth`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**campaignId** | **int32** | ID of the campaign. | 
**endpointId** | **int32** | ID of the webhook endpoint. | 

### Other Parameters

Other parameters are passed through a pointer to a apiGetWebhookEndpointHealthRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------



### Return type

[**WebhookEndpointHealth**](WebhookEndpointHealth.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)


## ListWebhookEndpoints

> []WebhookEndpointSummary ListWebhookEndpoints(ctx, campaignId).Execute()

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
	// response from `ListWebhookEndpoints`: []WebhookEndpointSummary
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

[**[]WebhookEndpointSummary**](WebhookEndpointSummary.md)

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

