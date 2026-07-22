# Project Plan — goclaw-setup-my-pc

**Version:** 1.2 (production-ready)  
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

## 2. Core Architecture Insight

**The model is the brain of the agent.**

Everything else exists to serve the model:
- Skills = tools the brain can use
- Local docs = knowledge the brain can read
- Fabric = offline body for the local brain
- Launcher = way to start the brain
- Safety rules = constraints the brain must obey

Therefore we optimize the brain first (good models + good individual harnesses).

---

## 3. Models + Individual Wrappers (Harnesses)

### Models

**Cloud (primary):**
1. Grok 4.5
2. Qwen 3.8
3. Minimax M2.7

**Local (fallback only):**
- **Qwen3.5-9B** (Q4_K_M preferred)
- Used **only** when there is no internet
- Must run on 8 GB VRAM + 16 GB RAM

### Individual Model Wrappers (new)

Each model gets its **own harness / system prompt wrapper**.

When the model is switched, the wrapper is also switched automatically by `model-router`.

```
prompts/
├── system-common.md          ← shared safety rules (all models)
├── wrapper-grok.md           ← optimized for Grok 4.5
├── wrapper-qwen-cloud.md     ← optimized for Qwen 3.8
├── wrapper-minimax.md        ← optimized for Minimax M2.7
└── wrapper-qwen-local.md     ← short & strict for Qwen3.5-9B
```

This is inspired by AutoGen patterns and modern harness research (AIDE² etc.).

**Why:** Different models have different strengths. A tailored wrapper extracts maximum quality from each brain.

---

## 4. Success Criteria (Definition of Done)

### MVP is successful when:
1. Agent starts from USB on Linux and Windows with one command/click
2. Correctly switches between cloud and local model (Fabric) **and** loads the matching wrapper
3. Asks for confirmation before any system/router change
4. Can create OpenWrt backup and perform basic safe configuration
5. Can answer basic questions from local `docs/` without internet
6. Secrets stay only in `.env` (never in git)

### Public release is successful when:
- All of the above + cleaned of secrets + clear README + MIT license + no critical known bugs

---

## 5. Quality Principles (mandatory)

1. Every skill must pass `QUALITY-CHECKLIST.md` before being marked ready
2. Dangerous actions always require explicit user confirmation
3. Local documentation (`docs/`) has higher priority than internet search
4. Official documentation is the source of truth (especially OpenWrt)
5. We prefer adapting strong originals from the Human20 archive over inventing from scratch
6. Better 5 high-quality skills than 15 weak stubs
7. We never skip stages
8. User has zero development experience → everything must stay simple and transparent
9. Model = brain → we invest in good wrappers for each model

---

## 6. Current Honest Status

| Component                        | Status     | Quality  | Notes |
|----------------------------------|------------|----------|-------|
| System prompts (RU + EN)         | Done       | Good     | Will become system-common + wrappers |
| USB-STRUCTURE.md                 | Done       | Good     | Clear |
| QUALITY-CHECKLIST.md             | Done       | Good     | Mandatory |
| MODELS.md                        | Done       | Good     | Fixed local model |
| openwrt skill                    | Done       | Good     | Best skill so far |
| local-docs skill                 | Partial    | Medium   | Needs strengthening from chip-docs-local |
| safety-confirm skill             | Partial    | Medium   | Needs strengthening |
| Model wrappers                   | Missing    | —        | New priority |
| fabric-offline skill             | Missing    | —        | Critical |
| pc-setup skill                   | Missing    | —        | Critical |
| Launcher scripts                 | Missing    | —        | |
| Local documentation content      | Empty      | —        | |
| Working MVP                      | Not started| —        | |

---

## 7. Phased Plan with Quality Gates

### Phase 1 — Quality of Core Skills + Model Wrappers (CURRENT)

**Goal:** Bring the most important skills and model harnesses to high quality.

Order of work:
1. Create structure of individual model wrappers (`wrapper-*.md`)
2. **local-docs** — base on `chip-docs-local`
3. **safety-confirm** — raise to real Cursor-style level
4. Polish **openwrt** against the checklist
5. **fabric-offline** — create carefully
6. **pc-setup** — create (CachyOS/Arch + Windows 11)

**Exit criteria (Quality Gate):**  
- All listed skills pass every item of `QUALITY-CHECKLIST.md`
- Each of the 4 models has its own tested wrapper
- model-router correctly switches both model and wrapper

Only after this gate is closed → Phase 2.

---

### Phase 2 — Offline Runtime

- Fabric as portable sidecar (Linux + Windows binaries)
- Model: Qwen3.5-9B Q4_K_M
- Correct online/offline detection and user notification
- Automatic switch of wrapper when falling back to local model

**Exit criteria:**  
Agent successfully falls back to local model + correct local wrapper when internet is unavailable.

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

- Populate `docs/` with high-quality offline documentation
- Support user-added documents in `docs/custom/`
- Use the chip-docs-local approach

**Exit criteria:**  
Agent can answer the most common practical questions about target systems without internet.

---

### Phase 5 — MVP Testing

Real-world testing on actual hardware.

**Exit criteria:**  
Agent helps the user complete real tasks without critical errors or unsafe behaviour.

---

### Phase 6 — Public Release

- Remove all secrets
- Final README (bilingual)
- MIT License
- Public GitHub release

---

## 8. Dependencies & Constraints

- Hardware target for local models: ≥ 8 GB VRAM + 16 GB system RAM
- Inference engine: Fabric as OpenAI-compatible server
- Local model: Qwen3.5-9B Q4_K_M
- Secrets: only in `.env`
- User skill level: zero development experience
- Platform: goclaw + our skills + Fabric + model-specific wrappers

---

## 9. Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Local model too large for USB | High | Qwen3.5-9B Q4_K_M is chosen |
| Different models need different styles | Medium | Individual wrappers |
| Fabric compatibility | Medium | Prefer Vulkan + CPU fallback |
| User has no coding experience | High | Keep everything simple and transparent |
| Scope creep | High | Explicit non-goals + phase gates |

---

## 10. Working Rules

1. Always work **in order**. Never skip phases.
2. A skill is not “done” until it passes the full QUALITY-CHECKLIST.md.
3. Prefer strong originals from the archive → minimal necessary adaptation.
4. Model = brain → invest in good individual wrappers.
5. Document every important decision in the repository.
6. Quality is non-negotiable.

---

**Next concrete action:**  
Start Phase 1 by creating the structure of individual model wrappers + improving `local-docs`.
