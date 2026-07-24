# goclaw-setup-my-pc

Portable AI agent for PC + OpenWrt setup from a USB stick.

**Engine:** [GoClaw Lite AppImage](https://github.com/reclaw17/goclaw-lite-cachyos) · **Latest:** [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)

**Phases A–B done:** USB shell + provider presets (Grok primary).

---

## English

### Quick start

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh
cp -n .env.example .env
# set XAI_API_KEY in .env
bash start.sh
```

Wizard fields: **[docs/PROVIDERS.md](docs/PROVIDERS.md)**  
First run: **[FIRST-RUN.md](FIRST-RUN.md)** · Status: **[STATUS.md](STATUS.md)**

```bash
bash update.sh    # update AppImage later
```

---

## Russian

```bash
bash prepare.sh          # 2 = русский UI скрипта
cp -n .env.example .env  # XAI_API_KEY=...
bash start.sh
```

Пресеты провайдеров: [docs/PROVIDERS.md](docs/PROVIDERS.md)
