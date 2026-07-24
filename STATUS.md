# STATUS

**Date:** 2026-07-24

## Phase A — USB shell — DONE

- AppImage in `apps/` via `prepare.sh` / `fetch-goclaw-appimage.sh`
- `start.sh` → `launcher/start-linux.sh`
- `update.sh` / AppImage `--update`
- `.env.example`, AppImage gitignored

## Phase B — Provider presets — DONE

- `config/providers.example.json` — Grok / OpenRouter / local Fabric
- [docs/PROVIDERS.md](docs/PROVIDERS.md) — wizard field mapping EN+RU
- [FIRST-RUN.md](FIRST-RUN.md) — first success path = cloud Grok

## How to run

```bash
bash prepare.sh
cp -n .env.example .env   # set XAI_API_KEY
bash start.sh
```

## Next (Phase D slice)

1. Skills hardening (OpenWrt, pc-setup, network-vpn)  
2. Offline docs pack hooks  
3. Fabric + model fetch (8GB VRAM path)  
4. Win11 launcher path  

## Packaging factory

https://github.com/reclaw17/goclaw-lite-cachyos — **v0.2.0-cachyos**
