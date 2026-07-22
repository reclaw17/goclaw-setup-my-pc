# Sources — Binaries & Model

**Status:** Production policy defined  
**Last update:** 2026-07-22

## Strategy

### 1. Binaries via pinned releases / fork
- **goclaw** → official releases from `nextlevelbuilder/goclaw` (or our controlled fork)
- **Fabric** → pinned release from QVAC / fabric-llm.cpp (or controlled fork)

Large binaries are **never** committed to git.  
They are fetched during USB preparation or on first run.

### 2. Model via auto-download (first run)
- Model name: **Qwen3.5-9B** (or closest high-quality equivalent available at the time of pinning)
- Quantization: **Q4_K_M** (preferred) or Q5_K_M if stable on 8 GB VRAM
- Target path on USB: `models/qwen3.5-9b-q4_k_m.gguf`
- Behaviour:
  1. Check if file exists
  2. If missing → download from pinned URL
  3. Verify SHA256
  4. Keep permanently on the USB for future launches

## Required pins (must be filled before public release)

```text
# Binaries
GOCLAW_RELEASE_URL_LINUX=
GOCLAW_RELEASE_URL_WINDOWS=
GOCLAW_SHA256_LINUX=
GOCLAW_SHA256_WINDOWS=

FABRIC_RELEASE_URL_LINUX=
FABRIC_RELEASE_URL_WINDOWS=
FABRIC_SHA256_LINUX=
FABRIC_SHA256_WINDOWS=

# Model
MODEL_URL=
MODEL_SHA256=
MODEL_FILENAME=qwen3.5-9b-q4_k_m.gguf
MODEL_EXPECTED_SIZE_GB=≈4.5–6
```

## Safety rules
- Never download from an unpinned / untrusted URL.
- Always verify checksum before use.
- If download fails or checksum mismatches → stop with a clear message to the user.
- Prefer official Hugging Face / GitHub release assets.
