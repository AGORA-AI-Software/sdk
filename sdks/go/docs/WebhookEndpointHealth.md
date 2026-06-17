# WebhookEndpointHealth

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**EndpointId** | **int32** |  | 
**Url** | **string** |  | 
**IsEnabled** | **bool** |  | 
**TotalDeliveries** | **int32** | Total number of delivery attempts recorded. | 
**SuccessfulDeliveries** | **int32** | Deliveries that received a 2xx response within 10 seconds. | 
**FailedDeliveries** | **int32** | Deliveries that timed out or received a non-2xx response. | 
**SuccessRate** | Pointer to **float32** | Ratio of successful to total deliveries (0–1). Null if no deliveries yet. | [optional] 
**LastDeliveryAt** | Pointer to **time.Time** | Timestamp of the most recent delivery attempt. | [optional] 
**LastDeliveryIsSuccessful** | Pointer to **bool** | Outcome of the most recent delivery attempt. | [optional] 
**AvgDurationMs** | Pointer to **float32** | Average round-trip time in milliseconds across all recorded deliveries. | [optional] 

## Methods

### NewWebhookEndpointHealth

`func NewWebhookEndpointHealth(endpointId int32, url string, isEnabled bool, totalDeliveries int32, successfulDeliveries int32, failedDeliveries int32, ) *WebhookEndpointHealth`

NewWebhookEndpointHealth instantiates a new WebhookEndpointHealth object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewWebhookEndpointHealthWithDefaults

`func NewWebhookEndpointHealthWithDefaults() *WebhookEndpointHealth`

NewWebhookEndpointHealthWithDefaults instantiates a new WebhookEndpointHealth object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetEndpointId

`func (o *WebhookEndpointHealth) GetEndpointId() int32`

GetEndpointId returns the EndpointId field if non-nil, zero value otherwise.

### GetEndpointIdOk

`func (o *WebhookEndpointHealth) GetEndpointIdOk() (*int32, bool)`

GetEndpointIdOk returns a tuple with the EndpointId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetEndpointId

`func (o *WebhookEndpointHealth) SetEndpointId(v int32)`

SetEndpointId sets EndpointId field to given value.


### GetUrl

`func (o *WebhookEndpointHealth) GetUrl() string`

GetUrl returns the Url field if non-nil, zero value otherwise.

### GetUrlOk

`func (o *WebhookEndpointHealth) GetUrlOk() (*string, bool)`

GetUrlOk returns a tuple with the Url field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUrl

`func (o *WebhookEndpointHealth) SetUrl(v string)`

SetUrl sets Url field to given value.


### GetIsEnabled

`func (o *WebhookEndpointHealth) GetIsEnabled() bool`

GetIsEnabled returns the IsEnabled field if non-nil, zero value otherwise.

### GetIsEnabledOk

`func (o *WebhookEndpointHealth) GetIsEnabledOk() (*bool, bool)`

GetIsEnabledOk returns a tuple with the IsEnabled field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetIsEnabled

`func (o *WebhookEndpointHealth) SetIsEnabled(v bool)`

SetIsEnabled sets IsEnabled field to given value.


### GetTotalDeliveries

`func (o *WebhookEndpointHealth) GetTotalDeliveries() int32`

GetTotalDeliveries returns the TotalDeliveries field if non-nil, zero value otherwise.

### GetTotalDeliveriesOk

`func (o *WebhookEndpointHealth) GetTotalDeliveriesOk() (*int32, bool)`

GetTotalDeliveriesOk returns a tuple with the TotalDeliveries field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetTotalDeliveries

`func (o *WebhookEndpointHealth) SetTotalDeliveries(v int32)`

SetTotalDeliveries sets TotalDeliveries field to given value.


### GetSuccessfulDeliveries

`func (o *WebhookEndpointHealth) GetSuccessfulDeliveries() int32`

GetSuccessfulDeliveries returns the SuccessfulDeliveries field if non-nil, zero value otherwise.

### GetSuccessfulDeliveriesOk

`func (o *WebhookEndpointHealth) GetSuccessfulDeliveriesOk() (*int32, bool)`

GetSuccessfulDeliveriesOk returns a tuple with the SuccessfulDeliveries field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSuccessfulDeliveries

`func (o *WebhookEndpointHealth) SetSuccessfulDeliveries(v int32)`

SetSuccessfulDeliveries sets SuccessfulDeliveries field to given value.


### GetFailedDeliveries

`func (o *WebhookEndpointHealth) GetFailedDeliveries() int32`

GetFailedDeliveries returns the FailedDeliveries field if non-nil, zero value otherwise.

### GetFailedDeliveriesOk

`func (o *WebhookEndpointHealth) GetFailedDeliveriesOk() (*int32, bool)`

GetFailedDeliveriesOk returns a tuple with the FailedDeliveries field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetFailedDeliveries

`func (o *WebhookEndpointHealth) SetFailedDeliveries(v int32)`

SetFailedDeliveries sets FailedDeliveries field to given value.


### GetSuccessRate

`func (o *WebhookEndpointHealth) GetSuccessRate() float32`

GetSuccessRate returns the SuccessRate field if non-nil, zero value otherwise.

### GetSuccessRateOk

`func (o *WebhookEndpointHealth) GetSuccessRateOk() (*float32, bool)`

GetSuccessRateOk returns a tuple with the SuccessRate field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetSuccessRate

`func (o *WebhookEndpointHealth) SetSuccessRate(v float32)`

SetSuccessRate sets SuccessRate field to given value.

### HasSuccessRate

`func (o *WebhookEndpointHealth) HasSuccessRate() bool`

HasSuccessRate returns a boolean if a field has been set.

### GetLastDeliveryAt

`func (o *WebhookEndpointHealth) GetLastDeliveryAt() time.Time`

GetLastDeliveryAt returns the LastDeliveryAt field if non-nil, zero value otherwise.

### GetLastDeliveryAtOk

`func (o *WebhookEndpointHealth) GetLastDeliveryAtOk() (*time.Time, bool)`

GetLastDeliveryAtOk returns a tuple with the LastDeliveryAt field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastDeliveryAt

`func (o *WebhookEndpointHealth) SetLastDeliveryAt(v time.Time)`

SetLastDeliveryAt sets LastDeliveryAt field to given value.

### HasLastDeliveryAt

`func (o *WebhookEndpointHealth) HasLastDeliveryAt() bool`

HasLastDeliveryAt returns a boolean if a field has been set.

### GetLastDeliveryIsSuccessful

`func (o *WebhookEndpointHealth) GetLastDeliveryIsSuccessful() bool`

GetLastDeliveryIsSuccessful returns the LastDeliveryIsSuccessful field if non-nil, zero value otherwise.

### GetLastDeliveryIsSuccessfulOk

`func (o *WebhookEndpointHealth) GetLastDeliveryIsSuccessfulOk() (*bool, bool)`

GetLastDeliveryIsSuccessfulOk returns a tuple with the LastDeliveryIsSuccessful field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastDeliveryIsSuccessful

`func (o *WebhookEndpointHealth) SetLastDeliveryIsSuccessful(v bool)`

SetLastDeliveryIsSuccessful sets LastDeliveryIsSuccessful field to given value.

### HasLastDeliveryIsSuccessful

`func (o *WebhookEndpointHealth) HasLastDeliveryIsSuccessful() bool`

HasLastDeliveryIsSuccessful returns a boolean if a field has been set.

### GetAvgDurationMs

`func (o *WebhookEndpointHealth) GetAvgDurationMs() float32`

GetAvgDurationMs returns the AvgDurationMs field if non-nil, zero value otherwise.

### GetAvgDurationMsOk

`func (o *WebhookEndpointHealth) GetAvgDurationMsOk() (*float32, bool)`

GetAvgDurationMsOk returns a tuple with the AvgDurationMs field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetAvgDurationMs

`func (o *WebhookEndpointHealth) SetAvgDurationMs(v float32)`

SetAvgDurationMs sets AvgDurationMs field to given value.

### HasAvgDurationMs

`func (o *WebhookEndpointHealth) HasAvgDurationMs() bool`

HasAvgDurationMs returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


