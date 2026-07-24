# goclaw-setup-my-pc

Портативный AI-агент для настройки ПК и OpenWrt-роутера (флешка).

**Движок:** [GoClaw Lite AppImage](https://github.com/reclaw17/goclaw-lite-cachyos) (SQLite, без PostgreSQL).  
**Latest AppImage:** [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)

Опыт программирования **не обязателен**.

---

## Linux (CachyOS / Arch)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc

# 1) скачать AppImage в apps/
bash подготовить.sh

# 2) ключи (Grok и т.д.)
nano .env    # XAI_API_KEY=...

# 3) запуск
bash старт.sh
```

Обновить AppImage позже:

```bash
bash обновить.sh
# или
bash scripts/update-goclaw.sh
```

---

## English

1. `bash подготовить.sh` — downloads GoClaw Lite into `apps/`  
2. Edit `.env` — cloud API keys  
3. `bash старт.sh` — launches the AppImage  

Layout: [USB-STRUCTURE.md](USB-STRUCTURE.md) · Plan: [docs/PLAN-goclaw-integration.md](docs/PLAN-goclaw-integration.md) · [STATUS.md](STATUS.md)

---

## Important

- Unofficial integration around community Lite packaging + upstream GoClaw.
- No secrets in git. App bugs → upstream / lite packaging repos as appropriate.
