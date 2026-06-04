#!/usr/bin/env bash
set -euo pipefail

spec="${OPENAPI_SPEC:-openapi/agora-public-api.yaml}"
version="${GENERATOR_VERSION:-v7.12.0}"

if [[ ! -f "$spec" ]]; then
  echo "OpenAPI spec not found: $spec" >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
spec_abs="$(cd "$(dirname "$spec")" && pwd)/$(basename "$spec")"

generate_one() {
  local generator="$1"
  local output="$2"
  shift 2

  mkdir -p "$repo_root/$output"

  if command -v openapi-generator-cli >/dev/null 2>&1; then
    openapi-generator-cli generate \
      -i "$spec_abs" \
      -g "$generator" \
      -o "$repo_root/$output" \
      --global-property apiTests=false,modelTests=false \
      "$@"
    return
  fi

  if command -v docker >/dev/null 2>&1; then
    docker run --rm \
      --user "$(id -u):$(id -g)" \
      -v "$repo_root:/local" \
      "openapitools/openapi-generator-cli:${version}" generate \
      -i "/local/${spec}" \
      -g "$generator" \
      -o "/local/${output}" \
      --global-property apiTests=false,modelTests=false \
      "$@"
    return
  fi

  echo "Install openapi-generator-cli or Docker to generate SDKs." >&2
  exit 1
}

generate_one python "sdks/python" \
  --package-name agora_public_api \
  --git-user-id AGORA-AI-Software \
  --git-repo-id sdk \
  --additional-properties packageName=agora_public_api,projectName=agora-public-api,packageVersion=0.1.0,licenseInfo=UNLICENSED

generate_one typescript-fetch "sdks/typescript" \
  --git-user-id AGORA-AI-Software \
  --git-repo-id sdk \
  --additional-properties npmName=@agora-ai/public-api,npmVersion=0.1.0,supportsES6=true,typescriptThreePlus=true

generate_one java "sdks/java" \
  --git-user-id AGORA-AI-Software \
  --git-repo-id sdk \
  --additional-properties groupId=ai.agora,artifactId=agora-public-api,artifactVersion=0.1.0,apiPackage=ai.agora.publicapi.api,modelPackage=ai.agora.publicapi.model,invokerPackage=ai.agora.publicapi,licenseName=UNLICENSED

generate_one go "sdks/go" \
  --git-user-id AGORA-AI-Software \
  --git-repo-id sdk/sdks/go \
  --additional-properties packageName=agorapublicapi,packageVersion=0.1.0

if [[ -f "$repo_root/sdks/python/pyproject.toml" ]]; then
  sed -i '' 's/authors = \["OpenAPI Generator Community <team@openapitools.org>"\]/authors = ["AGORA AI Software <engineering@agoraai.tech>"]/' "$repo_root/sdks/python/pyproject.toml"
  # Security: pin minimum versions to avoid known CVEs
  sed -i '' 's/urllib3 = ">= 1\.25\.3/urllib3 = ">= 2.3.0/' "$repo_root/sdks/python/pyproject.toml"
  sed -i '' 's/pytest = ">= 7\.[0-9]/pytest = ">= 8.1.2/' "$repo_root/sdks/python/pyproject.toml"
fi

if [[ -f "$repo_root/sdks/python/requirements.txt" ]]; then
  sed -i '' 's/urllib3 >= 1\.25\.3/urllib3 >= 2.3.0/' "$repo_root/sdks/python/requirements.txt"
fi

if [[ -f "$repo_root/sdks/python/setup.py" ]]; then
  sed -i '' 's/urllib3 >= 1\.25\.3/urllib3 >= 2.3.0/' "$repo_root/sdks/python/setup.py"
fi

if [[ -f "$repo_root/sdks/python/test-requirements.txt" ]]; then
  sed -i '' 's/pytest >= 7\.[0-9]/pytest >= 8.1.2/' "$repo_root/sdks/python/test-requirements.txt"
fi

if [[ -f "$repo_root/sdks/java/pom.xml" ]]; then
  # Security: pin commons-lang3 to avoid known CVE
  sed -i '' 's/<commons-lang3-version>3\.1[0-9]\.[0-9]</<commons-lang3-version>3.18.0</' "$repo_root/sdks/java/pom.xml"
fi

if [[ -f "$repo_root/sdks/typescript/package.json" ]]; then
  sed -i '' 's/"author": "OpenAPI-Generator"/"author": "AGORA AI Software"/' "$repo_root/sdks/typescript/package.json"
fi

if [[ -f "$repo_root/sdks/go/README.md" ]]; then
  perl -0pi -e 's/Install the following dependencies:\n\n```sh\ngo get github\.com\/stretchr\/testify\/assert\ngo get golang\.org\/x\/net\/context\n```\n\n//' "$repo_root/sdks/go/README.md"
fi

copy_overlay_file() {
  local source="$1"
  local target="$2"

  if [[ -f "$repo_root/$source" ]]; then
    mkdir -p "$(dirname "$repo_root/$target")"
    cp "$repo_root/$source" "$repo_root/$target"
  fi
}

copy_overlay_tree() {
  local source="$1"
  local target="$2"

  if [[ -d "$repo_root/$source" ]]; then
    mkdir -p "$repo_root/$target"
    cp -R "$repo_root/$source/." "$repo_root/$target/"
  fi
}

copy_overlay_file "sdk-overrides/go/smoke_test.go" "sdks/go/smoke_test.go"
copy_overlay_tree "sdk-overrides/java/src/test/java" "sdks/java/src/test/java"

copy_overlay_file "sdk-overrides/python/agora_public_api/api_client.py" "sdks/python/agora_public_api/api_client.py"
copy_overlay_file "sdk-overrides/java/src/main/java/ai/agora/publicapi/ApiClient.java" "sdks/java/src/main/java/ai/agora/publicapi/ApiClient.java"
copy_overlay_file "sdk-overrides/python/README.md" "sdks/python/README.md"
copy_overlay_file "sdk-overrides/typescript/README.md" "sdks/typescript/README.md"
copy_overlay_file "sdk-overrides/java/README.md" "sdks/java/README.md"
copy_overlay_file "sdk-overrides/go/README.md" "sdks/go/README.md"

echo "Generated SDKs from $spec"
