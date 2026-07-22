# Sources — Binaries & Model

**Status:** Production pins (model complete, binaries pending exact assets)

## 1. Local Model (pinned)

| Field | Value |
|------|--------|
| Model | Qwen3.5-9B |
| Quantization | Q4_K_M |
| Filename on USB | `models/qwen3.5-9b-q4_k_m.gguf` |
| URL | `https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf` |
| SHA256 | `03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8` |
| Approx. size | 5.68 GB |

**Behaviour:** On first launch, if the file is missing, the launcher downloads it, verifies the SHA256, and keeps it on the USB forever.

## 2. Binaries (policy)

- **goclaw** → official releases from `nextlevelbuilder/goclaw` (or controlled fork)
- **Fabric** → releases from `tetherto/qvac-fabric-llm.cpp` (or controlled fork)

Exact asset names + SHA256 will be pinned here as soon as the chosen release is verified.

Until then the launcher must fail safely with a clear message instead of downloading from an untrusted source.

## 3. Safety rules

- Never download from an unpinned URL
- Always verify SHA256 before use
- If checksum mismatches → stop and inform the user
- Prefer official GitHub Releases / Hugging Face
