# Sources — Binaries & Model

## Strategy

### 1. Binaries via fork / pinned releases
- goclaw: use official project or our fork + pinned release assets
- Fabric: use QVAC/Fabric release assets or a pinned fork

Do **not** commit large binaries into git by default.
Fetch them during USB preparation or on first run.

### 2. Model via auto-download (first run)
- Model: **Qwen3.5-9B Q4_K_M**
- Target path: `models/qwen3.5-9b-q4_k_m.gguf`
- Behaviour: if missing at first launch → download + checksum verify → reuse forever after

## Required pins (to be filled with exact URLs)

```text
GOCLAW_RELEASE_URL_LINUX=
GOCLAW_RELEASE_URL_WINDOWS=

FABRIC_RELEASE_URL_LINUX=
FABRIC_RELEASE_URL_WINDOWS=

MODEL_URL=
MODEL_SHA256=
MODEL_FILENAME=qwen3.5-9b-q4_k_m.gguf
```

Until exact release URLs are pinned, launcher must fail safely with a clear message instead of downloading from an untrusted source.
