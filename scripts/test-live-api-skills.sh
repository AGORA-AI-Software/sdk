#!/usr/bin/env bash
# Verifies AGORA agent skills against the live AGORA Public API.
#
# Usage:
#   ./scripts/test-live-api-skills.sh
#   BASE_URL=https://core.agoraai.tech ./scripts/test-live-api-skills.sh
#   AGORA_API_KEY=agora_live_... BASE_URL=https://core-dev.agoraai.tech ./scripts/test-live-api-skills.sh
#
# Without AGORA_API_KEY: runs read-only OpenAPI parity + unauthenticated & auth-gate contract checks.
# With AGORA_API_KEY: additionally runs safe, read-only authenticated checks across all 6 domains.
set -euo pipefail

BASE_URL="${BASE_URL:-https://core-dev.agoraai.tech}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENDPOINTS_REF="${REPO_ROOT}/plugins/agora-api/skills/agora-public-api/references/endpoints.md"

echo "=== AGORA Live Skill Contract Audit ==="
echo "Target: ${BASE_URL}"

tmp_spec="$(mktemp)"
trap 'rm -f "$tmp_spec"' EXIT

# 1. Fetch live OpenAPI and verify 100% two-way parity with skill reference
curl -fsS "${BASE_URL}/openapi.json" -o "$tmp_spec"

python3 - "$tmp_spec" "$ENDPOINTS_REF" <<'PY'
import json
import re
import sys
from pathlib import Path

spec = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
ref_text = Path(sys.argv[2]).read_text(encoding="utf-8")

live_ops: dict[tuple[str, str], str] = {}
for path, methods in spec.get("paths", {}).items():
    for method, op in methods.items():
        if method.lower() in ("get", "post", "put", "patch", "delete") and isinstance(op, dict):
            live_ops[(method.upper(), path)] = str(op.get("operationId", ""))

doc_ops: dict[tuple[str, str], str] = {}
for m in re.finditer(
    r"^\|\s*`(GET|POST|PUT|PATCH|DELETE)`\s*\|\s*`([^`]+)`\s*\|\s*`([^`]+)`\s*\|",
    ref_text,
    re.MULTILINE,
):
    doc_ops[(m.group(1), m.group(2))] = m.group(3)

missing_from_skills = sorted(set(live_ops) - set(doc_ops))
stale_in_skills = sorted(set(doc_ops) - set(live_ops))
opid_mismatches = sorted(
    (k[0], k[1], live_ops[k], doc_ops[k])
    for k in set(live_ops) & set(doc_ops)
    if live_ops[k] != doc_ops[k]
)

print(f"[PASS] Live OpenAPI endpoints: {len(live_ops)} | Documented in skill reference: {len(doc_ops)}")
if missing_from_skills:
    print("[FAIL] Live endpoints missing from skill reference:", file=sys.stderr)
    for method, path in missing_from_skills:
        print(f"  - {method} {path}", file=sys.stderr)
if stale_in_skills:
    print("[FAIL] Documented endpoints missing from live OpenAPI:", file=sys.stderr)
    for method, path in stale_in_skills:
        print(f"  - {method} {path}", file=sys.stderr)
if opid_mismatches:
    print("[FAIL] operationId mismatch between live OpenAPI and skill reference:", file=sys.stderr)
    for method, path, live_id, doc_id in opid_mismatches:
        print(f"  - {method} {path}: live={live_id} vs doc={doc_id}", file=sys.stderr)
if missing_from_skills or stale_in_skills or opid_mismatches:
    sys.exit(1)
print("[PASS] 100% two-way (method, path, operationId) parity between live OpenAPI and skill reference.")
PY

# 2. Public compliance endpoints
disclaimer_json="$(curl -fsS "${BASE_URL}/api/v1/legal/documents/lead-upload-compliance")"
disclaimer_ver="$(printf '%s' "$disclaimer_json" | python3 -c "import sys,json; d=json.load(sys.stdin); assert d.get('version') and d.get('text'); print(d['version'])")"
echo "[PASS] GET /api/v1/legal/documents/lead-upload-compliance -> HTTP 200 (version=${disclaimer_ver})"

versions_json="$(curl -fsS "${BASE_URL}/api/v1/legal/documents/lead-upload-compliance/versions")"
versions_count="$(printf '%s' "$versions_json" | python3 -c "import sys,json; d=json.load(sys.stdin); assert len(d.get('versions',[]))>=1; print(len(d['versions']))")"
echo "[PASS] GET /api/v1/legal/documents/lead-upload-compliance/versions -> HTTP 200 (${versions_count} version(s))"

# 3. Synthetic invalid API key exchange must return 401
code="$(curl -sS -o /dev/null -w '%{http_code}' -X POST "${BASE_URL}/api/v1/auth/api-key/token" \
  -H 'Content-Type: application/json' \
  -d '{"api_key":"agora_live_0000000000000000"}')"
if [[ "$code" != "401" ]]; then
  echo "[FAIL] Expected 401 for synthetic invalid API key, got ${code}" >&2
  exit 1
fi
echo "[PASS] POST /api/v1/auth/api-key/token (synthetic invalid key) -> HTTP 401"

# 4. Passing raw API key directly as Bearer must return 401 (confirms 2-step auth rule)
code="$(curl -sS -o /dev/null -w '%{http_code}' -X POST "${BASE_URL}/api/v1/leads/upload" \
  -H 'Authorization: Bearer agora_live_0000000000000000' \
  -H 'Content-Type: application/json' \
  -d "{\"campaign_id\":1,\"leads\":[{\"phone\":\"+15551234567\"}],\"compliance_acknowledged\":true,\"disclaimer_version\":\"${disclaimer_ver}\"}")"
if [[ "$code" != "401" ]]; then
  echo "[FAIL] Expected 401 for raw API key used as Bearer token, got ${code}" >&2
  exit 1
fi
echo "[PASS] POST /api/v1/leads/upload (raw API key as Bearer rejected) -> HTTP 401"

# 5. Auth-gated routes across Campaigns, Calls, Webhooks must reject unauthenticated requests
for path in "/api/v1/campaigns/accessible" "/api/v1/calls/" "/api/v1/webhooks/1/events"; do
  code="$(curl -sS -o /dev/null -w '%{http_code}' "${BASE_URL}${path}")"
  if [[ "$code" != "401" ]]; then
    echo "[FAIL] Expected 401 unauthenticated for ${path}, got ${code}" >&2
    exit 1
  fi
  echo "[PASS] GET ${path} (unauthenticated rejected) -> HTTP 401"
done

# 6. Optional authenticated read-only E2E test when AGORA_API_KEY is supplied
if [[ -z "${AGORA_API_KEY:-}" ]]; then
  echo ""
  echo "[SKIP] Authenticated E2E checks (set AGORA_API_KEY=agora_live_... to run full authenticated test)."
  exit 0
fi

echo ""
echo "=== Running Authenticated Read-Only E2E Checks ==="
token_resp="$(curl -fsS -X POST "${BASE_URL}/api/v1/auth/api-key/token" \
  -H 'Content-Type: application/json' \
  -d "{\"api_key\":\"${AGORA_API_KEY}\"}")"
token="$(printf '%s' "$token_resp" | python3 -c "import sys,json; d=json.load(sys.stdin); assert d.get('access_token'); print(d['access_token'])")"
expires_in="$(printf '%s' "$token_resp" | python3 -c "import sys,json; print(json.load(sys.stdin).get('expires_in'))")"
echo "[PASS] POST /api/v1/auth/api-key/token -> HTTP 200 (expires_in=${expires_in}s)"

campaigns_json="$(curl -fsS "${BASE_URL}/api/v1/campaigns/accessible?page=1&per_page=10" \
  -H "Authorization: Bearer ${token}")"
first_campaign_id="$(printf '%s' "$campaigns_json" | python3 -c "import sys,json; d=json.load(sys.stdin); cs=d.get('campaigns',[]); print(cs[0]['id'] if cs else '')")"
campaign_count="$(printf '%s' "$campaigns_json" | python3 -c "import sys,json; print(len(json.load(sys.stdin).get('campaigns',[])))")"
echo "[PASS] GET /api/v1/campaigns/accessible -> HTTP 200 (${campaign_count} campaign(s) returned)"

curl -fsS "${BASE_URL}/api/v1/campaigns/blueprints" -H "Authorization: Bearer ${token}" >/dev/null
echo "[PASS] GET /api/v1/campaigns/blueprints -> HTTP 200"

curl -fsS "${BASE_URL}/api/v1/calls/?per_page=1" -H "Authorization: Bearer ${token}" >/dev/null
echo "[PASS] GET /api/v1/calls/?per_page=1 -> HTTP 200"

if [[ -n "$first_campaign_id" ]]; then
  for subpath in \
    "/api/v1/campaigns/${first_campaign_id}/statuses" \
    "/api/v1/campaigns/${first_campaign_id}/readiness" \
    "/api/v1/campaigns/${first_campaign_id}/launch-readiness" \
    "/api/v1/leads/?campaign_id=${first_campaign_id}&per_page=1" \
    "/api/v1/webhooks/${first_campaign_id}/events" \
    "/api/v1/webhooks/${first_campaign_id}/endpoints"
  do
    curl -fsS "${BASE_URL}${subpath}" -H "Authorization: Bearer ${token}" >/dev/null
    echo "[PASS] GET ${subpath} -> HTTP 200"
  done
else
  echo "[INFO] No accessible campaigns returned for this key; skipping campaign-scoped reads."
fi

echo ""
echo "All live API skill checks passed."
