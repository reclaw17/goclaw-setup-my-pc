# Secrets (`.env` on USB)

## Rule

| Place | `.env` with real keys |
|-------|------------------------|
| **USB project root** | **Yes — required for cloud models + Perplexity** |
| GitHub / git commit | **Never** |
| Screenshots / chat | Avoid |

## Setup

```bash
cd /path/on/usb/goclaw-setup-my-pc
cp -n .env.example .env
nano .env    # or any editor
```

## Keys

| Variable | Purpose |
|----------|---------|
| `XAI_API_KEY` | Grok (primary) |
| `OPENROUTER_API_KEY` | Cloud backup / Qwen via OpenRouter |
| `QWEN_API_KEY` | Qwen direct if used |
| `MINIMAX_API_KEY` | MiniMax if used |
| `PERPLEXITY_API_KEY` | Perplexity / Sonar web research |
| `LOCAL_LLM_*` | Fabric offline |

Template: [`.env.example`](../.env.example).

GoClaw wizard may also store provider keys in its own SQLite under `~/.goclaw/` on the host — prefer documenting both; USB `.env` is the portable source of truth for this kit.
