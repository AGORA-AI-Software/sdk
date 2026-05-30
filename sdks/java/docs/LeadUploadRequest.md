

# LeadUploadRequest


## Properties

| Name | Type | Description | Notes |
|------------ | ------------- | ------------- | -------------|
|**campaignId** | **Integer** | Target campaign. Required for API-key-derived bearer tokens. |  |
|**source** | **String** |  |  [optional] |
|**leads** | [**List&lt;LeadInput&gt;**](LeadInput.md) |  |  |
|**tags** | **List&lt;String&gt;** |  |  [optional] |
|**skipDuplicates** | **Boolean** |  |  [optional] |
|**complianceAcknowledged** | **Boolean** | Must be true to confirm the caller has permission to upload these contacts. |  |
|**disclaimerVersion** | **String** |  |  [optional] |



