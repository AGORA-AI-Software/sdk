#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="${1:?Usage: lint-plugin.sh <plugin-dir>}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

python3 - "$PLUGIN_DIR" "$REPO_ROOT" <<'PY'
import json
import os
import re
import sys
from pathlib import Path

plugin_dir = Path(sys.argv[1]).resolve()
repo_root = Path(sys.argv[2]).resolve()
errors: list[str] = []

# 1. Validate plugin.json manifests
manifests = sorted(plugin_dir.rglob("plugin.json"))
if not manifests:
    errors.append(f"No plugin.json files found under {plugin_dir}")

for manifest in manifests:
    try:
        data = json.loads(manifest.read_text(encoding="utf-8"))
    except Exception as exc:
        errors.append(f"Invalid JSON in {manifest}: {exc}")
        continue
    for field in ("name", "version", "description", "skills"):
        if field not in data or not isinstance(data[field], str) or not data[field].strip():
            errors.append(f"Missing or empty required field '{field}' in {manifest}")
    skills_rel = data.get("skills")
    if isinstance(skills_rel, str):
        resolved = (plugin_dir / skills_rel).resolve()
        if not resolved.is_dir():
            errors.append(f"skills path '{skills_rel}' in {manifest} does not exist at {resolved}")

    # Manifest-specific schema checks
    if manifest.parent.name == ".claude-plugin":
        if "interface" in data:
            errors.append(
                f"{manifest.relative_to(repo_root)}: contains Codex-only top-level 'interface' block "
                "(remove to stay compatible with strict Claude Code manifest schemas)"
            )
    elif manifest.parent.name == ".codex-plugin":
        iface = data.get("interface")
        if isinstance(iface, dict) and "defaultPrompt" in iface:
            dp = iface["defaultPrompt"]
            prompts = [dp] if isinstance(dp, str) else dp if isinstance(dp, list) else None
            if prompts is None or not all(isinstance(p, str) for p in prompts):
                errors.append(f"{manifest.relative_to(repo_root)}: interface.defaultPrompt must be string or string[]")
            else:
                if len(prompts) > 3:
                    errors.append(
                        f"{manifest.relative_to(repo_root)}: interface.defaultPrompt has {len(prompts)} items "
                        "(Codex supports at most 3)"
                    )
                for idx, prompt in enumerate(prompts):
                    if len(prompt) > 128:
                        errors.append(
                            f"{manifest.relative_to(repo_root)}: interface.defaultPrompt[{idx}] exceeds 128 chars ({len(prompt)})"
                        )

    print(f"OK manifest: {manifest.relative_to(repo_root)}")

# 2. Validate every SKILL.md under plugins/agora-api/skills
skills_root = plugin_dir / "skills"
if not skills_root.is_dir():
    errors.append(f"Missing skills directory: {skills_root}")
    skill_dirs: list[Path] = []
else:
    skill_dirs = sorted(p for p in skills_root.iterdir() if p.is_dir())
    if not skill_dirs:
        errors.append(f"No skill directories found under {skills_root}")

forbidden_markers = [
    "GIT_USER_ID",
    "GIT_REPO_ID",
    "NoLicense",
    "auth/settings/api-keys",
    "/admin",
    "/dashboard",
    "/rum",
    "/firebase",
    "X-Internal-API-Key",
]
name_re = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
link_re = re.compile(r"\[[^\]]+\]\(([^)#]+)\)")
broken_patterns = [
    (
        re.compile(r"agora_public_api\.model\."),
        "uses broken singular import 'agora_public_api.model.' (use 'agora_public_api.models.')",
    ),
    (
        re.compile(r"Phone:\s*&"),
        "passes pointer to Go LeadInput.Phone (must be string value, not *string)",
    ),
    (
        re.compile(r"\bDouble\s+\w+\s*=\s*[^;\n]*getSuccessRate\("),
        "assigns Float getSuccessRate() to Java Double (use Float)",
    ),
    (
        re.compile(r'"pricing_model"\s*:\s*"performance"'),
        "uses invalid CampaignPricingModel 'performance' (valid: commission, subscription, pay_per_call, pay_per_outcome)",
    ),
    (
        re.compile(r'"outcome_type"\s*:\s*"positive"'),
        "uses invalid OutcomeType 'positive' (valid: NONE, FORM, CALLBACK)",
    ),
    (
        re.compile(r"restish\b[^\n]*-f\s+body\.[^\n]*\s-r(?:\s|$|\))"),
        "uses non-existent Restish '-r' flag (use '--rsh-print b -o lines')",
    ),
]


def parse_frontmatter(raw: str) -> dict[str, str]:
    try:
        import yaml  # type: ignore[import-not-found]

        loaded = yaml.safe_load(raw)
        if isinstance(loaded, dict):
            return {str(k): ("" if v is None else str(v).strip()) for k, v in loaded.items()}
    except ImportError:
        pass

    fm: dict[str, str] = {}
    current_key: str | None = None
    multiline_lines: list[str] = []
    multiline_mode: str | None = None

    def flush_multiline() -> None:
        nonlocal current_key, multiline_lines, multiline_mode
        if current_key is not None and multiline_mode is not None:
            joiner = " " if multiline_mode.startswith(">") else "\n"
            fm[current_key] = joiner.join(line.strip() for line in multiline_lines).strip()
        current_key = None
        multiline_lines = []
        multiline_mode = None

    for raw_line in raw.splitlines():
        if multiline_mode is not None:
            if raw_line.startswith((" ", "\t")) or not raw_line.strip():
                multiline_lines.append(raw_line)
                continue
            flush_multiline()

        stripped = raw_line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        if ":" in raw_line:
            k, v = raw_line.split(":", 1)
            key = k.strip()
            val = v.strip()
            if val in (">", ">-", "|", "|-"):
                current_key = key
                multiline_mode = val
                multiline_lines = []
            else:
                fm[key] = val.strip('"').strip("'")

    flush_multiline()
    return fm


for sdir in skill_dirs:
    skill_md = sdir / "SKILL.md"
    if not skill_md.is_file():
        errors.append(f"Missing SKILL.md in {sdir.relative_to(repo_root)}")
        continue

    text = skill_md.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        errors.append(f"{skill_md.relative_to(repo_root)}: missing YAML frontmatter")
        continue
    parts = text.split("---\n", 2)
    if len(parts) < 3:
        errors.append(f"{skill_md.relative_to(repo_root)}: unterminated YAML frontmatter")
        continue

    fm = parse_frontmatter(parts[1])

    name = fm.get("name", "")
    desc = fm.get("description", "")

    if not name:
        errors.append(f"{skill_md.relative_to(repo_root)}: missing frontmatter 'name'")
    elif not name_re.match(name) or len(name) > 64:
        errors.append(f"{skill_md.relative_to(repo_root)}: invalid skill name '{name}' (must be kebab-case <=64 chars)")
    elif name != sdir.name:
        errors.append(f"{skill_md.relative_to(repo_root)}: frontmatter name '{name}' != directory name '{sdir.name}'")

    if not desc:
        errors.append(f"{skill_md.relative_to(repo_root)}: missing frontmatter 'description'")
    elif len(desc) > 1024:
        errors.append(f"{skill_md.relative_to(repo_root)}: description exceeds 1024 chars ({len(desc)})")
    elif "use when" not in desc.lower():
        errors.append(f"{skill_md.relative_to(repo_root)}: description should include explicit trigger guidance ('Use when...')")

    # Check all files inside the skill directory
    for fpath in sorted(sdir.rglob("*")):
        if not fpath.is_file():
            continue
        content = fpath.read_text(encoding="utf-8")
        rel = fpath.relative_to(repo_root)
        for marker in forbidden_markers:
            if marker in content:
                errors.append(f"{rel}: contains forbidden internal marker '{marker}'")
        for pat, reason in broken_patterns:
            if pat.search(content):
                errors.append(f"{rel}: {reason}")
        if fpath.name == "SKILL.md":
            # Any skill demonstrating lead upload payloads must include disclaimer_version
            if ("/leads/upload" in content or "uploadLeads" in content or "upload-leads" in content):
                if "disclaimer_version" not in content and "disclaimerVersion" not in content:
                    errors.append(f"{rel}: demonstrates lead upload without required disclaimer_version")
        if fpath.suffix == ".md":
            # Verify relative markdown links resolve in both SKILL.md and reference docs
            for target in link_re.findall(content):
                if target.startswith(("http://", "https://", "mailto:", "#")):
                    continue
                target_path = (fpath.parent / target).resolve()
                if not target_path.exists():
                    errors.append(f"{rel}: broken relative link '{target}'")

    print(f"OK skill:    {sdir.relative_to(repo_root)} (name={name})")

# 3. Validate plugin README lists all skills
readme_path = plugin_dir / "README.md"
if readme_path.is_file():
    readme_text = readme_path.read_text(encoding="utf-8")
    for sdir in skill_dirs:
        if sdir.name not in readme_text:
            errors.append(f"{readme_path.relative_to(repo_root)}: missing skill '{sdir.name}'")
    print(f"OK readme:   {readme_path.relative_to(repo_root)}")

# 4. Validate .bob/skills/ mirrors plugins/agora-api/skills/ byte-for-byte
bob_skills = repo_root / ".bob" / "skills"
if not bob_skills.is_dir():
    errors.append("Missing .bob/skills directory (run: make sync-bob-skills)")
else:
    src_files = {p.relative_to(skills_root): p for p in sorted(skills_root.rglob("*")) if p.is_file()}
    dst_files = {p.relative_to(bob_skills): p for p in sorted(bob_skills.rglob("*")) if p.is_file()}
    if set(src_files.keys()) != set(dst_files.keys()):
        only_src = sorted(str(p) for p in set(src_files) - set(dst_files))
        only_dst = sorted(str(p) for p in set(dst_files) - set(src_files))
        errors.append(f".bob/skills out of sync with plugins/agora-api/skills (only_src={only_src}, only_dst={only_dst}). Run: make sync-bob-skills")
    else:
        for rel, sp in src_files.items():
            if sp.read_bytes() != dst_files[rel].read_bytes():
                errors.append(f".bob/skills/{rel} differs from plugins/agora-api/skills/{rel}. Run: make sync-bob-skills")
        if not any(".bob/skills" in e for e in errors):
            print(f"OK bob sync: .bob/skills matches plugins/agora-api/skills ({len(src_files)} files)")

if errors:
    print("\nPLUGIN LINT FAILED:", file=sys.stderr)
    for err in errors:
        print(f"  - {err}", file=sys.stderr)
    sys.exit(1)

print("\nAll plugin and skill checks passed.")
PY
