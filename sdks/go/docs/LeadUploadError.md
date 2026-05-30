# LeadUploadError

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Row** | **int32** |  | 
**Field** | Pointer to **NullableString** |  | [optional] 
**Message** | **string** |  | 

## Methods

### NewLeadUploadError

`func NewLeadUploadError(row int32, message string, ) *LeadUploadError`

NewLeadUploadError instantiates a new LeadUploadError object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewLeadUploadErrorWithDefaults

`func NewLeadUploadErrorWithDefaults() *LeadUploadError`

NewLeadUploadErrorWithDefaults instantiates a new LeadUploadError object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetRow

`func (o *LeadUploadError) GetRow() int32`

GetRow returns the Row field if non-nil, zero value otherwise.

### GetRowOk

`func (o *LeadUploadError) GetRowOk() (*int32, bool)`

GetRowOk returns a tuple with the Row field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetRow

`func (o *LeadUploadError) SetRow(v int32)`

SetRow sets Row field to given value.


### GetField

`func (o *LeadUploadError) GetField() string`

GetField returns the Field field if non-nil, zero value otherwise.

### GetFieldOk

`func (o *LeadUploadError) GetFieldOk() (*string, bool)`

GetFieldOk returns a tuple with the Field field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetField

`func (o *LeadUploadError) SetField(v string)`

SetField sets Field field to given value.

### HasField

`func (o *LeadUploadError) HasField() bool`

HasField returns a boolean if a field has been set.

### SetFieldNil

`func (o *LeadUploadError) SetFieldNil(b bool)`

 SetFieldNil sets the value for Field to be an explicit nil

### UnsetField
`func (o *LeadUploadError) UnsetField()`

UnsetField ensures that no value is present for Field, not even an explicit nil
### GetMessage

`func (o *LeadUploadError) GetMessage() string`

GetMessage returns the Message field if non-nil, zero value otherwise.

### GetMessageOk

`func (o *LeadUploadError) GetMessageOk() (*string, bool)`

GetMessageOk returns a tuple with the Message field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetMessage

`func (o *LeadUploadError) SetMessage(v string)`

SetMessage sets Message field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


