#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src_dir="${repo_root}/plugins/agora-api/skills"
dst_dir="${repo_root}/.bob/skills"

if [[ ! -d "$src_dir" ]]; then
  echo "ERROR: canonical skills directory not found: $src_dir" >&2
  exit 1
fi

rm -rf "$dst_dir"
mkdir -p "$dst_dir"
cp -R "${src_dir}/." "${dst_dir}/"

echo "Synced $(find "$dst_dir" -name 'SKILL.md' | wc -l | tr -d ' ') skills from plugins/agora-api/skills -> .bob/skills"
