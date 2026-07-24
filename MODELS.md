# Models

## Cloud (primary — online)

1. **Grok** (xAI) — default in wizard  
2. **Qwen** via OpenRouter / vendor API  
3. **Minimax** (optional)

See [docs/PROVIDERS.md](docs/PROVIDERS.md).

## Local (fallback — offline only)

| Item | Value |
|------|--------|
| Model | Qwen3.5-9B Q4_K_M |
| File | `models/qwen3.5-9b-q4_k_m.gguf` |
| SHA256 | `03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8` |
| Source | Hugging Face `unsloth/Qwen3.5-9B-GGUF` |
| Target HW | ~8 GB VRAM + 16 GB RAM |

### Download (Linux)

```bash
bash scripts/fetch-model.sh
bash scripts/fetch-fabric.sh
# or both:
bash scripts/fetch-offline-stack.sh
```

### Run local server (example)

```bash
./fabric/llama-server -m models/qwen3.5-9b-q4_k_m.gguf --host 127.0.0.1 --port 8080
```

GoClaw provider: OpenAI-compatible `http://127.0.0.1:8080/v1`.
