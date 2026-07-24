# STATUS

**Date:** 2026-07-24

## Plan phases A–D — complete

| Phase | Status |
|-------|--------|
| A USB shell + AppImage | Done |
| B Provider presets | Done |
| C Fetch AppImage (not in git) | Done |
| D Skills + docs + Fabric/model fetch + Win notes | Done |

## Human20 archive audit

- Read `human20mcp-20260722.zip` (235 catalog cards).  
- Mapped shortlist → [skills/SOURCES-HUMAN20.md](skills/SOURCES-HUMAN20.md).  
- Added `web-search`; tightened `coding-quality` / `local-docs`.  
- Archive does **not** replace our SKILL.md files (cards ≠ full skill bodies).

## Secrets

Use **repo-root** `.env` (from `.env.example`).  
Do not commit keys. (`config/` holds provider *examples* only.)

## Run

```bash
bash prepare.sh          # AppImage; optional offline stack
# .env → XAI_API_KEY=
bash start.sh
```

## Open (hardware / upstream)

- Win11 official GoClaw Lite GUI binary when available  
- Optional large doc mirrors via chip-docs-local  
