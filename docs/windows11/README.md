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

## GoClaw on Windows (aligned with upstream)

Official Lite installer (`install-lite.ps1` / zip) is documented by upstream for Windows **when release assets exist**.  
As of audit 2026-07-24, recent GitHub releases did **not** list `lite-v*` desktop assets — treat Windows GUI as **best-effort / watch upstream**.

| Piece | Status |
|-------|--------|
| **Linux AppImage (this project)** | Production path for CachyOS/Arch |
| **Official Lite macOS** | Upstream `install-lite.sh` |
| **Official Lite Windows** | Upstream zip when published |
| **Offline LLM on Windows** | `fabric\win` + `models\*.gguf` |
| **Cloud** | API keys in `.env` |

Practical options today:
1. Cloud APIs from any OpenAI-compatible client.  
2. Local server under `fabric\win` → `http://127.0.0.1:8080/v1`.  
3. WSL2 + Linux AppImage from `apps/`.

See `docs/GOCLAW-OFFICIAL.md`, `docs/EMBED.md`.
