# Plan: embed GoClaw Lite into main USB agent

**Phases A–D: complete** (2026-07-24)

| Phase | Status |
|-------|--------|
| A USB + start/update + env | Done |
| B Provider presets | Done |
| C AppImage via Releases (not in git) | Done |
| D Skills + docs + Fabric/model fetch + Win notes | Done |

## Embed rule
Programs live **inside project folders** (`apps/`, `fabric/`, `models/`) on the USB,  
downloaded by scripts with checksums — **not** committed to git.

See [EMBED.md](EMBED.md).

## Run
```bash
bash prepare.sh
bash start.sh
```
