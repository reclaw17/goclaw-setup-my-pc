# Sources — Binaries & Model

**Status:** Production policy + model pin  
**Last update:** 2026-07-22

## 1. Local Model (pinned)

| Field | Value |
|------|--------|
| Model | Qwen3.5-9B (Q4_K_M) |
| Filename on USB | `models/Qwen3.5-9B-Q4_K_M.gguf` |
| URL | `https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf` |
| SHA256 | `03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8` |
| Size | ~5.68 GB |
| Hardware target | 8 GB VRAM + 16 GB RAM |

Behaviour:
1. Launcher checks if the file exists
2. If missing → download from the URL above
3. Verify SHA256
4. Keep permanently on the USB

## 2. Binaries (policy)

| Component | Source strategy |
|-----------|-----------------|
| goclaw | Official releases from `nextlevelbuilder/goclaw` or a controlled fork |
| Fabric | Pinned binary from `tetherto/qvac-fabric-llm.cpp` / QVAC releases or controlled build |

Large binaries are **never** committed to git.

```text
# Fill these when concrete release assets are chosen
GOCLAW_RELEASE_URL_LINUX=
GOCLAW_RELEASE_URL_WINDOWS=
GOCLAW_SHA256_LINUX=
GOCLAW_SHA256_WINDOWS=

FABRIC_RELEASE_URL_LINUX=
FABRIC_RELEASE_URL_WINDOWS=
FABRIC_SHA256_LINUX=
FABRIC_SHA256_WINDOWS=
```

## 3. Safety rules

- Download only from pinned sources
- Always verify checksum
- On mismatch or failure → stop with a clear message
- Prefer official GitHub / Hugging Face assets
