# STATUS

**Date:** 2026-07-24 (post Human20 + upstream audit)

## Phases A–D — shell done

USB AppImage path, providers, skills procedure pack, Fabric/model fetch, docs stubs.

## Audit corrections applied

See **[docs/AUDIT-2026-07-24.md](docs/AUDIT-2026-07-24.md)**:

- Official Lite install = **macOS**; Linux AppImage remains our gap-fill  
- Skills = procedure pack ≠ full Human20/GoClaw-native skill bundles yet  
- Added `bootstrap/` (AGENTS/SOUL/TOOLS) for Lite workspace  
- Human20 catalog mapping: `docs/HUMAN20-SKILLS.md`  
- Windows claims toned down to match upstream release reality  

## Priority next fixes

1. Wire `skills/` + `bootstrap/` into GoClaw Lite workspace path (native loader)  
2. `scripts/fetch-human20-skill.sh` for chip-docs-local / clawguard zips  
3. Optional deeper offline mirrors via chip-docs-local  
4. Watch upstream for Windows `lite-v*` assets  

## Run (Linux)

```bash
bash prepare.sh
# .env → XAI_API_KEY=
bash start.sh
```
