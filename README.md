# goclaw-setup-my-pc

Portable AI agent for **PC + OpenWrt** setup from a USB stick.

## Engine (Linux)

Upstream GoClaw **Lite** desktop installer is **macOS-only** (`install-lite.sh` says Linux is not supported yet).

**Our answer:** community **AppImage** for Arch/CachyOS:

| Piece | Repo |
|-------|------|
| AppImage factory | [goclaw-lite-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos) |
| Latest build | [v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos) |
| This repo | USB shell, procedures, offline Fabric/model fetch |

Unofficial packaging — not a nextlevelbuilder product. App bugs → [upstream](https://github.com/nextlevelbuilder/goclaw).

### OS matrix

| OS | GoClaw GUI |
|----|------------|
| **Linux (Arch/CachyOS)** | **AppImage** from lite-cachyos |
| **macOS** | Official upstream Lite installer |
| **Windows 11** | Wait for upstream desktop zip / use cloud + `fabric\win` / WSL+AppImage |

## Skills = procedure pack (not full Human20)

`skills/*/SKILL.md` are **short procedures** for this product (router, PC, safety, offline).

They are **not** the full Human20 skill zips/GitHub trees (those are catalog cards + external repos).  
Mapping + optional fetch: [docs/HUMAN20-SKILLS.md](docs/HUMAN20-SKILLS.md), [skills/README.md](skills/README.md).

---

## English — quick start

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh                 # downloads AppImage into apps/
cp -n .env.example .env         # set XAI_API_KEY=...
bash start.sh
```

- Providers: [docs/PROVIDERS.md](docs/PROVIDERS.md)  
- First run: [FIRST-RUN.md](FIRST-RUN.md)  
- Plan: [docs/PLAN-goclaw-integration.md](docs/PLAN-goclaw-integration.md)  
- Embed layout: [docs/EMBED.md](docs/EMBED.md)  

```bash
bash update.sh                  # newer AppImage from Releases
# optional offline brain:
bash scripts/fetch-offline-stack.sh linux
```

---

## Russian

**Linux AppImage** — наш ответ на отсутствие официального Lite под Linux.  
**skills/** — процедуры продукта, **не** полные пакеты Human20.

```bash
bash prepare.sh
cp -n .env.example .env    # XAI_API_KEY=...
bash start.sh
```
