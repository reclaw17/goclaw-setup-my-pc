# How programs are embedded in this project

Binaries are **part of the USB/project layout**, but **not stored in git** (too large).

## Layout after prepare

```text
project-or-USB/
  apps/
    GoClaw-Lite-x86_64.AppImage     ← Linux GUI agent (from goclaw-lite-cachyos)
  fabric/
    fabric-linux                    ← local OpenAI-compatible server (Linux)
    win/…                           ← Windows llama/Fabric build (optional)
  models/
    qwen3.5-9b-q4_k_m.gguf          ← offline model (~Q4 9B)
  goclaw/                           ← optional legacy/upstream CLI bits
  .env                              ← secrets (local only)
```

## Fetch commands

| Component | Command |
|-----------|---------|
| GoClaw Lite AppImage (Linux) | `bash scripts/fetch-goclaw-appimage.sh` or `bash prepare.sh` |
| Fabric Linux | `bash scripts/fetch-fabric.sh linux` |
| Fabric Windows zip | `bash scripts/fetch-fabric.sh windows` |
| GGUF model + SHA256 | `bash scripts/fetch-model.sh` |
| Fabric + model | `bash scripts/fetch-offline-stack.sh linux` |

Optional full helper: `FETCH_BINARIES=1 PREFETCH_MODEL=1 bash scripts/prepare-usb.sh .`

## Platform honesty

| OS | GoClaw GUI | Offline LLM |
|----|------------|-------------|
| **Linux (Arch/CachyOS)** | **Yes** — AppImage in `apps/` | Fabric + model |
| **Windows 11** | No official Lite AppImage in our factory yet | Fabric/llama under `fabric/win` + cloud API keys in `.env` |

Windows users: run `prepare.bat` / place binaries under `fabric\win`, use cloud Grok in any OpenAI-compatible client, or WSL2 + Linux AppImage.

## Git rules

Ignored: `apps/*.AppImage`, `models/*.gguf`, fabric binaries, `.env`.
