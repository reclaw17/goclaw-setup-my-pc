# First run (USB kit)

## 1. On the stick

```bash
cd /path/to/usb/goclaw-setup-my-pc
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-offline-docs.sh          # GoClaw + index offline
cp -n .env.example .env
# edit .env: XAI_API_KEY, PERPLEXITY_API_KEY, …
bash start.sh
```

## 2. Keys

All cloud keys stay in **`.env` on the USB** — [docs/SECRETS.md](docs/SECRETS.md).

## 3. Offline docs

- Hand notes: `docs/openwrt`, `docs/cachyos-arch`, …  
- GoClaw upstream markdown: `docs/mirrors/goclaw/` after `fetch-offline-docs.sh`  
- Details: [docs/OFFLINE-DOCS.md](docs/OFFLINE-DOCS.md)

## 4. Wizard

Provider **xAI (Grok)** + key from `.env` — [docs/PROVIDERS.md](docs/PROVIDERS.md).
