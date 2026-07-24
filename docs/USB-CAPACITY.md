# USB capacity (32 GB)

## Policy

| Store | On USB | In git |
|-------|--------|--------|
| GoClaw AppImage | **Yes** | No |
| Fabric + GGUF model | **Yes** | No |
| Full Human20 skills (`skills/vendor/`) | **Yes** | No |
| **Full offline docs** incl. **GoClaw** (`docs/mirrors/`) | **Yes** | No (mirrors) |
| **`.env` with API keys** (models + Perplexity) | **Yes** | **Never** |
| Procedure pack, scripts, thin docs | Yes | Yes |

## `.env` on the stick

```bash
cp -n .env.example .env
# edit .env on the USB — keys stay on the stick only
```

Typical keys: `XAI_API_KEY`, `OPENROUTER_API_KEY`, `QWEN_API_KEY`, `MINIMAX_API_KEY`, `PERPLEXITY_API_KEY`, local Fabric URL.

## Offline docs

```bash
bash scripts/fetch-offline-docs.sh
```

See [OFFLINE-DOCS.md](OFFLINE-DOCS.md).

## Fill stick

```bash
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-offline-docs.sh
bash scripts/fetch-human20-skill.sh chip-docs-local
bash scripts/fetch-human20-skill.sh backup-manager
cp -n .env.example .env   # fill keys on USB
```
