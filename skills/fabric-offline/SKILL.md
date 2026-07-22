# fabric-offline

**Status:** Production-ready  
**Last update:** 2026-07-22

## Purpose
Manage the portable offline inference stack (Fabric + Qwen3.5-9B) when cloud models are unavailable.

## When to use
- No internet connection
- Cloud providers are unreachable
- User explicitly requests local mode

## Required USB layout
```
fabric/
├── fabric-linux
├── fabric-windows.exe
models/
└── qwen3.5-9b-q4_k_m.gguf
```

## Workflow
1. Detect absence of usable internet / cloud.
2. Notify the user clearly:  
   «Интернета нет. Переключаюсь на локальную модель Qwen3.5-9B.»
3. Start Fabric as OpenAI-compatible server if it is not running.
4. Load the model with settings safe for 8 GB VRAM.
5. Switch active wrapper to `prompts/wrappers/qwen-local.md`.
6. Continue working using only local skills and `docs/`.
7. When internet returns — inform the user and offer to switch back to cloud.

## Strict rules
- Never attempt to load a model that will not fit into 8 GB VRAM.
- Prefer graceful degradation over crash.
- Always tell the user the current mode (online / offline).
- Unload the model when it is no longer needed.

## Integration
- Controlled by `model-router`
- Uses `wrapper-qwen-local.md`
- Works together with `local-docs`

## Quality principle
Reliability and transparency for a non-technical user are more important than maximum speed.
