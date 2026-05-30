# Agora Public API — Python SDK

Python client for the Agora Public API. Authenticate with an API key and upload leads to authorized campaigns.

## Install

```bash
pip install agora-public-api
```

Requires Python 3.8+.

## How-To

### Authenticate and upload leads

```python
import agora_public_api
from agora_public_api.api import authentication_api, leads_api
from agora_public_api.model.api_key_token_request import ApiKeyTokenRequest
from agora_public_api.model.lead_upload_request import LeadUploadRequest
from agora_public_api.model.lead_input import LeadInput

configuration = agora_public_api.Configuration(
    host="https://core.agoraai.tech/api/v1"
)

with agora_public_api.ApiClient(configuration) as client:
    # Exchange API key for bearer token
    auth = authentication_api.AuthenticationApi(client)
    token_response = auth.login_with_api_key(
        ApiKeyTokenRequest(api_key="agora_live_REDACTED")
    )

    # Use bearer token for lead upload
    configuration.access_token = token_response.access_token
    leads = leads_api.LeadsApi(client)
    response = leads.upload_leads(
        LeadUploadRequest(
            campaign_id=1,
            leads=[LeadInput(
                first_name="Jane",
                last_name="Doe",
                email="jane.doe@example.test",
                phone="+15551234567",
            )],
            compliance_acknowledged=True,
        )
    )
    print(response.status)
```

### Target the development environment

```python
configuration = agora_public_api.Configuration(
    host="https://core-dev.agoraai.tech/api/v1"
)
```

## Reference

- [Authentication API](docs/AuthenticationApi.md)
- [Leads API](docs/LeadsApi.md)
- [LeadInput model](docs/LeadInput.md)
- [LeadUploadRequest model](docs/LeadUploadRequest.md)
- [LeadUploadResponse model](docs/LeadUploadResponse.md)

## Development

```bash
pip install -e ".[dev]"
pytest
```
