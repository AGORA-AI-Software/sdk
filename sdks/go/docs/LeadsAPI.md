# \LeadsAPI

All URIs are relative to *https://core.agoraai.tech/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**UploadLeads**](LeadsAPI.md#UploadLeads) | **Post** /leads/upload | Upload leads



## UploadLeads

> LeadUploadResponse UploadLeads(ctx).LeadUploadRequest(leadUploadRequest).Execute()

Upload leads



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
	leadUploadRequest := *openapiclient.NewLeadUploadRequest(int32(123), []openapiclient.LeadInput{*openapiclient.NewLeadInput("Phone_example")}, false) // LeadUploadRequest | 

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.LeadsAPI.UploadLeads(context.Background()).LeadUploadRequest(leadUploadRequest).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `LeadsAPI.UploadLeads``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `UploadLeads`: LeadUploadResponse
	fmt.Fprintf(os.Stdout, "Response from `LeadsAPI.UploadLeads`: %v\n", resp)
}
```

### Path Parameters



### Other Parameters

Other parameters are passed through a pointer to a apiUploadLeadsRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **leadUploadRequest** | [**LeadUploadRequest**](LeadUploadRequest.md) |  | 

### Return type

[**LeadUploadResponse**](LeadUploadResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)

