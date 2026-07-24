# Provider presets + keys on USB

Secrets live in **`.env` on the flash drive** (see [SECRETS.md](SECRETS.md)).

```bash
cp -n .env.example .env
# XAI_API_KEY=...
# PERPLEXITY_API_KEY=...
```

## Grok (primary online)

| Field | Value |
|-------|--------|
| Type | xAI (Grok) |
| Base URL | `https://api.x.ai/v1` |
| Key | `XAI_API_KEY` from USB `.env` |

## OpenRouter / Qwen (backup)

| Field | Value |
|-------|--------|
| Base URL | `https://openrouter.ai/api/v1` |
| Key | `OPENROUTER_API_KEY` |

## Local Fabric (offline)

| Field | Value |
|-------|--------|
| Base URL | `http://127.0.0.1:8080/v1` |
| Key | `sk-local` / `LOCAL_LLM_API_KEY` |

## Perplexity

Use `PERPLEXITY_API_KEY` from `.env` with web-research / workshop-perplex skills when online.

Machine-readable: `config/providers.example.json`.
