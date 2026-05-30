#!/usr/bin/env bash
set -euo pipefail

make lint-openapi
make lint-plugin

python3 -m compileall -q sdks/python/agora_public_api
find sdks/python/agora_public_api -type d -name __pycache__ -prune -exec rm -rf {} +

if command -v yarn >/dev/null 2>&1 && [[ -f .pnp.cjs || -d node_modules ]]; then
  yarn workspace @agora-ai/public-api build
else
  echo "Skipping TypeScript build because Yarn dependencies are not installed." >&2
fi

if command -v go >/dev/null 2>&1; then
  gocache_dir="$(mktemp -d /tmp/agora-go-build.XXXXXX)"
  trap 'rm -rf "$gocache_dir"' EXIT
  (cd sdks/go && GOCACHE="$gocache_dir" go test ./...)
else
  echo "Skipping Go tests because go is not installed." >&2
fi

if command -v mvn >/dev/null 2>&1 && (command -v javac >/dev/null 2>&1 || [[ -x "${JAVA_HOME:-}/bin/javac" ]]); then
  (cd sdks/java && mvn -B test)
else
  echo "Skipping Java tests because mvn or javac is not installed." >&2
fi
