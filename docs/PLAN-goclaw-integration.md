# Plan: embed GoClaw Lite into main USB agent

Updated: 2026-07-24 — Phases A–D complete at repo level

## Repos

- **goclaw-lite-cachyos** — AppImage factory (v0.2.0-cachyos)
- **goclaw-setup-my-pc** — USB agent (this repo)

## Order (done)

1. Wrap Lite — structure + start/update + env  
2. Skills / OpenWrt docs / Fabric+model fetch / Win11 honest path  

## Platform truth

| OS | GoClaw GUI | Offline LLM |
|----|------------|-------------|
| Linux | AppImage **yes** | Fabric + GGUF **yes** |
| Windows 11 | No Lite AppImage yet | Fabric zip + GGUF **yes** |

## Secrets

Only `.env` (from `.env.example`). Never commit keys.
