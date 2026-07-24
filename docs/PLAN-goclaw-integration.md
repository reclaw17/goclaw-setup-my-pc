# Plan: GoClaw Lite → USB agent (goclaw-setup-my-pc)

Updated: **2026-07-24** — USB kit **32 GB** (no need to skimp on stick contents)

## Repos

| Repo | Role |
|------|------|
| [goclaw-lite-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos) | Linux AppImage factory (upstream Lite is macOS-only) |
| [goclaw-setup-my-pc](https://github.com/reclaw17/goclaw-setup-my-pc) | USB agent |
| [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) | Upstream |

## Product rules

- Non-developer user; Grok leads  
- Secrets only `.env` / UI — never git  
- Cloud primary; Fabric offline fallback  
- Local model class: ~8 GB VRAM / 16 GB RAM  
- **USB ~32 GB:** put **full** offline stack + **full** useful Human20 skill trees on the stick  
- **Git stays slim:** no AppImage/GGUF/vendor clones in the repo  

See [USB-CAPACITY.md](USB-CAPACITY.md).

## Order

1. Shell around Lite  
2. Then skills / docs / Fabric — **full content on USB OK**  

---

## Phases

| Phase | Status |
|-------|--------|
| A USB shell | **Done** |
| B Providers | **Done** |
| C Slim git / fat USB | **Done** (policy clarified for 32 GB) |
| D Procedures + fetch scripts | **Done** |
| E Bootstrap + loader + **vendor full skills on stick** | **Next** |
| F Doc mirrors (chip-docs-local) on stick | Planned |
| G Runtime wiring | Planned |
| H Windows honest track | Planned |
| I Cleanup + device QA | Planned |

### E (next) — expanded for 32 GB

1. Bootstrap files into Lite workspace  
2. Skill frontmatter / GoClaw loader path  
3. On-stick defaults: fetch shortlist into `skills/vendor/`  
   - chip-docs-local, backup-manager, auto-model-router, repo-task-proof-loop, …  
4. `FETCH_OFFLINE=1` recommended on first prepare  
5. Honest OS matrix in README  

---

## Recommended first fill (32 GB stick)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git /media/USB/goclaw-setup-my-pc
cd /media/USB/goclaw-setup-my-pc
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-human20-skill.sh chip-docs-local
bash scripts/fetch-human20-skill.sh backup-manager
bash scripts/fetch-human20-skill.sh auto-model-router
bash scripts/fetch-human20-skill.sh repo-task-proof-loop
cp -n .env.example .env   # XAI_API_KEY=...
bash start.sh
```
