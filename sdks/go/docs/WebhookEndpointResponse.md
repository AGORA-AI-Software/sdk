# WebhookEndpointResponse

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Id** | **int32** |  | 
**CampaignId** | **int32** |  | 
**Url** | **string** |  | 
**Description** | Pointer to **string** |  | [optional] 
**SubscribedEvents** | **[]string** |  | 
**IsEnabled** | **bool** |  | 
**CreatedAt** | **time.Time** |  | 
**Secret** | Pointer to **string** | Signing secret. Only returned on creation — store it securely. | [optional] 
**LastDeliveryIsSuccessful** | Pointer to **bool** | Outcome of the most recent delivery attempt, or null if no deliveries yet. | [optional] 

## Methods

### NewWebhookEndpointResponse

`func NewWebhookEndpointResponse(id int32, campaignId int32, url string, subscribedEvents []string, isEnabled bool, createdAt time.Time, ) *WebhookEndpointResponse`

NewWebhookEndpointResponse instantiates a new WebhookEndpointResponse object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewWebhookEndpointResponseWithDefaults

`func NewWebhookEndpointResponseWithDefaults() *WebhookEndpointResponse`

NewWebhookEndpointResponseWithDefaults instantiates a new WebhookEndpointResponse object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetId

`func (o *WebhookEndpointResponse) GetId() int32`

GetId returns the Id field if non-nil, zero value otherwise.

### GetIdOk

`func (o *WebhookEndpointResponse) GetIdOk() (*int32, bool)`

GetIdOk returns a tuple with the Id field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetId

`func (o *WebhookEndpointResponse) SetId(v int32)`

SetId sets Id field to given value.


### GetCampaignId

`func (o *WebhookEndpointResponse) GetCampaignId() int32`

GetCampaignId returns the CampaignId field if non-nil, zero value otherwise.

### GetCampaignIdOk

`func (o *WebhookEndpointResponse) GetCampaignIdOk() (*int32, bool)`

GetCampaignIdOk returns a tuple with the CampaignId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCampaignId

`func (o *WebhookEndpointResponse) SetCampaignId(v int32)`

SetCampaignId sets CampaignId field to given value.


### GetUrl

`func (o *WebhookEndpointResponse) GetUrl() string`

GetUrl returns the Url field if non-nil, zero value otherwise.

### GetUrlOk

`func (o *WebhookEndpointResponse) GetUrlOk() (*string, bool)`

GetUrlOk returns a tuple with the Url field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUrl

`func (o *WebhookEndpointResponse) SetUrl(v string)`

SetUrl sets Url field to given value.


### GetDescription

`func (o *WebhookEndpointResponse) GetDescription() string`

GetDescription returns the Description field if non-nil, zero value otherwise.

### GetDescriptionOk

`func (o *WebhookEndpointResponse) GetDescriptionOk() (*string, bool)`

GetDescriptionOk returns a tuple with the Description field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDescription

`func (o *WebhookEndpointResponse) SetDescription(v string)`

SetDescription sets Description field to given value.

### HasDescription

`func (o *WebhookEndpointResponse) HasDescription() bool`

HasDescription returns a boolean if a field has been set.

### GetSubscribedEvents

`func (o *WebhookEndpointResponse) GetSubscribedEvents() []string`

GetSubscribedEvents returns the SubscribedEvents field if non-nil, zero value otherwise.

### GetSubscribedEventsOk

`func (o *WebhookEndpointResponse) GetSubscribedEventsOk() (*[]string, bool)`

GetSubscribedEventsOk returns a tuple with the SubscribedEvents field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSubscribedEvents

`func (o *WebhookEndpointResponse) SetSubscribedEvents(v []string)`

SetSubscribedEvents sets SubscribedEvents field to given value.


### GetIsEnabled

`func (o *WebhookEndpointResponse) GetIsEnabled() bool`

GetIsEnabled returns the IsEnabled field if non-nil, zero value otherwise.

### GetIsEnabledOk

`func (o *WebhookEndpointResponse) GetIsEnabledOk() (*bool, bool)`

GetIsEnabledOk returns a tuple with the IsEnabled field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetIsEnabled

`func (o *WebhookEndpointResponse) SetIsEnabled(v bool)`

SetIsEnabled sets IsEnabled field to given value.


### GetCreatedAt

`func (o *WebhookEndpointResponse) GetCreatedAt() time.Time`

GetCreatedAt returns the CreatedAt field if non-nil, zero value otherwise.

### GetCreatedAtOk

`func (o *WebhookEndpointResponse) GetCreatedAtOk() (*time.Time, bool)`

GetCreatedAtOk returns a tuple with the CreatedAt field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCreatedAt

`func (o *WebhookEndpointResponse) SetCreatedAt(v time.Time)`

SetCreatedAt sets CreatedAt field to given value.


### GetSecret

`func (o *WebhookEndpointResponse) GetSecret() string`

GetSecret returns the Secret field if non-nil, zero value otherwise.

### GetSecretOk

`func (o *WebhookEndpointResponse) GetSecretOk() (*string, bool)`

GetSecretOk returns a tuple with the Secret field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSecret

`func (o *WebhookEndpointResponse) SetSecret(v string)`

SetSecret sets Secret field to given value.

### HasSecret

`func (o *WebhookEndpointResponse) HasSecret() bool`

HasSecret returns a boolean if a field has been set.

### GetLastDeliveryIsSuccessful

`func (o *WebhookEndpointResponse) GetLastDeliveryIsSuccessful() bool`

GetLastDeliveryIsSuccessful returns the LastDeliveryIsSuccessful field if non-nil, zero value otherwise.

### GetLastDeliveryIsSuccessfulOk

`func (o *WebhookEndpointResponse) GetLastDeliveryIsSuccessfulOk() (*bool, bool)`

GetLastDeliveryIsSuccessfulOk returns a tuple with the LastDeliveryIsSuccessful field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastDeliveryIsSuccessful

`func (o *WebhookEndpointResponse) SetLastDeliveryIsSuccessful(v bool)`

SetLastDeliveryIsSuccessful sets LastDeliveryIsSuccessful field to given value.

### HasLastDeliveryIsSuccessful

`func (o *WebhookEndpointResponse) HasLastDeliveryIsSuccessful() bool`

HasLastDeliveryIsSuccessful returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


