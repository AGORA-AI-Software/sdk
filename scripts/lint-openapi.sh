#!/usr/bin/env bash
set -euo pipefail

spec="${1:-openapi/agora-public-api.yaml}"

if [[ ! -f "$spec" ]]; then
  echo "OpenAPI spec not found: $spec" >&2
  exit 1
fi

required_patterns=(
  "title: Agora Public API"
  "operationId: loginWithApiKey"
  "operationId: uploadLeads"
  "bearerAuth:"
)

for pattern in "${required_patterns[@]}"; do
  if ! grep -Fq "$pattern" "$spec"; then
    echo "Missing required public OpenAPI metadata: $pattern" >&2
    exit 1
  fi
done

forbidden_patterns=(
  "auth/settings/api-keys"
  "/admin"
  "/dashboard"
  "/rum"
  "/firebase"
  "/Firebase"
)

for pattern in "${forbidden_patterns[@]}"; do
  if grep -Fq "$pattern" "$spec"; then
    echo "Forbidden internal API marker found in public OpenAPI spec: $pattern" >&2
    exit 1
  fi
done

echo "Public OpenAPI safety checks passed for $spec"
