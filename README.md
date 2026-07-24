# goclaw-setup-my-pc

Portable AI agent for PC + OpenWrt setup from a USB stick.

**Engine:** [GoClaw Lite AppImage](https://github.com/reclaw17/goclaw-lite-cachyos) (SQLite, no PostgreSQL)  
**Latest AppImage:** [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)

No coding experience required.

> **Repo language:** English first; Russian beginner path supported.  
> Rules: [docs/REPO-RULES.md](docs/REPO-RULES.md)

---

## English

### Quick start (Linux / CachyOS / Arch)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash подготовить.sh    # downloads AppImage into apps/
# edit .env — set XAI_API_KEY=...
bash старт.sh
```

Update AppImage later:

```bash
bash обновить.sh
```

### Docs

- [USB-STRUCTURE.md](USB-STRUCTURE.md)
- [docs/PLAN-goclaw-integration.md](docs/PLAN-goclaw-integration.md)
- [docs/REPO-RULES.md](docs/REPO-RULES.md)
- [STATUS.md](STATUS.md)

---

## Russian

Портативный агент с флешки для настройки ПК и OpenWrt.

**Движок:** GoClaw Lite (AppImage).  
**Правила ведения репо (EN + RU):** [docs/REPO-RULES.md](docs/REPO-RULES.md)

### Быстрый старт

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash подготовить.sh
# в .env добавь XAI_API_KEY=...
bash старт.sh
```

Обновление AppImage: `bash обновить.sh`
