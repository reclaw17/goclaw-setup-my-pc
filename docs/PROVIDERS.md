# Provider presets (Phase B)

How to wire cloud + local models in the **GoClaw Lite** setup wizard.

Machine-readable copy: [`config/providers.example.json`](../config/providers.example.json)  
Secrets: [`.env.example`](../.env.example) → copy to `.env` (never commit `.env`).

---

## English

### Before the wizard

```bash
bash prepare.sh          # AppImage → apps/
cp -n .env.example .env
# edit .env — set at least:
#   XAI_API_KEY=xai-...
bash start.sh
```

GoClaw opens **Setup** (Provider → Model → Agent).

### Preset 1 — Grok (primary, online)

| Field | Value |
|-------|--------|
| Provider type | **xAI (Grok)** |
| Name | `xai` |
| API key | from `.env` → `XAI_API_KEY` (console.x.ai) |
| Base URL | `https://api.x.ai/v1` |

Use for: normal PC/router setup with internet.

### Preset 2 — OpenRouter / Qwen (cloud backup)

| Field | Value |
|-------|--------|
| Provider type | OpenAI-compatible (or OpenRouter if listed) |
| Name | `openrouter` |
| API key | `OPENROUTER_API_KEY` |
| Base URL | `https://openrouter.ai/api/v1` |
| Model | pick a Qwen / strong coding model in step 2 |

Use when: xAI is down or you want another cloud brain.

### Preset 3 — Local Fabric (offline fallback)

1. Start Fabric with a local model on port **8080** (Phase D automates this).
2. In wizard:

| Field | Value |
|-------|--------|
| Provider type | OpenAI-compatible |
| Name | `local-fabric` |
| API key | `sk-local` (or any non-empty if required) |
| Base URL | `http://127.0.0.1:8080/v1` |

Use when: no internet. Quality is limited by the local model (target: ~9B Q4 on 8GB VRAM).

### Recommended order

1. Configure **Grok** first and finish the wizard.  
2. Add OpenRouter later in settings if needed.  
3. Add Fabric only after local runtime exists.

### Safety

- Never paste production keys into git, screenshots, or `providers.example.json`.
- Lite stores data under `~/.goclaw/` on the host (not always on the USB).

---

## Russian

### До мастера

```bash
bash prepare.sh
cp -n .env.example .env
# XAI_API_KEY=...
bash start.sh
```

### Grok (основной)

- Тип: **xAI (Grok)**  
- URL: `https://api.x.ai/v1`  
- Ключ: из `.env` → `XAI_API_KEY`

### OpenRouter / Qwen (запас)

- OpenAI-compatible  
- URL: `https://openrouter.ai/api/v1`  
- Ключ: `OPENROUTER_API_KEY`

### Local Fabric (офлайн)

- URL: `http://127.0.0.1:8080/v1`  
- Ключ: `sk-local`  
- Сначала должен быть запущен Fabric с моделью (этап D).

Подробный JSON: `config/providers.example.json`.
