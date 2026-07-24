# Official GoClaw (upstream) — notes for this project

Upstream: https://github.com/nextlevelbuilder/goclaw  
Docs: https://docs.goclaw.sh

## Editions

| Edition | DB | Target |
|---------|-----|--------|
| **Standard** | PostgreSQL | Server / multi-tenant |
| **Lite (Desktop)** | SQLite | Local desktop agents |

## Official install-lite

```bash
# macOS only (upstream script)
curl -fsSL https://raw.githubusercontent.com/nextlevelbuilder/goclaw/main/scripts/install-lite.sh | bash
```

From upstream `install-lite.sh`:

- **macOS** — supported  
- **Windows** — download `.zip` from GitHub Releases when published  
- **Linux** — *"not yet supported"* upstream  

**This monorepo’s Linux path:** community AppImage from  
https://github.com/reclaw17/goclaw-lite-cachyos (e.g. `v0.2.0-cachyos`).

## Skills (upstream model)

See `docs/14-skills-runtime.md` / `docs/15-core-skills-system.md` in upstream:

- Each skill directory contains `SKILL.md` with **YAML frontmatter**
- Loader scans workspace / global / bundled dirs
- Runtime tools: search / use / manage skills

Our `skills/` tree is a **procedure pack** aligned to product goals; wiring into Lite’s loader is a follow-up (`docs/AUDIT-2026-07-24.md`).

## Bootstrap files (upstream)

Agents load: `AGENTS.md`, `SOUL.md`, `TOOLS.md`, `IDENTITY.md`, `USER.md`, `BOOTSTRAP.md` (see upstream docs/07).  
Copies for this product live under `bootstrap/` in this repo — copy into the agent workspace when configuring Lite.
