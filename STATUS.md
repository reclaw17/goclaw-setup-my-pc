# STATUS

**Date:** 2026-07-24

## Phase A — USB shell — DONE
AppImage fetch/start/update, `.env.example`, gitignore.

## Phase B — Providers — DONE
Grok / OpenRouter / Fabric presets + [docs/PROVIDERS.md](docs/PROVIDERS.md).

## Phase D — Skills pass — DONE (docs/skills layer)

| Skill | Notes |
|-------|--------|
| openwrt | Backup-first router workflow |
| pc-setup | Arch/CachyOS + Win11 |
| amnezia-adguard | New |
| fabric-offline | 8GB VRAM offline path |
| INDEX/README | Updated |

## Still open (Phase D implementation)
- Real offline doc bodies under `docs/**`
- Fabric + GGUF download with checksum
- Win11 test pass

## Run

```bash
bash prepare.sh
cp -n .env.example .env   # XAI_API_KEY=...
bash start.sh
```

Packaging: https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos
