# goclaw-setup-my-pc

**Portable AI agent for setting up PCs and OpenWrt routers from a USB flash drive.**

Based on official [goclaw](https://github.com/nextlevelbuilder/goclaw).

## What it does

- Configures **CachyOS / Arch Linux** and **Windows 11**
- Configures **OpenWrt** routers (backup → packages → Wi-Fi → VPN → DNS)
- Works offline via **Fabric + local model**
- Uses a local documentation base on the USB
- Cursor-style safety (explicit confirmation before dangerous actions)
- Russian + English

## Models

| Type | Models |
|------|--------|
| Cloud (primary) | Grok 4.5, Qwen 3.8, Minimax M2.7 |
| Local (fallback only) | Qwen3.5-9B Q4_K_M |

Local model is used **only** when there is no internet.  
It must run on 8 GB VRAM + 16 GB RAM.

## Architecture principle

> The model is the brain.  
> Skills, docs, Fabric and launcher are the tools the brain uses.

Each model has its own optimized wrapper (harness).

## Project structure

```
.
├── prompts/               # system-common + individual model wrappers
├── skills/                # production-ready skills
├── launcher/              # first-run + start scripts
├── docs/                  # offline documentation (to be populated)
├── MODELS.md
├── SOURCES.md             # pinned binaries + model sources
├── USB-STRUCTURE.md
├── PROJECT-PLAN.md
├── QUALITY-CHECKLIST.md
└── FIRST-RUN.md
```

## Current status

**Phase 1 (Core skills + wrappers + architecture) — COMPLETE at high quality.**

Next phases:
- Pin exact release checksums
- Implement full launcher orchestration
- Populate offline docs
- Hardware MVP test
- Public release

## Quality rule

Every skill must pass `QUALITY-CHECKLIST.md`.  
Quality is more important than speed.

## License

MIT (planned for public release)
