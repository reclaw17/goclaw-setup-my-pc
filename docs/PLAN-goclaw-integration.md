# Plan: embed GoClaw Lite into main USB agent project

Saved: 2026-07-24  
Updated: Phase A + B done in this repo

## Repos

| Repo | Role |
|------|------|
| https://github.com/reclaw17/goclaw-lite-cachyos | AppImage factory (**v0.2.0-cachyos**) |
| https://github.com/reclaw17/goclaw-setup-my-pc | Main USB agent |

## Order

1. Wrap Lite — **DONE (Phase A)**  
2. Provider presets — **DONE (Phase B)**  
3. Skills / OpenWrt / docs / Fabric / Win11 — **Phase D next**  

## Phases

| Phase | Status |
|-------|--------|
| A USB tree + start/update + env | **Done** |
| B Grok / Qwen / Fabric presets + docs | **Done** |
| C no 120MB binary in git (fetch only) | **Done** (via A) |
| D skills, offline docs, Fabric model, Win11 | **Next** |

## First user path

```bash
bash prepare.sh && cp -n .env.example .env
# XAI_API_KEY=...
bash start.sh
```

See [PROVIDERS.md](PROVIDERS.md), [FIRST-RUN.md](../FIRST-RUN.md).
