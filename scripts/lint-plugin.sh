#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="${1:?Usage: lint-plugin.sh <plugin-dir>}"
REQUIRED_FIELDS=(name version description)

find "$PLUGIN_DIR" -name 'plugin.json' | while read -r f; do
  if ! python3 -c "import json,sys; json.load(open('$f'))" 2>/dev/null; then
    echo "ERROR: invalid JSON in $f" >&2
    exit 1
  fi
  for field in "${REQUIRED_FIELDS[@]}"; do
    if ! python3 -c "import json,sys; d=json.load(open('$f')); sys.exit(0 if '$field' in d else 1)" 2>/dev/null; then
      echo "ERROR: missing required field '$field' in $f" >&2
      exit 1
    fi
  done
  echo "OK: $f"
done
