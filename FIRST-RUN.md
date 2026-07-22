# First Run — Auto-download Model (QVAC-style)

## Goal

On the first launch the agent must become usable without requiring the user to manually place large binaries or the model file.

## Strategy

1. **Binaries (goclaw + Fabric)**  
   Obtained via fork / pinned GitHub Releases.  
   Preparation script or launcher can fetch the correct OS binary.

2. **Local model (Qwen3.5-9B Q4_K_M)**  
   **Not** stored in git.  
   Downloaded automatically on first run if missing.

---

## First-run flow

```
Start launcher
    │
    ├─ Detect OS (Linux / Windows)
    ├─ Ensure goclaw binary is present (fetch from pinned release if needed)
    ├─ Ensure Fabric binary is present (fetch from pinned release if needed)
    │
    ├─ Check models/qwen3.5-9b-q4_k_m.gguf
    │     │
    │     ├─ EXISTS → continue
    │     └─ MISSING → download model + verify checksum → save to models/
    │
    ├─ Check internet
    │     ├─ ONLINE  → use cloud model + matching wrapper
    │     └─ OFFLINE → start Fabric + load local model + local wrapper
    │
    └─ Start goclaw
```

---

## Model download requirements

- File name: `qwen3.5-9b-q4_k_m.gguf`
- Location: `models/qwen3.5-9b-q4_k_m.gguf`
- Must verify checksum after download
- Must show clear progress to the user
- Must be resumable if possible
- On failure — show a simple error and do not start the agent in a broken state

---

## User experience (simple)

First launch:

```
Модель не найдена.
Скачиваю Qwen3.5-9B (это нужно только один раз)...
[progress]
Готово. Запускаю агента.
```

Next launches:
- no download
- immediate start

---

## Security notes

- Download only from trusted, pinned sources
- Verify checksum
- Never commit the model file or secrets into git
- `.gitignore` already excludes `models/` and binaries
