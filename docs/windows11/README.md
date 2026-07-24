# Windows 11 — offline notes

## Safety
- Administrator for system changes.
- Prefer **winget** and official installers.
- No mass registry edits without confirmation.

## Packages
```powershell
winget search <name>
winget install <id>
```

## Network
```powershell
ipconfig /all
Get-NetAdapter
```

## GoClaw / agent on Windows (honest)

| Piece | Status |
|-------|--------|
| Linux AppImage GUI | **Production** path (CachyOS/Arch) |
| Windows GoClaw Lite GUI | **Not** shipped by our `goclaw-lite-cachyos` factory yet |
| Offline LLM on Windows | **Yes** — `fabric\win` + `models\*.gguf` |
| Cloud | **Yes** — API keys in `.env` (Grok etc.) |

Practical options on Win11:
1. Cloud API in GoClaw when a Windows build exists upstream, or any OpenAI-compatible client.  
2. Offline: start local server from `fabric\win`, point client to `http://127.0.0.1:8080/v1`.  
3. Advanced: WSL2 + Linux AppImage from `apps/`.

Prepare on Windows: `prepare.bat` (creates folders + `.env`).  
Fetch Fabric zip on a Linux machine for the stick: `bash scripts/fetch-fabric.sh windows` then copy `fabric/win` to the USB.

## VPN / DNS
Official AdGuard / Amnezia / WireGuard clients. See `docs/adguard/`, `docs/amnezia/`.
