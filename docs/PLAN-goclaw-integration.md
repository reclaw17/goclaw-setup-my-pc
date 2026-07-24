# Plan: embed GoClaw Lite into main USB agent project

Saved: 2026-07-24  
Status: Phase A started in this repo (AppImage as primary engine)

## Repos

| Repo | Role |
|------|------|
| https://github.com/reclaw17/goclaw-lite-cachyos | AppImage factory (done, **v0.2.0-cachyos**) |
| https://github.com/reclaw17/goclaw-setup-my-pc | Main USB agent |

## Order

1. Wrap Lite (USB tree + start/update + env) — **Phase A in progress**  
2. Then skills / OpenWrt / docs / Fabric / Win11  

## Phases

- **A** — `apps/` AppImage, fetch/update scripts, launcher prefers Lite  
- **B** — provider presets (Grok / Qwen / local Fabric)  
- **C** — polish fetch + docs only (no 120MB binary in git)  
- **D** — skills, offline docs, Fabric model, Win11  

## Repo language rules

See **[REPO-RULES.md](REPO-RULES.md)** — English primary, Russian for beginners.
