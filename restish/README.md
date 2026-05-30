# Restish Guide

Restish can discover Agora's public API from the OpenAPI document and expose operation-based commands. This setup follows Restish's `api connect --spec` workflow: https://rest.sh/docs/getting-started/connect-to-an-api/

Install the repo-local Restish binary:

```bash
make install-restish
make setup-restish
make restish-help
```

The committed config file is `restish/agora.restish.json`. It is secret-free and reads the bearer token from `AGORA_ACCESS_TOKEN`.

Log in with an API key:

```bash
tools/restish/restish --rsh-config restish/agora.restish.json \
  agora login-with-api-key \
  'api_key: agora_live_REDACTED'
```

Configure the returned bearer token, then upload a lead:

```bash
export AGORA_ACCESS_TOKEN='PASTE_REDACTED_ACCESS_TOKEN'

tools/restish/restish --rsh-config restish/agora.restish.json \
  agora upload-leads \
  'campaign_id: 1, compliance_acknowledged: true, leads: [{phone: +15551234567}]'
```

The local config points Restish at the checked-in OpenAPI artifact, so the CLI can work before the public `/openapi.json` route is live. After the public route is available, refresh the profile with:

```bash
tools/restish/restish --rsh-config restish/agora.restish.json \
  api connect agora https://core-dev.agoraai.tech \
  --spec https://core-dev.agoraai.tech/openapi.json \
  --yes --replace \
  'prompt.credentials.bearerAuth.token: env:AGORA_ACCESS_TOKEN'
```
