# LeadUploadResponse

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Status** | **string** |  | 
**ImportId** | **string** |  | 
**ReceivedCount** | **int32** |  | 
**ValidCount** | **int32** |  | 
**InvalidCount** | **int32** |  | 
**Errors** | [**[]LeadUploadError**](LeadUploadError.md) |  | 

## Methods

### NewLeadUploadResponse

`func NewLeadUploadResponse(status string, importId string, receivedCount int32, validCount int32, invalidCount int32, errors []LeadUploadError, ) *LeadUploadResponse`

NewLeadUploadResponse instantiates a new LeadUploadResponse object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewLeadUploadResponseWithDefaults

`func NewLeadUploadResponseWithDefaults() *LeadUploadResponse`

NewLeadUploadResponseWithDefaults instantiates a new LeadUploadResponse object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetStatus

`func (o *LeadUploadResponse) GetStatus() string`

GetStatus returns the Status field if non-nil, zero value otherwise.

### GetStatusOk

`func (o *LeadUploadResponse) GetStatusOk() (*string, bool)`

GetStatusOk returns a tuple with the Status field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetStatus

`func (o *LeadUploadResponse) SetStatus(v string)`

SetStatus sets Status field to given value.


### GetImportId

`func (o *LeadUploadResponse) GetImportId() string`

GetImportId returns the ImportId field if non-nil, zero value otherwise.

### GetImportIdOk

`func (o *LeadUploadResponse) GetImportIdOk() (*string, bool)`

GetImportIdOk returns a tuple with the ImportId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetImportId

`func (o *LeadUploadResponse) SetImportId(v string)`

SetImportId sets ImportId field to given value.


### GetReceivedCount

`func (o *LeadUploadResponse) GetReceivedCount() int32`

GetReceivedCount returns the ReceivedCount field if non-nil, zero value otherwise.

### GetReceivedCountOk

`func (o *LeadUploadResponse) GetReceivedCountOk() (*int32, bool)`

GetReceivedCountOk returns a tuple with the ReceivedCount field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetReceivedCount

`func (o *LeadUploadResponse) SetReceivedCount(v int32)`

SetReceivedCount sets ReceivedCount field to given value.


### GetValidCount

`func (o *LeadUploadResponse) GetValidCount() int32`

GetValidCount returns the ValidCount field if non-nil, zero value otherwise.

### GetValidCountOk

`func (o *LeadUploadResponse) GetValidCountOk() (*int32, bool)`

GetValidCountOk returns a tuple with the ValidCount field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetValidCount

`func (o *LeadUploadResponse) SetValidCount(v int32)`

SetValidCount sets ValidCount field to given value.


### GetInvalidCount

`func (o *LeadUploadResponse) GetInvalidCount() int32`

GetInvalidCount returns the InvalidCount field if non-nil, zero value otherwise.

### GetInvalidCountOk

`func (o *LeadUploadResponse) GetInvalidCountOk() (*int32, bool)`

GetInvalidCountOk returns a tuple with the InvalidCount field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetInvalidCount

`func (o *LeadUploadResponse) SetInvalidCount(v int32)`

SetInvalidCount sets InvalidCount field to given value.


### GetErrors

`func (o *LeadUploadResponse) GetErrors() []LeadUploadError`

GetErrors returns the Errors field if non-nil, zero value otherwise.

### GetErrorsOk

`func (o *LeadUploadResponse) GetErrorsOk() (*[]LeadUploadError, bool)`

GetErrorsOk returns a tuple with the Errors field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetErrors

`func (o *LeadUploadResponse) SetErrors(v []LeadUploadError)`

SetErrors sets Errors field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


