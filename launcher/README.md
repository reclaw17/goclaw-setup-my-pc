# Launcher

## Files
- `start-linux.sh`
- `start-windows.bat`

## Responsibility

The launcher is the entry point of the portable agent.

### Must do
1. Detect OS
2. Ensure goclaw binary exists (fetch from pinned release if configured)
3. Ensure Fabric binary exists (fetch from pinned release if configured)
4. Ensure local model exists:
   - if missing → download `qwen3.5-9b-q4_k_m.gguf` into `models/`
   - verify checksum
5. Detect internet
6. Choose mode:
   - online → cloud model + matching wrapper
   - offline → start Fabric + local model + local wrapper
7. Start goclaw

## Status

Stubs exist. Full first-run + fetch logic is defined in `FIRST-RUN.md` and will be implemented as executable logic next.
