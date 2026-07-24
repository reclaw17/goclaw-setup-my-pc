# fabric-offline

**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose
Run the **offline brain**: Fabric (or compatible OpenAI API server) + a **~9B Q4** class model that fits **8 GB VRAM / 16 GB RAM**.

## When to use
- No internet / cloud providers down
- User asks for local-only mode
- `model-router` selects local fallback

## USB layout (expected)
```text
fabric/
  fabric-linux          # or platform binary
models/
  qwen3.5-9b-q4_k_m.gguf   # example name; verify checksum when downloading
```

Binaries and GGUF are **not** in git — fetch scripts / Phase D downloaders place them.

## Workflow
1. Detect offline or explicit local request.
2. Tell the user clearly: local model mode (slower, less capable than Grok).
3. If Fabric not listening on `http://127.0.0.1:8080` — start it with safe GPU/CPU settings for 8 GB VRAM.
4. Ensure model file exists; if missing — explain how to download (do not start a broken server).
5. In GoClaw, provider should be OpenAI-compatible:
   - Base URL: `http://127.0.0.1:8080/v1`
   - Key: `sk-local` (or from `.env` `LOCAL_LLM_API_KEY`)
6. Prefer `prompts/wrappers/qwen-local.md` behavior: careful, smaller-scope tasks.
7. When network returns — offer switch back to Grok/cloud.

## Strict rules
- Do not load models that will OOM 8 GB VRAM.
- Prefer clear failure over silent hang.
- Always state current mode: **online** vs **offline**.
- Unload/stop Fabric when leaving local mode if the launcher supports it.

## Integration
- `model-router`, `local-docs`, `coding-quality`
- Launcher: `launcher/start-linux.sh` may auto-start Fabric if binary + model exist

## Quality bar
Transparency for a non-technical user > maximum tokens/second.
