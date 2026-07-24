# goclaw-setup-my-pc

Portable AI agent for PC + OpenWrt setup from a USB stick.

**Engine:** [GoClaw Lite AppImage](https://github.com/reclaw17/goclaw-lite-cachyos) (SQLite)  
**Latest AppImage:** [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)

**Phase A (USB shell): done** — prepare → start → update around the AppImage.

---

## English

### Quick start

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh      # 1=English (default), 2=Russian — downloads AppImage to apps/
# copy secrets:
cp -n .env.example .env
# edit .env → set XAI_API_KEY=...
bash start.sh
bash update.sh       # later
```

Provider hints: `config/providers.example.json` (use in GoClaw wizard).  
USB layout: [USB-STRUCTURE.md](USB-STRUCTURE.md) · Status: [STATUS.md](STATUS.md) · Plan: [PLAN.md](PLAN.md)

Do **not** commit `apps/*.AppImage` or real `.env`.

---

## Russian

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh      # язык: 2 = русский; скачает AppImage в apps/
cp -n .env.example .env
# впиши XAI_API_KEY в .env
bash start.sh
bash update.sh
```

Пресеты провайдеров: `config/providers.example.json`.  
Структура флешки: [USB-STRUCTURE.md](USB-STRUCTURE.md).
