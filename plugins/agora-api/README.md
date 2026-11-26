# AGORA Public API Agent Plugin & Skills

Reviewed, contract-verified AI-agent skills covering all **38 live endpoints** of the AGORA Public API across **6 domains** (Authentication, Compliance, Campaigns, Leads, Calls, Webhooks).

## Skills Included

| Skill | Focus |
|---|---|
| [`agora-public-api`](skills/agora-public-api/SKILL.md) | Master router, 38-endpoint capability matrix ([`references/endpoints.md`](skills/agora-public-api/references/endpoints.md)), web-app-only boundaries, 2-step auth flow, and error recovery table. |
| [`agora-lead-upload-api`](skills/agora-lead-upload-api/SKILL.md) | Compliance disclaimer fetch (`disclaimer_version`), JSON lead upload (`duplicate_strategy`, `custom_fields`), async upload status polling, and lead CRUD/profile/status management. |
| [`agora-campaigns-and-calls-api`](skills/agora-campaigns-and-calls-api/SKILL.md) | Campaign discovery (`accessible`), blueprint provisioning/export/cloning ([`references/campaign-blueprints.md`](skills/agora-campaigns-and-calls-api/references/campaign-blueprints.md)), readiness audits, statuses/scripts/buttons/automations, and paginated call outcome sync. |
| [`agora-webhook-api`](skills/agora-webhook-api/SKILL.md) | Read-only webhook observability: 8 event types, configured endpoints, and delivery health monitoring (curl, Restish, Python/TypeScript/Java/Go SDKs). |
| [`agora-restish-cli`](skills/agora-restish-cli/SKILL.md) | Terminal CLI workflows via Restish connected to live `/openapi.json` (all 38 operations) or the repo-local `restish/agora.restish.json` auto-token config. |
| [`agora-sdk-usage`](skills/agora-sdk-usage/SKILL.md) | Compile-verified Python, TypeScript, Java, and Go SDK snippets with dynamic `disclaimer_version` fetch and explicit coverage boundaries. |

## Supported AI Coding Assistants

- **Claude Code:** `.claude-plugin/plugin.json` → `./skills/`
- **OpenAI Codex:** `.codex-plugin/plugin.json` → `./skills/`
- **IBM Bob:** Root `.bob/skills/` is mirrored directly from `plugins/agora-api/skills/` via `make sync-bob-skills` and verified for byte-for-byte parity in `make lint-plugin`.

## Maintenance & Verification

```bash
# Mirror canonical skills into .bob/skills/ for IBM Bob
make sync-bob-skills

# Validate plugin manifests, SKILL.md frontmatter/names/links, code hygiene, and .bob/skills/ parity
make lint-plugin

# Run live Public API contract verification against core-dev.agoraai.tech (read-only; set AGORA_API_KEY for authenticated checks)
./scripts/test-live-api-skills.sh
```
