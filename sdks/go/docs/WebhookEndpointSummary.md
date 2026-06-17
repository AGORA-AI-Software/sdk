# WebhookEndpointSummary

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Id** | **int32** |  | 
**CampaignId** | **int32** |  | 
**Url** | **string** | Destination URL events are delivered to. | 
**Description** | Pointer to **string** |  | [optional] 
**SubscribedEvents** | **[]string** | Event types this endpoint is subscribed to. | 
**IsEnabled** | **bool** |  | 
**CreatedAt** | **time.Time** |  | 
**LastDeliveryIsSuccessful** | Pointer to **bool** | Outcome of the most recent delivery attempt, or null if no deliveries yet. | [optional] 

## Methods

### NewWebhookEndpointSummary

`func NewWebhookEndpointSummary(id int32, campaignId int32, url string, subscribedEvents []string, isEnabled bool, createdAt time.Time, ) *WebhookEndpointSummary`

NewWebhookEndpointSummary instantiates a new WebhookEndpointSummary object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewWebhookEndpointSummaryWithDefaults

`func NewWebhookEndpointSummaryWithDefaults() *WebhookEndpointSummary`

NewWebhookEndpointSummaryWithDefaults instantiates a new WebhookEndpointSummary object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetId

`func (o *WebhookEndpointSummary) GetId() int32`

GetId returns the Id field if non-nil, zero value otherwise.

### GetIdOk

`func (o *WebhookEndpointSummary) GetIdOk() (*int32, bool)`

GetIdOk returns a tuple with the Id field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetId

`func (o *WebhookEndpointSummary) SetId(v int32)`

SetId sets Id field to given value.


### GetCampaignId

`func (o *WebhookEndpointSummary) GetCampaignId() int32`

GetCampaignId returns the CampaignId field if non-nil, zero value otherwise.

### GetCampaignIdOk

`func (o *WebhookEndpointSummary) GetCampaignIdOk() (*int32, bool)`

GetCampaignIdOk returns a tuple with the CampaignId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCampaignId

`func (o *WebhookEndpointSummary) SetCampaignId(v int32)`

SetCampaignId sets CampaignId field to given value.


### GetUrl

`func (o *WebhookEndpointSummary) GetUrl() string`

GetUrl returns the Url field if non-nil, zero value otherwise.

### GetUrlOk

`func (o *WebhookEndpointSummary) GetUrlOk() (*string, bool)`

GetUrlOk returns a tuple with the Url field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUrl

`func (o *WebhookEndpointSummary) SetUrl(v string)`

SetUrl sets Url field to given value.


### GetDescription

`func (o *WebhookEndpointSummary) GetDescription() string`

GetDescription returns the Description field if non-nil, zero value otherwise.

### GetDescriptionOk

`func (o *WebhookEndpointSummary) GetDescriptionOk() (*string, bool)`

GetDescriptionOk returns a tuple with the Description field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDescription

`func (o *WebhookEndpointSummary) SetDescription(v string)`

SetDescription sets Description field to given value.

### HasDescription

`func (o *WebhookEndpointSummary) HasDescription() bool`

HasDescription returns a boolean if a field has been set.

### GetSubscribedEvents

`func (o *WebhookEndpointSummary) GetSubscribedEvents() []string`

GetSubscribedEvents returns the SubscribedEvents field if non-nil, zero value otherwise.

### GetSubscribedEventsOk

`func (o *WebhookEndpointSummary) GetSubscribedEventsOk() (*[]string, bool)`

GetSubscribedEventsOk returns a tuple with the SubscribedEvents field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSubscribedEvents

`func (o *WebhookEndpointSummary) SetSubscribedEvents(v []string)`

SetSubscribedEvents sets SubscribedEvents field to given value.


### GetIsEnabled

`func (o *WebhookEndpointSummary) GetIsEnabled() bool`

GetIsEnabled returns the IsEnabled field if non-nil, zero value otherwise.

### GetIsEnabledOk

`func (o *WebhookEndpointSummary) GetIsEnabledOk() (*bool, bool)`

GetIsEnabledOk returns a tuple with the IsEnabled field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetIsEnabled

`func (o *WebhookEndpointSummary) SetIsEnabled(v bool)`

SetIsEnabled sets IsEnabled field to given value.


### GetCreatedAt

`func (o *WebhookEndpointSummary) GetCreatedAt() time.Time`

GetCreatedAt returns the CreatedAt field if non-nil, zero value otherwise.

### GetCreatedAtOk

`func (o *WebhookEndpointSummary) GetCreatedAtOk() (*time.Time, bool)`

GetCreatedAtOk returns a tuple with the CreatedAt field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCreatedAt

`func (o *WebhookEndpointSummary) SetCreatedAt(v time.Time)`

SetCreatedAt sets CreatedAt field to given value.


### GetLastDeliveryIsSuccessful

`func (o *WebhookEndpointSummary) GetLastDeliveryIsSuccessful() bool`

GetLastDeliveryIsSuccessful returns the LastDeliveryIsSuccessful field if non-nil, zero value otherwise.

### GetLastDeliveryIsSuccessfulOk

`func (o *WebhookEndpointSummary) GetLastDeliveryIsSuccessfulOk() (*bool, bool)`

GetLastDeliveryIsSuccessfulOk returns a tuple with the LastDeliveryIsSuccessful field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastDeliveryIsSuccessful

`func (o *WebhookEndpointSummary) SetLastDeliveryIsSuccessful(v bool)`

SetLastDeliveryIsSuccessful sets LastDeliveryIsSuccessful field to given value.

### HasLastDeliveryIsSuccessful

`func (o *WebhookEndpointSummary) HasLastDeliveryIsSuccessful() bool`

HasLastDeliveryIsSuccessful returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


