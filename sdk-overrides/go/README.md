# Agora Public API — Go SDK

Go client for the Agora Public API. Authenticate with an API key and upload leads to authorized campaigns.

## Install

```bash
go get github.com/AGORA-AI-Software/sdk/sdks/go@latest
```

Requires Go 1.21+.

## How-To

### Authenticate and upload leads

```go
package main

import (
	"context"
	"fmt"

	agora "github.com/AGORA-AI-Software/sdk/sdks/go"
)

func main() {
	cfg := agora.NewConfiguration()
	cfg.Servers = agora.ServerConfigurations{
		{URL: "https://core.agoraai.tech/api/v1"},
	}
	client := agora.NewAPIClient(cfg)
	ctx := context.Background()

	// Exchange API key for bearer token
	tokenResp, _, err := client.AuthenticationAPI.LoginWithApiKey(ctx).
		ApiKeyTokenRequest(agora.ApiKeyTokenRequest{ApiKey: "agora_live_REDACTED"}).
		Execute()
	if err != nil {
		panic(err)
	}

	// Use bearer token for lead upload
	ctx = context.WithValue(ctx, agora.ContextAccessToken, tokenResp.GetAccessToken())

	phone := "+15551234567"
	resp, _, err := client.LeadsAPI.UploadLeads(ctx).
		LeadUploadRequest(agora.LeadUploadRequest{
			CampaignId: 1,
			Leads:      []agora.LeadInput{{Phone: &phone}},
			ComplianceAcknowledged: true,
		}).
		Execute()
	if err != nil {
		panic(err)
	}

	fmt.Println(resp.GetStatus())
}
```

### Target the development environment

```go
cfg.Servers = agora.ServerConfigurations{
	{URL: "https://core-dev.agoraai.tech/api/v1"},
}
```

## Reference

- [Authentication API](docs/AuthenticationAPI.md)
- [Leads API](docs/LeadsAPI.md)
- [LeadInput model](docs/LeadInput.md)
- [LeadUploadRequest model](docs/LeadUploadRequest.md)
- [LeadUploadResponse model](docs/LeadUploadResponse.md)

## Development

```bash
go test ./...
```
