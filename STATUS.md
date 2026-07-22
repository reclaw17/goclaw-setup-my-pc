# Project Status

**Date:** 2026-07-22  
**Principle:** Quality over speed. Model = brain.

## Completed at high quality

- Architecture (model = brain + individual wrappers)
- System prompts + 4 model wrappers
- Core skills: local-docs, safety-confirm, openwrt, fabric-offline, pc-setup, model-router
- PROJECT-PLAN, QUALITY-CHECKLIST, MODELS, USB-STRUCTURE
- First-run strategy:
  - binaries via fork / pinned releases
  - model auto-download on first launch (QVAC-style)

## Current decision (locked)

1. **Binaries** → fork / pinned GitHub Releases  
2. **Model** → automatic download on first run if missing  

See:
- `FIRST-RUN.md`
- `SOURCES.md`
- `USB-STRUCTURE.md`

## Next implementation steps

1. Pin exact release URLs + model checksum in `SOURCES.md`
2. Implement full launcher logic (Linux + Windows)
3. USB preparation script
4. Populate docs/
5. Hardware test on 8 GB VRAM
6. Public release cleanup
