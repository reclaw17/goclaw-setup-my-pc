# goclaw-setup-my-pc

**Portable AI agent** for setting up PCs and OpenWrt routers from a USB flash drive.

Based on official [goclaw](https://github.com/nextlevelbuilder/goclaw).

Портативный AI-агент для настройки компьютеров и OpenWrt-роутеров с флешки.

---

## What it does

- Configures **CachyOS / Arch Linux** and **Windows 11**
- Configures **OpenWrt** routers (backup first → packages → Wi-Fi → VPN → DNS)
- Works **offline** via Fabric + local model
- Uses local documentation on the USB
- Cursor-style safety (asks before any dangerous action)
- Russian + English

---

## Models

| Type | Models |
|------|--------|
| Cloud (primary) | Grok 4.5, Qwen 3.8, Minimax M2.7 |
| Local (fallback only) | Qwen3.5-9B Q4_K_M |

Local model is used **only when there is no internet**.  
Target hardware: **8 GB VRAM + 16 GB RAM**.

---

## Architecture

> The model is the brain.  
> Skills, docs, Fabric and launcher are the tools.

Each model has its own optimized wrapper.  
When the model changes, the wrapper changes too.

---

## How to launch (for a non-developer)

### 1. Prepare the USB

1. Format a USB flash drive (exFAT or NTFS is fine for Windows+Linux use).
2. Copy the contents of this repository to the USB.
3. (Recommended) run the helper:

```bash
bash scripts/prepare-usb.sh /path/to/usb
```

### 2. Place or obtain binaries

You need two binaries on the USB:

- `goclaw/` → goclaw binary (Linux + Windows)
- `fabric/` → Fabric binary (Linux + Windows)

Sources are described in `SOURCES.md`.  
Large binaries are not stored in git on purpose.

### 3. Secrets

Copy the example and fill your keys:

```bash
cp .env.example .env
```

Put API keys only in `.env`. Never commit this file.

### 4. Start

**Linux:**
```bash
bash launcher/start-linux.sh
```

**Windows:**
```bat
launcher\start-windows.bat
```

### 5. First run (important)

On the first offline launch the agent will:

1. Notice that the local model is missing
2. Download `Qwen3.5-9B-Q4_K_M.gguf` (~5.7 GB)
3. Verify SHA256
4. Save it to `models/`
5. Start normally

Next launches will reuse the downloaded model.

---

## Safety

Before any action that changes the system or router the agent will:

1. Show the exact command
2. Explain what it does
3. Ask for confirmation

On OpenWrt it will also offer a backup first.

---

## Project structure

```
.
├── prompts/                 # common rules + model wrappers
├── skills/                  # production-ready skills
├── launcher/                # start scripts + first-run logic
├── docs/                    # offline documentation
├── config/goclaw.example.yaml
├── scripts/prepare-usb.sh
├── SOURCES.md               # pinned model + binary policy
├── FIRST-RUN.md
├── USB-STRUCTURE.md
├── MVP-TEST-CHECKLIST.md
└── PROJECT-PLAN.md
```

---

## Current status

Design + Skills + packaging design are complete at high quality.

Still required for a fully runnable USB image:

1. Place real goclaw + Fabric binaries (or download via pinned releases)
2. Fill remaining binary SHA256 values in `SOURCES.md`
3. Populate `docs/` with real content
4. Run `MVP-TEST-CHECKLIST.md` on real hardware

---

## License

MIT
