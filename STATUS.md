# STATUS

**Date:** 2026-07-24

## Phase A — USB shell around GoClaw Lite — DONE

| Item | Status |
|------|--------|
| Engine = Lite AppImage in `apps/` | Done |
| Fetch from lite Releases (`v0.2.0-cachyos`) | `prepare.sh` / `scripts/fetch-goclaw-appimage.sh` |
| Start | `start.sh` → `launcher/start-linux.sh` |
| Update | `update.sh` / `scripts/update-goclaw.sh` |
| Secrets template | `.env.example` (no keys in git) |
| AppImage not in git | `.gitignore` |
| USB tree doc | `USB-STRUCTURE.md` |
| Provider preset hints | `config/providers.example.json` |

## How to run (user)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh    # downloads AppImage into apps/
# edit .env → XAI_API_KEY=...
bash start.sh
bash update.sh     # later
```

## Next

- Phase B polish: docs for wizard mapping Grok / Qwen / Fabric  
- Phase D: skills, offline docs pack, Fabric model download, Win11  

## Related

- Packaging factory: https://github.com/reclaw17/goclaw-lite-cachyos  
- Integration plan: [docs/PLAN-goclaw-integration.md](docs/PLAN-goclaw-integration.md)  
