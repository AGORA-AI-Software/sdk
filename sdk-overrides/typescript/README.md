# Agora Public API — TypeScript SDK

TypeScript/JavaScript client for the Agora Public API. Authenticate with an API key and upload leads to authorized campaigns.

## Install

```bash
npm install @agora-ai/public-api
# or
yarn add @agora-ai/public-api
```

## How-To

### Authenticate and upload leads

```typescript
import { AuthenticationApi, LeadsApi, Configuration } from "@agora-ai/public-api";

const config = new Configuration({ basePath: "https://core.agoraai.tech/api/v1" });

// Exchange API key for bearer token
const auth = new AuthenticationApi(config);
const { accessToken } = await auth.loginWithApiKey({
  apiKeyTokenRequest: { apiKey: "agora_live_REDACTED" },
});

// Use bearer token for lead upload
const leads = new LeadsApi(
  new Configuration({
    basePath: "https://core.agoraai.tech/api/v1",
    accessToken,
  })
);

const response = await leads.uploadLeads({
  leadUploadRequest: {
    campaignId: 1,
    leads: [{ firstName: "Jane", lastName: "Doe", phone: "+15551234567" }],
    complianceAcknowledged: true,
  },
});

console.log(response.status);
```

### Target the development environment

```typescript
const config = new Configuration({ basePath: "https://core-dev.agoraai.tech/api/v1" });
```

## Reference

- [Authentication API](docs/AuthenticationApi.md)
- [Leads API](docs/LeadsApi.md)
- [LeadInput model](docs/LeadInput.md)
- [LeadUploadRequest model](docs/LeadUploadRequest.md)
- [LeadUploadResponse model](docs/LeadUploadResponse.md)

## Development

```bash
npm install
npm run build
```
