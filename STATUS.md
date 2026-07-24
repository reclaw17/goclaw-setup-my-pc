# STATUS

**Date:** 2026-07-24

## Phases

| Phase | Status |
|-------|--------|
| A USB shell + AppImage | **Done** |
| B Provider presets | **Done** |
| C No 120MB binary in git | **Done** |
| D Skills + docs + offline fetch + Win honesty | **Done (this pass)** |

## Phase D deliverables

- Real offline notes: `docs/openwrt`, `cachyos-arch`, `windows11`, `adguard`, `amnezia`
- `scripts/fetch-model.sh` — SHA256 pinned
- `scripts/fetch-fabric.sh` — Fabric/llama Vulkan b7349 + SHA
- `scripts/fetch-offline-stack.sh` — both
- Windows: `prepare.bat` / `launcher/start-windows.bat` + `scripts/fetch-goclaw-windows.md` (GUI = Linux AppImage; Win = Fabric/model + honest limits)

## Run (Linux — primary)

```bash
bash prepare.sh
cp -n .env.example .env   # XAI_API_KEY=
bash start.sh
# optional offline stack:
bash scripts/fetch-offline-stack.sh
```

## Run (Windows 11)

```bat
prepare.bat
REM Full GoClaw GUI still Linux-first — see scripts\fetch-goclaw-windows.md
```
