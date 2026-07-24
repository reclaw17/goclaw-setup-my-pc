# STATUS

**Date:** 2026-07-24

## USB 32 GB policy

- **`.env` on stick** with model + **Perplexity** keys ([docs/SECRETS.md](docs/SECRETS.md))  
- **Full offline docs** including **GoClaw** mirror: `bash scripts/fetch-offline-docs.sh`  
- Full skills on stick via `fetch-human20-skill.sh`  
- Git never gets `.env`, AppImage, GGUF, or `docs/mirrors/`  

## A–D done · E next

```bash
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-offline-docs.sh
cp -n .env.example .env
bash start.sh
```
