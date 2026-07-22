# model-router

## Description
Automatically chooses between cloud models and the local Fabric model.

## Models

### Cloud (primary)
- Grok 4.5
- Qwen 3.8
- Minimax M2.7

### Local (fallback only)
- **Qwen3.5-9B** (Q4_K_M or Q5_K_M)
- Location on USB: `models/qwen3.5-9b-q4_k_m.gguf`

## Logic
1. Check internet availability.
2. If internet is available → use cloud models.
3. If internet is unavailable → start Fabric + load Qwen3.5-9B and inform the user.
4. When internet returns → prefer switching back to cloud models.

## Rules
- Always tell the user which mode is currently active (online / offline).
- Local model is strictly a fallback.
- Do not load the local model if cloud is available.
