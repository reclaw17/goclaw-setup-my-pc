# Plan: GoClaw Lite → USB agent (goclaw-setup-my-pc)

**Updated:** 2026-07-24 (synced with repo reality)

## Repos

| Repo | Role |
|------|------|
| [goclaw-lite-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos) | Linux AppImage factory (upstream Lite = macOS-only) |
| [goclaw-setup-my-pc](https://github.com/reclaw17/goclaw-setup-my-pc) | USB agent |
| [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) | Upstream engine + docs |

## Product rules

- Non-developer user; Grok leads  
- **`.env` on the USB stick** — model keys + **Perplexity**; never commit real `.env`  
- Cloud primary; Fabric only offline  
- Local model class: ~8 GB VRAM / 16 GB RAM  
- **USB ~32 GB:** full offline stack, full useful Human20 trees, full offline docs (incl. GoClaw)  
- **Git slim:** no AppImage / GGUF / `skills/vendor` / `docs/mirrors` / `.env`  

Refs: [USB-CAPACITY.md](USB-CAPACITY.md) · [SECRETS.md](SECRETS.md) · [OFFLINE-DOCS.md](OFFLINE-DOCS.md)

## Order

1. Shell around Lite  
2. Then skills / docs / Fabric on the stick  

---

## Phase status (actual)

| Phase | Status | Notes |
|-------|--------|--------|
| **A** USB shell | **Done** | prepare/start/update, AppImage fetch |
| **B** Providers | **Done** | Grok / OpenRouter / Fabric + PROVIDERS.md |
| **C** Slim git / fat USB | **Done** | 32 GB policy |
| **D** Procedures + fetch scripts | **Done** | skills pack, Fabric/model SHA256 |
| **D+** Secrets on USB | **Done** | `.env.example` + Perplexity; SECRETS.md |
| **D+** Offline docs + GoClaw mirror | **Done (tooling)** | `fetch-offline-docs.sh` → `docs/mirrors/goclaw/` |
| **E** Bootstrap + GoClaw skill loader + vendor-on-stick defaults | **Next** | `bootstrap/` files exist; not auto-wired into Lite yet |
| **F** Richer mirrors via chip-docs-local | **Partial** | fetch script + vendor clone; more sites optional |
| **G** Runtime wiring (paths, auto skills, router) | Planned | |
| **H** Windows track | Planned | honest matrix already documented |
| **I** Cleanup + device QA | Planned | |

### Still open (E focus)

1. Apply `bootstrap/` into Lite workspace automatically or document one-click copy  
2. YAML frontmatter + path so GoClaw can load `skills/`  
3. Default shortlist into `skills/vendor/` on prepare (32 GB)  
4. Optional: prompt prepare.sh for offline docs fetch  

---

## Recommended fill (32 GB stick)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git /media/USB/goclaw-setup-my-pc
cd /media/USB/goclaw-setup-my-pc
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-offline-docs.sh
bash scripts/fetch-human20-skill.sh chip-docs-local
bash scripts/fetch-human20-skill.sh backup-manager
bash scripts/fetch-human20-skill.sh auto-model-router
bash scripts/fetch-human20-skill.sh repo-task-proof-loop
cp -n .env.example .env
# edit .env on USB: XAI_API_KEY, PERPLEXITY_API_KEY, …
bash start.sh
```
