# Plan: embed GoClaw Lite into main USB agent project

Saved: 2026-07-24  
Status: agreed after Lite packaging finalized (**v0.2.0-cachyos**)

## Repos

| Repo | Role |
|------|------|
| https://github.com/reclaw17/goclaw-lite-cachyos | **Done** — portable AppImage (Arch/CachyOS) |
| https://github.com/reclaw17/goclaw-setup-my-pc | **Main** — USB agent: scripts, skills, docs, Fabric, OpenWrt |

Do **not** commit the ~120MB AppImage. Fetch from Lite Releases.

## Order (do not reverse)

1. **Wrap Lite** — USB structure + start/update + env presets  
2. **Then** skills / OpenWrt / offline docs / Fabric / Win11  

## Phase A — USB layout (first)

```text
USB/
  apps/GoClaw-Lite-x86_64.AppImage
  config/.env.example
  config/providers.example.json
  scripts/start.sh
  scripts/update-goclaw.sh
  skills/
  docs/
  models/
  README.txt
```

## Phase B — provider presets

- **Grok (xAI)** — primary online  
- **Qwen / OpenRouter** — cloud backup  
- **Local Fabric** — `http://127.0.0.1:8080/v1` offline fallback  
- Secrets only in `config/.env` (never commit real keys)

## Phase C — this repo wiring

- Script or docs: download Latest AppImage from  
  `goclaw-lite-cachyos` Releases (`v0.2.0-cachyos`+)
- `scripts/start.sh` launches `apps/GoClaw-Lite-x86_64.AppImage`

## Phase D — big agent features (later)

1. Skills (human20mcp / custom): OpenWrt, CachyOS, network, VPN  
2. Offline docs (chip-docs-local)  
3. Fabric + Qwen3.5-9B class (8GB VRAM / 16GB RAM)  
4. Windows 11 layer without breaking Linux path  

## Next concrete step

Add tree + `start.sh` + `.env.example` + short README:  
“Download AppImage v0.2.0 from lite repo → put in `apps/` → run `scripts/start.sh`.”
