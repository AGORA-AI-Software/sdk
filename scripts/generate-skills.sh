#!/usr/bin/env bash
set -euo pipefail

spec="${OPENAPI_SPEC:-openapi/agora-public-api.yaml}"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -f "$repo_root/$spec" && ! -f "$spec" ]]; then
  echo "OpenAPI spec not found: $spec" >&2
  exit 1
fi

echo "Skills under plugins/agora-api/skills/ are curated against the live Public API contract (not overwritten)."
"${repo_root}/scripts/sync-bob-skills.sh"
"${repo_root}/scripts/lint-plugin.sh" "${repo_root}/plugins/agora-api"
