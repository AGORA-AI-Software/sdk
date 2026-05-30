#!/usr/bin/env bash
set -euo pipefail

config_path="${1:-restish/agora.restish.json}"
spec_path="${2:-openapi/agora-public-api.yaml}"
restish_bin="${RESTISH:-tools/restish/restish}"

mkdir -p "$(dirname "$config_path")"

if [[ ! -x "$restish_bin" ]]; then
  echo "Restish binary not found at $restish_bin. Run: make install-restish" >&2
  exit 1
fi

"$restish_bin" --rsh-config "$config_path" \
  api connect agora https://core-dev.agoraai.tech \
  --spec "$spec_path" \
  --yes --replace \
  'prompt.credentials.bearerAuth.token: env:AGORA_ACCESS_TOKEN'

node -e '
const fs = require("fs");
const path = process.argv[1];
const config = JSON.parse(fs.readFileSync(path, "utf8"));
delete config.apis?.agora?.profiles?.default?.auth;
fs.writeFileSync(path, `${JSON.stringify(config, null, 2)}\n`);
' "$config_path"

echo "Wrote $config_path"
echo "Run: $restish_bin --rsh-config $config_path agora --help"
