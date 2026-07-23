# Launcher

## Files
- `start-linux.sh` — real Linux launcher
- `start-windows.bat` — Windows launcher

## What start-linux.sh does

1. Checks `goclaw/goclaw-linux`
2. Ensures local model exists (downloads if missing, verifies SHA256)
3. Detects online/offline
4. Offline → starts Fabric (`fabric/fabric-linux`) with local model on `127.0.0.1:8080`
5. Loads `.env` if present
6. Starts GoClaw
7. Stops Fabric on exit

## User entrypoints

Prefer:

```bash
bash старт.sh
```

not the launcher file directly.
