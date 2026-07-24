# Plan: GoClaw Lite → USB agent (goclaw-setup-my-pc)

Updated: **2026-07-24** (after Human20 archive + upstream GoClaw audit)

## Repos

| Repo | Role |
|------|------|
| [goclaw-lite-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos) | **Done** — Linux AppImage factory (upstream Lite is macOS-only) |
| [goclaw-setup-my-pc](https://github.com/reclaw17/goclaw-setup-my-pc) | **Main** — USB layout, scripts, procedures, offline stack |
| [nextlevelbuilder/goclaw](https://github.com/nextlevelbuilder/goclaw) | Upstream engine + docs https://docs.goclaw.sh |

## Product rules (unchanged)

- User: no coding experience — Grok leads, user gives ideas  
- Secrets only in `.env` / GoClaw UI — never in git  
- Cloud primary (Grok / Qwen / …); local Fabric **only offline**  
- Target hardware local model: ~8 GB VRAM / 16 GB RAM  
- Binaries in project folders on USB, **not** committed (fetch + checksum)  

## Order (do not reverse)

1. Shell around Lite (USB + start/update + env)  
2. Then skills / docs / Fabric / deeper integrations  

---

## Phase map

### A — USB shell — **DONE**

- `apps/`, `config/`, `scripts/`, `prepare.sh`, `start.sh`, `update.sh`  
- Fetch AppImage from lite Releases (`v0.2.0-cachyos`)  
- `.env.example`, AppImage gitignored  

### B — Provider presets — **DONE**

- Grok (primary), OpenRouter/Qwen, Local Fabric `:8080`  
- `docs/PROVIDERS.md`, `config/providers.example.json`, `FIRST-RUN.md`  

### C — No fat binaries in git — **DONE**

- Fetch-only AppImage / Fabric / GGUF  
- `docs/EMBED.md`  

### D — Skills pack + docs + offline fetch — **DONE (v1)**

- Procedure skills: openwrt, pc-setup, network-vpn, amnezia-adguard, fabric-offline, …  
- Notes under `docs/**`  
- `fetch-fabric.sh` / `fetch-model.sh` + SHA256  
- Honest Win11 notes  

**Audit caveat:** D skills are a **procedure pack**, not full Human20 zips and not yet GoClaw-native loader skills.

---

### E — Align with upstream GoClaw + Human20 — **NEXT**

| # | Task | Why |
|---|------|-----|
| E1 | Copy/use `bootstrap/` (AGENTS, SOUL, TOOLS) in Lite workspace | Upstream docs/07 context files |
| E2 | SKILL.md YAML frontmatter + document GoClaw skills dirs | docs/14–15 native loader |
| E3 | Script `fetch-human20-skill.sh` → selected zips into `skills/vendor/` | Archive cards ≠ full skills |
| E4 | Keep shortlist: chip-docs-local, clawguard, auto-model-router, backup-manager, shaw-coding-standard, repo-task-proof-loop, perplex-search | Product needs |
| E5 | README matrix: Linux AppImage (us) / macOS official Lite / Windows when upstream ships | Stop over-claiming |

Refs: [AUDIT-2026-07-24.md](AUDIT-2026-07-24.md), [GOCLAW-OFFICIAL.md](GOCLAW-OFFICIAL.md), [HUMAN20-SKILLS.md](HUMAN20-SKILLS.md)

---

### F — Offline knowledge quality

| # | Task |
|---|------|
| F1 | Optional **chip-docs-local** mirrors under `docs/mirrors/` (gitignored if huge) |
| F2 | `docs/FILELIST.md` + refresh script for agent search |
| F3 | User `docs/custom/` workflow documented in FIRST-RUN |

---

### G — Runtime wiring

| # | Task |
|---|------|
| G1 | Point Lite data/workspace to USB-friendly paths where possible |
| G2 | Auto-register procedure skills + vendor skills on first start |
| G3 | model-router behavior: online Grok → offline Fabric without manual re-wizard when possible |
| G4 | Launcher: start Fabric only if model present; clear EN/RU messages |

---

### H — Windows 11 track (honest)

| # | Task |
|---|------|
| H1 | Watch upstream for `lite-v*` / Windows desktop assets |
| H2 | Until then: `fabric\win` + cloud keys + optional WSL2 AppImage |
| H3 | `prepare.bat` / `start.bat` stay simple for non-developers |

---

### I — Quality / cleanup

| # | Task |
|---|------|
| I1 | Remove or clearly mark legacy paths (`goclaw/goclaw-linux`, duplicate RU-only entrypoints) |
| I2 | One canonical START path in README (EN first, RU section) |
| I3 | MVP checklist on real CachyOS + one OpenWrt device |
| I4 | Repo hygiene when user says «приберёмся» |

---

## Current recommended user path (Linux)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh              # AppImage; optional Fabric+model
cp -n .env.example .env      # XAI_API_KEY=...
bash start.sh
# In GoClaw: apply bootstrap/ text; provider Grok per docs/PROVIDERS.md
```

## Status snapshot

| Phase | Status |
|-------|--------|
| A–D | **Done** (shell + v1 procedures) |
| E | **Next** |
| F–I | Planned |

Lite packaging repo remains **finalized** for community AppImage use; main complexity now lives in **setup-my-pc** Phases E+.
