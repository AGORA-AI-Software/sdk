#!/usr/bin/env bash
set -euo pipefail

spec="${OPENAPI_SPEC:-openapi/agora-public-api.yaml}"

./scripts/lint-openapi.sh "$spec"

for dir in sdks/python sdks/typescript sdks/java sdks/go; do
  if [[ ! -d "$dir" ]]; then
    echo "Missing SDK output directory: $dir" >&2
    exit 1
  fi
done

if [[ -f sdks/python/pyproject.toml || -f sdks/typescript/package.json || -f sdks/java/pom.xml || -f sdks/go/go.mod ]]; then
  echo "Generated SDK smoke markers found."
else
  echo "SDK directories exist; generated SDK markers were not found. Run make generate-sdks after installing openapi-generator-cli or Docker."
fi

if command -v go >/dev/null 2>&1; then
  gocache_dir="$(mktemp -d /tmp/agora-go-build.XXXXXX)"
  trap 'rm -rf "$gocache_dir"' EXIT
  (cd sdks/go && GOCACHE="$gocache_dir" go test ./...)
else
  echo "Skipping Go smoke tests because go is not installed." >&2
fi

if command -v mvn >/dev/null 2>&1 && (command -v javac >/dev/null 2>&1 || [[ -x "${JAVA_HOME:-}/bin/javac" ]]); then
  (cd sdks/java && mvn -B test)
else
  echo "Skipping Java smoke tests because mvn or javac is not installed." >&2
fi

echo "SDK repo smoke test passed."
