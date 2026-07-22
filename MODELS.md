# Models

## Cloud models (primary)

1. **Grok 4.5**
2. **Qwen 3.8**
3. **Minimax M2.7**

These are used when internet is available.

---

## Local model (fallback only)

**Primary choice:** `Qwen3.5-9B`  
**Quantization:** `Q4_K_M` (preferred) or `Q5_K_M`

### Why this model
- Best quality/performance balance for 8 GB VRAM + 16 GB RAM
- Strong coding ability
- Good reasoning for system configuration tasks
- Fits comfortably in 8 GB VRAM (~6.5–7.5 GB)
- Works well with Fabric / llama.cpp

### Usage rule
Local model is used **only** when there is no internet connection.

### File location on USB
```
models/
└── qwen3.5-9b-q4_k_m.gguf
```
