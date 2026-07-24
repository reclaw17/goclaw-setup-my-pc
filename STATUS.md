# STATUS

**Date:** 2026-07-24

| Phase | Status |
|-------|--------|
| A USB shell (AppImage prepare/start/update) | **Done** |
| B Provider presets (Grok / OpenRouter / Fabric docs) | **Done** |
| C No AppImage in git (fetch only) | **Done** |
| D Skills hardening (INDEX + core SKILL.md) | **Done (slice)** |
| D+ Fabric auto model + full offline docs pack | **Next** |
| D+ Win11 portable engine parity | **Later** |

## Run

```bash
bash prepare.sh
cp -n .env.example .env   # XAI_API_KEY
bash start.sh
```

Providers: [docs/PROVIDERS.md](docs/PROVIDERS.md)  
Skills: [skills/INDEX.md](skills/INDEX.md)  
Plan: [docs/PLAN-goclaw-integration.md](docs/PLAN-goclaw-integration.md)

## Packaging

https://github.com/reclaw17/goclaw-lite-cachyos — v0.2.0-cachyos
