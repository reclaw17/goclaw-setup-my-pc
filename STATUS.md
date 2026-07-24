# STATUS

**Date:** 2026-07-24

## Done (Phase A)

- Primary engine: **GoClaw Lite AppImage** (`apps/GoClaw-Lite-x86_64.AppImage`)
- Source release: [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)
- `scripts/fetch-goclaw-appimage.sh` / `scripts/update-goclaw.sh`
- `launcher/start-linux.sh` prefers AppImage over old `goclaw/goclaw-linux`
- Beginner scripts: `подготовить.sh` → `старт.sh` → `обновить.sh`
- `.env.example` without required PostgreSQL

## Next

- Phase B: provider preset notes for Grok / Qwen / local Fabric in docs
- Phase D: skills hardening, offline docs pack, Fabric auto-download polish, Win11 path

## Packaging repo

https://github.com/reclaw17/goclaw-lite-cachyos — AppImage factory only (finalized for community use).
