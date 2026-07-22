# Project Plan — goclaw-setup-my-pc

**Version:** 1.0 (production-ready)  
**Last update:** 2026-07-22  
**Principle:** Quality over speed. No stage is considered complete until it passes the quality gates.

---

## 1. Project Goal

Create a **portable AI agent** based on the official [goclaw](https://github.com/nextlevelbuilder/goclaw) that runs from a USB flash drive and helps a non-developer user to:

- Configure **CachyOS / Arch Linux** and **Windows 11**
- Configure **OpenWrt routers** (backup → packages → Wi-Fi → VPN → DNS)
- Work reliably **without internet** (local models via Fabric as fallback)
- Use a **local offline documentation base**
- Operate under **Cursor-style safety** (explicit confirmation before any dangerous action)
- Support **Russian and English**

### Non-goals (what we deliberately do NOT do)
- We do not support macOS (removed from scope)
- We do not provide ready-made illegal bypass recipes
- We do not aim for a full multi-agent enterprise system
- We do not invent new inference engines (we reuse Fabric)

---

## 2. Success Criteria (Definition of Done)

### MVP is successful when:
1. Agent starts from USB on Linux and Windows with one command/click
2. Correctly switches between cloud and local model (Fabric)
3. Asks for confirmation before any system/router change
4. Can create OpenWrt backup and perform basic safe configuration
5. Can answer basic questions from local `docs/` without internet
6. Secrets stay only in `.env` (never in git)

### Public release is successful when:
- All of the above + cleaned of secrets + clear README + MIT license + no critical known bugs

---

## 3. Quality Principles (mandatory)

1. Every skill must pass `QUALITY-CHECKLIST.md` before being marked ready
2. Dangerous actions always require explicit user confirmation
3. Local documentation (`docs/`) has higher priority than internet search
4. Official documentation is the source of truth (especially OpenWrt)
5. We prefer adapting strong originals from the Human20 archive over inventing from scratch
6. Better 5 high-quality skills than 15 weak stubs
7. We never skip stages
8. User has zero development experience → everything must stay simple and transparent

---

## 4. Current Honest Status

| Component                        | Status     | Quality  | Notes |
|----------------------------------|------------|----------|-------|
| System prompts (RU + EN)         | Done       | Good     | Solid |
| USB-STRUCTURE.md                 | Done       | Good     | Clear |
| QUALITY-CHECKLIST.md             | Done       | Good     | Mandatory |
| openwrt skill                    | Done       | Good     | Best skill so far |
| local-docs skill                 | Partial    | Medium   | Needs strengthening from chip-docs-local |
| safety-confirm skill             | Partial    | Medium   | Needs strengthening |
| backup / network-vpn / coding    | Stubs      | Low      | Require full rewrite |
| fabric-offline skill             | Missing    | —        | Critical |
| pc-setup skill                   | Missing    | —        | Critical |
| Launcher scripts                 | Missing    | —        | |
| Local documentation content      | Empty      | —        | |
| Working MVP                      | Not started| —        | |

---

## 5. Phased Plan with Quality Gates

### Phase 1 — Quality of Core Skills (CURRENT)

**Goal:** Bring the most important skills to high quality.

Order of work:
1. **local-docs** — base on `chip-docs-local`, make it as close as possible to the original while adding USB + offline priority
2. **safety-confirm** — raise to real Cursor-style level
3. **openwrt** — polish the already good skill against the checklist
4. **fabric-offline** — create carefully (sidecar, 8 GB VRAM, model load/unload)
5. **pc-setup** — create (CachyOS/Arch + Windows 11)

**Exit criteria (Quality Gate):**  
All five skills pass every item of `QUALITY-CHECKLIST.md` without exceptions.

Only after this gate is closed → Phase 2.

---

### Phase 2 — Offline Runtime

- Fabric as portable sidecar (Linux + Windows binaries)
- Model selection and packaging for 8 GB VRAM + 16 GB RAM
- Correct online/offline detection and user notification
- Memory-aware load/unload behaviour

**Exit criteria:**  
Agent successfully falls back to local model when internet is unavailable and returns to cloud when internet appears.

---

### Phase 3 — Launcher & Portability

- `launcher/start-linux.sh`
- `launcher/start-windows.bat`
- Automatic OS detection
- Automatic internet check
- Automatic Fabric start when needed
- Persistent settings (language, defaults)

**Exit criteria:**  
One-click / one-command start from USB on both target operating systems.

---

### Phase 4 — Local Knowledge Base

- Populate `docs/` with high-quality offline documentation:
  - OpenWrt
  - CachyOS / Arch Linux
  - Windows 11
  - AdGuard Home / VPN / DNS
  - Amnezia Premium
- Support user-added documents in `docs/custom/`
- Use the chip-docs-local approach

**Exit criteria:**  
Agent can answer the most common practical questions about target systems without internet.

---

### Phase 5 — MVP Testing

Real-world testing on actual hardware:
- Basic PC setup (Linux + Windows)
- OpenWrt backup + safe configuration
- Offline mode
- Safety confirmations
- Language switching

**Exit criteria:**  
Agent helps the user complete real tasks without critical errors or unsafe behaviour.

---

### Phase 6 — Public Release

- Remove all secrets
- Final README (bilingual)
- MIT License
- Clean repository
- Public GitHub release

---

## 6. Dependencies & Constraints

- Hardware target for local models: ≥ 8 GB VRAM + 16 GB system RAM
- Inference engine: Fabric (qvac-fabric-llm.cpp) as OpenAI-compatible server
- Secrets: only in `.env` (never committed)
- User skill level: zero development experience → we lead, keep everything simple
- Platform: goclaw (official repo) + our skills + Fabric

---

## 7. Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Local model too large for USB | High | Choose well-quantized 7–9B model; document size requirements |
| Fabric compatibility with different GPUs | Medium | Prefer Vulkan + CPU fallback; test on real hardware early |
| User has no coding experience | High | Keep all decisions transparent, write simple scripts, never assume knowledge |
| Skills become inconsistent | Medium | Strict use of QUALITY-CHECKLIST.md + single source of truth |
| Scope creep | High | Explicit non-goals + phase gates |

---

## 8. Working Rules

1. Always work **in order**. Never skip phases.
2. A skill is not “done” until it passes the full QUALITY-CHECKLIST.md.
3. Prefer strong originals from the archive → minimal necessary adaptation.
4. Document every important decision in the repository.
5. Quality is non-negotiable.

---

**Next concrete action:**  
Start Phase 1 by improving `local-docs` on the base of the original `chip-docs-local`.
