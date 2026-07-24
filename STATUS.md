# STATUS

**Date:** 2026-07-24 · Plan synced with repo

## Done

- Phases **A–D** (USB shell, providers, slim git, procedures, Fabric/model fetch)  
- **`.env` on USB** — models + **Perplexity** ([SECRETS.md](docs/SECRETS.md))  
- **Offline docs** incl. GoClaw: `bash scripts/fetch-offline-docs.sh`  
- 32 GB policy: full skills/model/docs on stick OK  
- Linux AppImage = gap-fill for upstream Lite  
- Skills = procedure pack in git; full Human20 via `fetch-human20-skill.sh`  

## Next — Phase E

1. Wire `bootstrap/` into GoClaw Lite workspace  
2. Skill loader path / frontmatter  
3. Default vendor shortlist on prepare  

## Run

```bash
git pull
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-offline-docs.sh
cp -n .env.example .env   # keys on USB only
bash start.sh
```
