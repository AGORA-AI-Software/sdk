#!/usr/bin/env bash
set -euo pipefail

version="${1:-2.1.0}"
binary_path="${2:-tools/restish/restish}"

os="$(uname -s | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m)"

case "$os" in
  linux) os="linux" ;;
  darwin) os="darwin" ;;
  *) echo "Unsupported OS for Restish install: $os" >&2; exit 1 ;;
esac

case "$arch" in
  x86_64|amd64) arch="amd64" ;;
  aarch64|arm64) arch="arm64" ;;
  *) echo "Unsupported architecture for Restish install: $arch" >&2; exit 1 ;;
esac

archive="restish-${version}-${os}-${arch}.tar.gz"
url="https://github.com/rest-sh/restish/releases/download/v${version}/${archive}"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

if [[ -x "$binary_path" ]] && "$binary_path" --version | grep -Fq "restish version ${version}"; then
  "$binary_path" --version
  exit 0
fi

curl -fsSL "$url" -o "$tmp_dir/$archive"
mkdir -p "$(dirname "$binary_path")"
tar -xzf "$tmp_dir/$archive" -C "$(dirname "$binary_path")" restish LICENSE.md README.md
chmod +x "$binary_path"

"$binary_path" --version
