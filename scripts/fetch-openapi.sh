#!/usr/bin/env bash
set -euo pipefail

url="${1:-https://core-dev.agoraai.tech/openapi.json}"
out="${2:-openapi/agora-public-api.yaml}"

mkdir -p "$(dirname "$out")"
tmp="${out}.tmp"

curl -fsS "$url" -o "$tmp"

if ! grep -Eq '"openapi"[[:space:]]*:|^openapi:' "$tmp"; then
  rm -f "$tmp"
  echo "Downloaded document does not look like an OpenAPI document: $url" >&2
  exit 1
fi

mv "$tmp" "$out"
echo "Wrote $out from $url"
