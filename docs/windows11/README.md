# Windows 11 — offline notes

## Safety
- Elevated actions need Administrator.
- Prefer **winget** / official installers.
- No registry mass-edits without explicit confirmation.

## Package install (when winget exists)
```powershell
winget search <name>
winget install <id>
```

## Network diagnostics
```powershell
ipconfig /all
Get-NetAdapter
```

## GoClaw status on Windows
See **[scripts/fetch-goclaw-windows.md](../../scripts/fetch-goclaw-windows.md)**:

- Full GUI agent is **production on Linux AppImage**.
- Windows: use cloud clients + optional local Fabric; track upstream for Windows desktop builds.

## Local LLM on Windows
1. Run `prepare.bat` (Fabric + model when configured).
2. Start `llama-server` (or Fabric binary) on `127.0.0.1:8080`.
3. Point OpenAI-compatible UI to `http://127.0.0.1:8080/v1`.

## VPN / DNS
Prefer official AdGuard / Amnezia / WireGuard clients. See `docs/adguard/`, `docs/amnezia/`.
