# LeadUploadRequest

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**CampaignId** | **int32** | Target campaign. Required for API-key-derived bearer tokens. | 
**Source** | Pointer to **string** |  | [optional] [default to "api"]
**Leads** | [**[]LeadInput**](LeadInput.md) |  | 
**Tags** | Pointer to **[]string** |  | [optional] 
**SkipDuplicates** | Pointer to **bool** |  | [optional] [default to true]
**ComplianceAcknowledged** | **bool** | Must be true to confirm the caller has permission to upload these contacts. | 
**DisclaimerVersion** | Pointer to **string** |  | [optional] [default to "v1.0"]

## Methods

### NewLeadUploadRequest

`func NewLeadUploadRequest(campaignId int32, leads []LeadInput, complianceAcknowledged bool, ) *LeadUploadRequest`

NewLeadUploadRequest instantiates a new LeadUploadRequest object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewLeadUploadRequestWithDefaults

`func NewLeadUploadRequestWithDefaults() *LeadUploadRequest`

NewLeadUploadRequestWithDefaults instantiates a new LeadUploadRequest object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetCampaignId

`func (o *LeadUploadRequest) GetCampaignId() int32`

GetCampaignId returns the CampaignId field if non-nil, zero value otherwise.

### GetCampaignIdOk

`func (o *LeadUploadRequest) GetCampaignIdOk() (*int32, bool)`

GetCampaignIdOk returns a tuple with the CampaignId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCampaignId

`func (o *LeadUploadRequest) SetCampaignId(v int32)`

SetCampaignId sets CampaignId field to given value.


### GetSource

`func (o *LeadUploadRequest) GetSource() string`

GetSource returns the Source field if non-nil, zero value otherwise.

### GetSourceOk

`func (o *LeadUploadRequest) GetSourceOk() (*string, bool)`

GetSourceOk returns a tuple with the Source field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSource

`func (o *LeadUploadRequest) SetSource(v string)`

SetSource sets Source field to given value.

### HasSource

`func (o *LeadUploadRequest) HasSource() bool`

HasSource returns a boolean if a field has been set.

### GetLeads

`func (o *LeadUploadRequest) GetLeads() []LeadInput`

GetLeads returns the Leads field if non-nil, zero value otherwise.

### GetLeadsOk

`func (o *LeadUploadRequest) GetLeadsOk() (*[]LeadInput, bool)`

GetLeadsOk returns a tuple with the Leads field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLeads

`func (o *LeadUploadRequest) SetLeads(v []LeadInput)`

SetLeads sets Leads field to given value.


### GetTags

`func (o *LeadUploadRequest) GetTags() []string`

GetTags returns the Tags field if non-nil, zero value otherwise.

### GetTagsOk

`func (o *LeadUploadRequest) GetTagsOk() (*[]string, bool)`

GetTagsOk returns a tuple with the Tags field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetTags

`func (o *LeadUploadRequest) SetTags(v []string)`

SetTags sets Tags field to given value.

### HasTags

`func (o *LeadUploadRequest) HasTags() bool`

HasTags returns a boolean if a field has been set.

### GetSkipDuplicates

`func (o *LeadUploadRequest) GetSkipDuplicates() bool`

GetSkipDuplicates returns the SkipDuplicates field if non-nil, zero value otherwise.

### GetSkipDuplicatesOk

`func (o *LeadUploadRequest) GetSkipDuplicatesOk() (*bool, bool)`

GetSkipDuplicatesOk returns a tuple with the SkipDuplicates field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSkipDuplicates

`func (o *LeadUploadRequest) SetSkipDuplicates(v bool)`

SetSkipDuplicates sets SkipDuplicates field to given value.

### HasSkipDuplicates

`func (o *LeadUploadRequest) HasSkipDuplicates() bool`

HasSkipDuplicates returns a boolean if a field has been set.

### GetComplianceAcknowledged

`func (o *LeadUploadRequest) GetComplianceAcknowledged() bool`

GetComplianceAcknowledged returns the ComplianceAcknowledged field if non-nil, zero value otherwise.

### GetComplianceAcknowledgedOk

`func (o *LeadUploadRequest) GetComplianceAcknowledgedOk() (*bool, bool)`

GetComplianceAcknowledgedOk returns a tuple with the ComplianceAcknowledged field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetComplianceAcknowledged

`func (o *LeadUploadRequest) SetComplianceAcknowledged(v bool)`

SetComplianceAcknowledged sets ComplianceAcknowledged field to given value.


### GetDisclaimerVersion

`func (o *LeadUploadRequest) GetDisclaimerVersion() string`

GetDisclaimerVersion returns the DisclaimerVersion field if non-nil, zero value otherwise.

### GetDisclaimerVersionOk

`func (o *LeadUploadRequest) GetDisclaimerVersionOk() (*string, bool)`

GetDisclaimerVersionOk returns a tuple with the DisclaimerVersion field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDisclaimerVersion

`func (o *LeadUploadRequest) SetDisclaimerVersion(v string)`

SetDisclaimerVersion sets DisclaimerVersion field to given value.

### HasDisclaimerVersion

`func (o *LeadUploadRequest) HasDisclaimerVersion() bool`

HasDisclaimerVersion returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


