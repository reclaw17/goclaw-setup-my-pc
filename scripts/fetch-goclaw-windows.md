# GoClaw on Windows 11

## Honest status

| Platform | Runtime |
|----------|---------|
| **Linux (CachyOS/Arch)** | **Supported** — `apps/GoClaw-Lite-x86_64.AppImage` from [goclaw-lite-cachyos v0.2.0](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos) |
| **Windows 11** | **No official Lite AppImage.** Upstream publishes **Linux** server tarballs primarily. Desktop Windows builds are not shipped the same way as our Linux AppImage. |

## Recommended setups

### A) Best for this project (full agent GUI)
Use a **Linux USB / CachyOS partition** and run:

```bash
bash prepare.sh
bash start.sh
```

### B) Windows 11 online-only (browser / upstream)
1. Keep API keys in `.env` on the stick for reference.
2. Use cloud Grok via official clients or upstream GoClaw when a Windows desktop build appears.
3. Still run **Fabric offline** on Windows for local LLM experiments (see `prepare.bat`).

### C) Windows + local model only
```bat
prepare.bat
REM downloads Fabric Win Vulkan + model when implemented
```
Point any OpenAI-compatible client to `http://127.0.0.1:8080/v1`.

## Do not expect
- `GoClaw-Lite-x86_64.AppImage` to run natively on Windows (use WSL2/Linux host).
- Automatic parity of GUI features until upstream ships Windows Lite binaries we can pin.
