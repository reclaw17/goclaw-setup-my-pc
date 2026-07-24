# Plan: GoClaw Lite → USB agent (goclaw-setup-my-pc)

**Updated:** 2026-07-24 — **Phase D fully closed**

## Repos

| Repo | Role |
|------|------|
| [goclaw-lite-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos) | Linux AppImage factory (upstream Lite = macOS-only) |
| [goclaw-setup-my-pc](https://github.com/reclaw17/goclaw-setup-my-pc) | USB agent |
| [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) | Upstream engine + docs |

## Product rules

- Non-developer user; Grok leads  
- **`.env` on USB** — model + **Perplexity** keys; never git  
- Cloud primary; Fabric offline only  
- Local model ~8 GB VRAM / 16 GB RAM  
- **USB ~32 GB:** full offline stack, full useful skills, full offline docs (incl. GoClaw)  
- **Git slim:** no AppImage / GGUF / vendor / mirrors / `.env`  

## Phase status

| Phase | Status |
|-------|--------|
| **A** USB shell | **Done** |
| **B** Providers | **Done** |
| **C** Slim git / fat USB | **Done** |
| **D** Content + all fetch tooling | **Done** — see [PHASE-D.md](PHASE-D.md) |
| **E** Bootstrap + native skill loader + auto-wire | **Next** |
| **F** Richer chip-docs-local site mirrors | Optional expand |
| **G** Runtime wiring | Planned |
| **H** Windows GUI when upstream ships | Planned |
| **I** Cleanup + device QA | Planned |

## Fill stick (Phase D)

```bash
FETCH_OFFLINE=1 FETCH_DOCS=1 FETCH_SKILLS=1 bash prepare.sh
# edit .env on USB
bash start.sh
```
