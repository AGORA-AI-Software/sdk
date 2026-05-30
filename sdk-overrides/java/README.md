# Agora Public API — Java SDK

Java client for the Agora Public API. Authenticate with an API key and upload leads to authorized campaigns.

## Install

**Maven:**

```xml
<dependency>
  <groupId>ai.agora</groupId>
  <artifactId>agora-public-api</artifactId>
  <version>0.1.0</version>
</dependency>
```

**Gradle:**

```groovy
implementation 'ai.agora:agora-public-api:0.1.0'
```

Requires Java 11+.

## How-To

### Authenticate and upload leads

```java
import ai.agora.publicapi.*;
import ai.agora.publicapi.api.*;
import ai.agora.publicapi.model.*;
import java.util.List;

ApiClient client = new ApiClient();
client.setBasePath("https://core.agoraai.tech/api/v1");

// Exchange API key for bearer token
AuthenticationApi auth = new AuthenticationApi(client);
ApiKeyTokenResponse tokenResponse = auth.loginWithApiKey(
    new ApiKeyTokenRequest().apiKey("agora_live_REDACTED")
);

// Use bearer token for lead upload
((HttpBearerAuth) client.getAuthentication("bearerAuth"))
    .setBearerToken(tokenResponse.getAccessToken());

LeadsApi leads = new LeadsApi(client);
LeadUploadResponse response = leads.uploadLeads(
    new LeadUploadRequest()
        .campaignId(1)
        .leads(List.of(
            new LeadInput()
                .firstName("Jane")
                .lastName("Doe")
                .phone("+15551234567")
        ))
        .complianceAcknowledged(true)
);

System.out.println(response.getStatus());
```

### Target the development environment

```java
client.setBasePath("https://core-dev.agoraai.tech/api/v1");
```

## Reference

- [Authentication API](docs/AuthenticationApi.md)
- [Leads API](docs/LeadsApi.md)
- [LeadInput model](docs/LeadInput.md)
- [LeadUploadRequest model](docs/LeadUploadRequest.md)
- [LeadUploadResponse model](docs/LeadUploadResponse.md)

## Development

```bash
mvn -B test
```
