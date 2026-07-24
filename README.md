# goclaw-setup-my-pc

Portable AI agent for PC + OpenWrt setup from a USB stick.

**Engine:** [GoClaw Lite AppImage](https://github.com/reclaw17/goclaw-lite-cachyos) (SQLite)  
**Latest:** [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)

**Repo rules:** English-first · English file names · Issues in English (preferred) · language menu inside scripts — [docs/REPO-RULES.md](docs/REPO-RULES.md)

---

## English

### Quick start

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh      # language menu: 1=EN (default), 2=RU
# edit .env → XAI_API_KEY=...
bash start.sh
bash update.sh       # later
```

Legacy Russian script names still work (`подготовить.sh` → calls `prepare.sh`).

---

## Russian

```bash
bash prepare.sh      # выбери 2 для русского UI скрипта
bash start.sh
bash update.sh
```

Имена файлов в репо — **английские**. Русские `старт.sh` и т.п. — только обёртки.

Правила: [docs/REPO-RULES.md](docs/REPO-RULES.md)
