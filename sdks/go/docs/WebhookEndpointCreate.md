# WebhookEndpointCreate

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Url** | **string** | HTTPS URL Agora will POST events to. | 
**Description** | Pointer to **string** | Optional human-readable label for this endpoint. | [optional] 
**SubscribedEvents** | Pointer to **[]string** | Event types to subscribe to. Use &#x60;listWebhookEventTypes&#x60; for valid values. | [optional] [default to []]
**IsEnabled** | Pointer to **bool** | Whether the endpoint should receive deliveries. | [optional] [default to true]

## Methods

### NewWebhookEndpointCreate

`func NewWebhookEndpointCreate(url string, ) *WebhookEndpointCreate`

NewWebhookEndpointCreate instantiates a new WebhookEndpointCreate object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewWebhookEndpointCreateWithDefaults

`func NewWebhookEndpointCreateWithDefaults() *WebhookEndpointCreate`

NewWebhookEndpointCreateWithDefaults instantiates a new WebhookEndpointCreate object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetUrl

`func (o *WebhookEndpointCreate) GetUrl() string`

GetUrl returns the Url field if non-nil, zero value otherwise.

### GetUrlOk

`func (o *WebhookEndpointCreate) GetUrlOk() (*string, bool)`

GetUrlOk returns a tuple with the Url field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUrl

`func (o *WebhookEndpointCreate) SetUrl(v string)`

SetUrl sets Url field to given value.


### GetDescription

`func (o *WebhookEndpointCreate) GetDescription() string`

GetDescription returns the Description field if non-nil, zero value otherwise.

### GetDescriptionOk

`func (o *WebhookEndpointCreate) GetDescriptionOk() (*string, bool)`

GetDescriptionOk returns a tuple with the Description field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDescription

`func (o *WebhookEndpointCreate) SetDescription(v string)`

SetDescription sets Description field to given value.

### HasDescription

`func (o *WebhookEndpointCreate) HasDescription() bool`

HasDescription returns a boolean if a field has been set.

### GetSubscribedEvents

`func (o *WebhookEndpointCreate) GetSubscribedEvents() []string`

GetSubscribedEvents returns the SubscribedEvents field if non-nil, zero value otherwise.

### GetSubscribedEventsOk

`func (o *WebhookEndpointCreate) GetSubscribedEventsOk() (*[]string, bool)`

GetSubscribedEventsOk returns a tuple with the SubscribedEvents field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSubscribedEvents

`func (o *WebhookEndpointCreate) SetSubscribedEvents(v []string)`

SetSubscribedEvents sets SubscribedEvents field to given value.

### HasSubscribedEvents

`func (o *WebhookEndpointCreate) HasSubscribedEvents() bool`

HasSubscribedEvents returns a boolean if a field has been set.

### GetIsEnabled

`func (o *WebhookEndpointCreate) GetIsEnabled() bool`

GetIsEnabled returns the IsEnabled field if non-nil, zero value otherwise.

### GetIsEnabledOk

`func (o *WebhookEndpointCreate) GetIsEnabledOk() (*bool, bool)`

GetIsEnabledOk returns a tuple with the IsEnabled field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetIsEnabled

`func (o *WebhookEndpointCreate) SetIsEnabled(v bool)`

SetIsEnabled sets IsEnabled field to given value.

### HasIsEnabled

`func (o *WebhookEndpointCreate) HasIsEnabled() bool`

HasIsEnabled returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


