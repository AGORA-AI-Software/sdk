#!/usr/bin/env bash
# Exchanges AGORA_API_KEY for a bearer token and prints {"token": "..."} for restish external-tool auth.
# Usage: scripts/get-token.sh [base_url]
# Default base_url: https://core.agoraai.tech
set -euo pipefail

base_url="${1:-https://core.agoraai.tech}"

if [[ -z "${AGORA_API_KEY:-}" ]]; then
  echo "Error: AGORA_API_KEY is not set" >&2
  exit 1
fi

response=$(curl -fsSL -X POST "${base_url}/api/v1/auth/api-key/token" \
  -H "Content-Type: application/json" \
  -d "{\"api_key\":\"${AGORA_API_KEY}\"}")

access_token=$(echo "$response" | python3 -c "import json,sys; print(json.load(sys.stdin)['access_token'])")
echo "{\"access_token\": \"${access_token}\"}"
