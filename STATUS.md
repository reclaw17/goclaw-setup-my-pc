# STATUS

**Date:** 2026-07-24

## Phase A — USB shell — DONE
AppImage fetch/start/update, `.env`, gitignore.

## Phase B — Providers — DONE
Grok / OpenRouter / Fabric presets + `docs/PROVIDERS.md`.

## Phase D — DONE (implementation layer)

| Item | Status |
|------|--------|
| Skills (openwrt, pc-setup, amnezia, fabric-offline, …) | Done |
| Real notes under `docs/**` | Done |
| `scripts/fetch-fabric.sh` + SHA256 | Done |
| `scripts/fetch-model.sh` + SHA256 | Done |
| `scripts/fetch-offline-stack.sh` | Done |
| Embed layout documented | `docs/EMBED.md` |
| `prepare.sh` optional offline fetch | Done |
| Win11 honesty + folders | `docs/windows11`, `prepare.bat` |

### Still hardware-dependent
- Full Win11 GUI GoClaw Lite binary (upstream/factory gap) — use cloud client, `fabric\win`, or WSL+AppImage
- Real-device QA on each user's PC/router

## Run (Linux)

```bash
bash prepare.sh                    # AppImage; ask for Fabric+model
# or forced offline stack:
FETCH_OFFLINE=1 bash prepare.sh
bash start.sh
```

## Packaging factory
https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos
