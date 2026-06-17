# WebhookEndpointUpdate

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Url** | Pointer to **string** | New destination URL. | [optional] 
**Description** | Pointer to **string** |  | [optional] 
**SubscribedEvents** | Pointer to **[]string** | Replaces the full subscribed event list. | [optional] 
**IsEnabled** | Pointer to **bool** |  | [optional] 

## Methods

### NewWebhookEndpointUpdate

`func NewWebhookEndpointUpdate() *WebhookEndpointUpdate`

NewWebhookEndpointUpdate instantiates a new WebhookEndpointUpdate object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewWebhookEndpointUpdateWithDefaults

`func NewWebhookEndpointUpdateWithDefaults() *WebhookEndpointUpdate`

NewWebhookEndpointUpdateWithDefaults instantiates a new WebhookEndpointUpdate object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetUrl

`func (o *WebhookEndpointUpdate) GetUrl() string`

GetUrl returns the Url field if non-nil, zero value otherwise.

### GetUrlOk

`func (o *WebhookEndpointUpdate) GetUrlOk() (*string, bool)`

GetUrlOk returns a tuple with the Url field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUrl

`func (o *WebhookEndpointUpdate) SetUrl(v string)`

SetUrl sets Url field to given value.

### HasUrl

`func (o *WebhookEndpointUpdate) HasUrl() bool`

HasUrl returns a boolean if a field has been set.

### GetDescription

`func (o *WebhookEndpointUpdate) GetDescription() string`

GetDescription returns the Description field if non-nil, zero value otherwise.

### GetDescriptionOk

`func (o *WebhookEndpointUpdate) GetDescriptionOk() (*string, bool)`

GetDescriptionOk returns a tuple with the Description field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDescription

`func (o *WebhookEndpointUpdate) SetDescription(v string)`

SetDescription sets Description field to given value.

### HasDescription

`func (o *WebhookEndpointUpdate) HasDescription() bool`

HasDescription returns a boolean if a field has been set.

### GetSubscribedEvents

`func (o *WebhookEndpointUpdate) GetSubscribedEvents() []string`

GetSubscribedEvents returns the SubscribedEvents field if non-nil, zero value otherwise.

### GetSubscribedEventsOk

`func (o *WebhookEndpointUpdate) GetSubscribedEventsOk() (*[]string, bool)`

GetSubscribedEventsOk returns a tuple with the SubscribedEvents field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSubscribedEvents

`func (o *WebhookEndpointUpdate) SetSubscribedEvents(v []string)`

SetSubscribedEvents sets SubscribedEvents field to given value.

### HasSubscribedEvents

`func (o *WebhookEndpointUpdate) HasSubscribedEvents() bool`

HasSubscribedEvents returns a boolean if a field has been set.

### GetIsEnabled

`func (o *WebhookEndpointUpdate) GetIsEnabled() bool`

GetIsEnabled returns the IsEnabled field if non-nil, zero value otherwise.

### GetIsEnabledOk

`func (o *WebhookEndpointUpdate) GetIsEnabledOk() (*bool, bool)`

GetIsEnabledOk returns a tuple with the IsEnabled field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetIsEnabled

`func (o *WebhookEndpointUpdate) SetIsEnabled(v bool)`

SetIsEnabled sets IsEnabled field to given value.

### HasIsEnabled

`func (o *WebhookEndpointUpdate) HasIsEnabled() bool`

HasIsEnabled returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


