# LeadInput

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**FirstName** | Pointer to **string** |  | [optional] 
**LastName** | Pointer to **string** |  | [optional] 
**Email** | Pointer to **string** |  | [optional] 
**Phone** | **string** | E.164 formatted phone number is preferred. | 
**Company** | Pointer to **string** |  | [optional] 
**Title** | Pointer to **string** |  | [optional] 

## Methods

### NewLeadInput

`func NewLeadInput(phone string, ) *LeadInput`

NewLeadInput instantiates a new LeadInput object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewLeadInputWithDefaults

`func NewLeadInputWithDefaults() *LeadInput`

NewLeadInputWithDefaults instantiates a new LeadInput object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetFirstName

`func (o *LeadInput) GetFirstName() string`

GetFirstName returns the FirstName field if non-nil, zero value otherwise.

### GetFirstNameOk

`func (o *LeadInput) GetFirstNameOk() (*string, bool)`

GetFirstNameOk returns a tuple with the FirstName field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetFirstName

`func (o *LeadInput) SetFirstName(v string)`

SetFirstName sets FirstName field to given value.

### HasFirstName

`func (o *LeadInput) HasFirstName() bool`

HasFirstName returns a boolean if a field has been set.

### GetLastName

`func (o *LeadInput) GetLastName() string`

GetLastName returns the LastName field if non-nil, zero value otherwise.

### GetLastNameOk

`func (o *LeadInput) GetLastNameOk() (*string, bool)`

GetLastNameOk returns a tuple with the LastName field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastName

`func (o *LeadInput) SetLastName(v string)`

SetLastName sets LastName field to given value.

### HasLastName

`func (o *LeadInput) HasLastName() bool`

HasLastName returns a boolean if a field has been set.

### GetEmail

`func (o *LeadInput) GetEmail() string`

GetEmail returns the Email field if non-nil, zero value otherwise.

### GetEmailOk

`func (o *LeadInput) GetEmailOk() (*string, bool)`

GetEmailOk returns a tuple with the Email field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetEmail

`func (o *LeadInput) SetEmail(v string)`

SetEmail sets Email field to given value.

### HasEmail

`func (o *LeadInput) HasEmail() bool`

HasEmail returns a boolean if a field has been set.

### GetPhone

`func (o *LeadInput) GetPhone() string`

GetPhone returns the Phone field if non-nil, zero value otherwise.

### GetPhoneOk

`func (o *LeadInput) GetPhoneOk() (*string, bool)`

GetPhoneOk returns a tuple with the Phone field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetPhone

`func (o *LeadInput) SetPhone(v string)`

SetPhone sets Phone field to given value.


### GetCompany

`func (o *LeadInput) GetCompany() string`

GetCompany returns the Company field if non-nil, zero value otherwise.

### GetCompanyOk

`func (o *LeadInput) GetCompanyOk() (*string, bool)`

GetCompanyOk returns a tuple with the Company field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCompany

`func (o *LeadInput) SetCompany(v string)`

SetCompany sets Company field to given value.

### HasCompany

`func (o *LeadInput) HasCompany() bool`

HasCompany returns a boolean if a field has been set.

### GetTitle

`func (o *LeadInput) GetTitle() string`

GetTitle returns the Title field if non-nil, zero value otherwise.

### GetTitleOk

`func (o *LeadInput) GetTitleOk() (*string, bool)`

GetTitleOk returns a tuple with the Title field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetTitle

`func (o *LeadInput) SetTitle(v string)`

SetTitle sets Title field to given value.

### HasTitle

`func (o *LeadInput) HasTitle() bool`

HasTitle returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


