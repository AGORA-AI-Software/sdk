# WebhookDeliveryResponse

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**Id** | **int32** |  | 
**EndpointId** | **int32** |  | 
**EventType** | **string** |  | 
**Payload** | **map[string]interface{}** | Full JSON payload that was sent to the endpoint. | 
**ResponseStatus** | Pointer to **int32** | HTTP status code returned by the endpoint, or null if the request failed to connect. | [optional] 
**ResponseBody** | Pointer to **string** | First 1 KB of the response body. | [optional] 
**DurationMs** | Pointer to **int32** | Round-trip time in milliseconds. | [optional] 
**IsSuccessful** | **bool** | True if the endpoint returned a 2xx status within 10 seconds. | 
**AttemptNumber** | **int32** | 1 for the original delivery, 2 for the automatic retry. | 
**DeliveredAt** | **time.Time** |  | 
**RedeliveryOfId** | Pointer to **int32** | ID of the original delivery if this is a manual redeliver, otherwise null. | [optional] 

## Methods

### NewWebhookDeliveryResponse

`func NewWebhookDeliveryResponse(id int32, endpointId int32, eventType string, payload map[string]interface{}, isSuccessful bool, attemptNumber int32, deliveredAt time.Time, ) *WebhookDeliveryResponse`

NewWebhookDeliveryResponse instantiates a new WebhookDeliveryResponse object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewWebhookDeliveryResponseWithDefaults

`func NewWebhookDeliveryResponseWithDefaults() *WebhookDeliveryResponse`

NewWebhookDeliveryResponseWithDefaults instantiates a new WebhookDeliveryResponse object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetId

`func (o *WebhookDeliveryResponse) GetId() int32`

GetId returns the Id field if non-nil, zero value otherwise.

### GetIdOk

`func (o *WebhookDeliveryResponse) GetIdOk() (*int32, bool)`

GetIdOk returns a tuple with the Id field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetId

`func (o *WebhookDeliveryResponse) SetId(v int32)`

SetId sets Id field to given value.


### GetEndpointId

`func (o *WebhookDeliveryResponse) GetEndpointId() int32`

GetEndpointId returns the EndpointId field if non-nil, zero value otherwise.

### GetEndpointIdOk

`func (o *WebhookDeliveryResponse) GetEndpointIdOk() (*int32, bool)`

GetEndpointIdOk returns a tuple with the EndpointId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetEndpointId

`func (o *WebhookDeliveryResponse) SetEndpointId(v int32)`

SetEndpointId sets EndpointId field to given value.


### GetEventType

`func (o *WebhookDeliveryResponse) GetEventType() string`

GetEventType returns the EventType field if non-nil, zero value otherwise.

### GetEventTypeOk

`func (o *WebhookDeliveryResponse) GetEventTypeOk() (*string, bool)`

GetEventTypeOk returns a tuple with the EventType field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetEventType

`func (o *WebhookDeliveryResponse) SetEventType(v string)`

SetEventType sets EventType field to given value.


### GetPayload

`func (o *WebhookDeliveryResponse) GetPayload() map[string]interface{}`

GetPayload returns the Payload field if non-nil, zero value otherwise.

### GetPayloadOk

`func (o *WebhookDeliveryResponse) GetPayloadOk() (*map[string]interface{}, bool)`

GetPayloadOk returns a tuple with the Payload field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetPayload

`func (o *WebhookDeliveryResponse) SetPayload(v map[string]interface{})`

SetPayload sets Payload field to given value.


### GetResponseStatus

`func (o *WebhookDeliveryResponse) GetResponseStatus() int32`

GetResponseStatus returns the ResponseStatus field if non-nil, zero value otherwise.

### GetResponseStatusOk

`func (o *WebhookDeliveryResponse) GetResponseStatusOk() (*int32, bool)`

GetResponseStatusOk returns a tuple with the ResponseStatus field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetResponseStatus

`func (o *WebhookDeliveryResponse) SetResponseStatus(v int32)`

SetResponseStatus sets ResponseStatus field to given value.

### HasResponseStatus

`func (o *WebhookDeliveryResponse) HasResponseStatus() bool`

HasResponseStatus returns a boolean if a field has been set.

### GetResponseBody

`func (o *WebhookDeliveryResponse) GetResponseBody() string`

GetResponseBody returns the ResponseBody field if non-nil, zero value otherwise.

### GetResponseBodyOk

`func (o *WebhookDeliveryResponse) GetResponseBodyOk() (*string, bool)`

GetResponseBodyOk returns a tuple with the ResponseBody field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetResponseBody

`func (o *WebhookDeliveryResponse) SetResponseBody(v string)`

SetResponseBody sets ResponseBody field to given value.

### HasResponseBody

`func (o *WebhookDeliveryResponse) HasResponseBody() bool`

HasResponseBody returns a boolean if a field has been set.

### GetDurationMs

`func (o *WebhookDeliveryResponse) GetDurationMs() int32`

GetDurationMs returns the DurationMs field if non-nil, zero value otherwise.

### GetDurationMsOk

`func (o *WebhookDeliveryResponse) GetDurationMsOk() (*int32, bool)`

GetDurationMsOk returns a tuple with the DurationMs field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDurationMs

`func (o *WebhookDeliveryResponse) SetDurationMs(v int32)`

SetDurationMs sets DurationMs field to given value.

### HasDurationMs

`func (o *WebhookDeliveryResponse) HasDurationMs() bool`

HasDurationMs returns a boolean if a field has been set.

### GetIsSuccessful

`func (o *WebhookDeliveryResponse) GetIsSuccessful() bool`

GetIsSuccessful returns the IsSuccessful field if non-nil, zero value otherwise.

### GetIsSuccessfulOk

`func (o *WebhookDeliveryResponse) GetIsSuccessfulOk() (*bool, bool)`

GetIsSuccessfulOk returns a tuple with the IsSuccessful field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetIsSuccessful

`func (o *WebhookDeliveryResponse) SetIsSuccessful(v bool)`

SetIsSuccessful sets IsSuccessful field to given value.


### GetAttemptNumber

`func (o *WebhookDeliveryResponse) GetAttemptNumber() int32`

GetAttemptNumber returns the AttemptNumber field if non-nil, zero value otherwise.

### GetAttemptNumberOk

`func (o *WebhookDeliveryResponse) GetAttemptNumberOk() (*int32, bool)`

GetAttemptNumberOk returns a tuple with the AttemptNumber field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetAttemptNumber

`func (o *WebhookDeliveryResponse) SetAttemptNumber(v int32)`

SetAttemptNumber sets AttemptNumber field to given value.


### GetDeliveredAt

`func (o *WebhookDeliveryResponse) GetDeliveredAt() time.Time`

GetDeliveredAt returns the DeliveredAt field if non-nil, zero value otherwise.

### GetDeliveredAtOk

`func (o *WebhookDeliveryResponse) GetDeliveredAtOk() (*time.Time, bool)`

GetDeliveredAtOk returns a tuple with the DeliveredAt field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetDeliveredAt

`func (o *WebhookDeliveryResponse) SetDeliveredAt(v time.Time)`

SetDeliveredAt sets DeliveredAt field to given value.


### GetRedeliveryOfId

`func (o *WebhookDeliveryResponse) GetRedeliveryOfId() int32`

GetRedeliveryOfId returns the RedeliveryOfId field if non-nil, zero value otherwise.

### GetRedeliveryOfIdOk

`func (o *WebhookDeliveryResponse) GetRedeliveryOfIdOk() (*int32, bool)`

GetRedeliveryOfIdOk returns a tuple with the RedeliveryOfId field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetRedeliveryOfId

`func (o *WebhookDeliveryResponse) SetRedeliveryOfId(v int32)`

SetRedeliveryOfId sets RedeliveryOfId field to given value.

### HasRedeliveryOfId

`func (o *WebhookDeliveryResponse) HasRedeliveryOfId() bool`

HasRedeliveryOfId returns a boolean if a field has been set.


[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


