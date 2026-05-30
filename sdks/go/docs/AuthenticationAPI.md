# \AuthenticationAPI

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**LoginWithApiKey**](AuthenticationAPI.md#LoginWithApiKey) | **Post** /auth/api-key/token | Log in with an API key



## LoginWithApiKey

> ApiKeyTokenResponse LoginWithApiKey(ctx).ApiKeyTokenRequest(apiKeyTokenRequest).Execute()

Log in with an API key



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
	apiKeyTokenRequest := *openapiclient.NewApiKeyTokenRequest("ApiKey_example") // ApiKeyTokenRequest | 

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.AuthenticationAPI.LoginWithApiKey(context.Background()).ApiKeyTokenRequest(apiKeyTokenRequest).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `AuthenticationAPI.LoginWithApiKey``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `LoginWithApiKey`: ApiKeyTokenResponse
	fmt.Fprintf(os.Stdout, "Response from `AuthenticationAPI.LoginWithApiKey`: %v\n", resp)
}
```

### Path Parameters



### Other Parameters

Other parameters are passed through a pointer to a apiLoginWithApiKeyRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiKeyTokenRequest** | [**ApiKeyTokenRequest**](ApiKeyTokenRequest.md) |  | 

### Return type

[**ApiKeyTokenResponse**](ApiKeyTokenResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)

