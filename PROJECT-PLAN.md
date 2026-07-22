# Project Plan — goclaw-setup-my-pc

**Version:** 1.3 (production-ready)  
**Last update:** 2026-07-22  
**Principle:** Quality over speed. Model = brain.

---

## 1. Project Goal

Portable AI agent on official goclaw for:
- CachyOS / Arch Linux
- Windows 11
- OpenWrt routers

Hybrid mode:
- Cloud models by default
- Local Qwen3.5-9B via Fabric only offline

Safety: Cursor-style confirmations  
Docs: local-first  
Languages: RU / EN

---

## 2. Core Architecture

**Model = brain**  
Skills / docs / Fabric / launcher = tools.

Each model has its own wrapper.  
When model switches, wrapper switches too.

### Models
- Cloud: Grok 4.5, Qwen 3.8, Minimax M2.7
- Local fallback: Qwen3.5-9B Q4_K_M

### Delivery strategy (locked)
1. **Binaries (goclaw + Fabric)** → via fork / pinned GitHub Releases
2. **Model file** → auto-download on first run if missing (QVAC-style)

Details: `FIRST-RUN.md`, `SOURCES.md`

---

## 3. Quality Principles

1. Every skill passes QUALITY-CHECKLIST.md
2. Dangerous actions require explicit confirmation
3. Local docs before internet
4. Official docs are source of truth for OpenWrt
5. Prefer adapting strong originals over inventing from scratch
6. Better fewer strong skills than many weak ones
7. Model + wrapper quality is first-class
8. Keep everything understandable for a non-developer

---

## 4. Status

| Area | Status |
|------|--------|
| Architecture & plan | Done |
| Model wrappers | Done |
| Core skills | Done (high quality) |
| First-run strategy | Done (documented) |
| Launcher full logic | Next |
| Pinned release URLs + model checksum | Next |
| docs/ content | Pending |
| Hardware MVP test | Pending |

---

## 5. Phases

### Phase 1 — Skills + Wrappers
**Status:** Complete at high quality

### Phase 2 — Offline runtime packaging
- Pin Fabric + goclaw release sources
- Pin model URL + SHA256
- Implement first-run download
- Fabric sidecar start/stop

### Phase 3 — Launcher
- `start-linux.sh` / `start-windows.bat` full logic
- internet detection
- model presence check + download
- wrapper selection
- goclaw start

### Phase 4 — Local knowledge base
- Fill docs/openwrt, cachyos-arch, windows11, adguard, amnezia
- Keep docs/custom user-writable

### Phase 5 — MVP testing
- Real USB
- Online + offline
- OpenWrt backup flow
- PC setup flow
- Safety confirmations

### Phase 6 — Public release
- No secrets
- MIT
- Clean README

---

## 6. Working Rules

1. Work in order
2. No stage closed without quality gate
3. Prefer pinned trusted sources for binaries and model
4. Never commit `.env`, model files, or large binaries by default
5. Quality is non-negotiable

---

**Next concrete action:**  
Pin exact binary release URLs and model checksum in `SOURCES.md`, then implement launcher first-run logic.
