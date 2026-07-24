# Human20 archive → this project

Source dump: `human20mcp-20260722.zip` (Human20 MCP catalog, 2026-07-17, **235** skill cards).

**Important:** the archive stores **catalog cards** (summary, GitHub URL, tags), not full upstream `SKILL.md` bodies for most entries (`skillMdCount: 0` is common).  
Production procedures for *this* USB agent live in `skills/*/SKILL.md` here. Upstream repos are references.

## Shortlist used in the product

| Our skill | Human20 slug / idea | Upstream |
|-----------|---------------------|----------|
| local-docs | `chip-docs-local` | https://github.com/evgyur/chip-docs-local |
| backup | `backup-manager` | catalog card in archive |
| model-router | `auto-model-router` | archive card |
| safety-confirm | `clawguard` + `openclaw-safe-update` | https://github.com/jiangmuran/clawguard |
| coding-quality | `superpowers` + `workshop-shaw-coding-standard` | https://github.com/obra/superpowers |
| network-vpn | `tailscale-as-exit-node` + remote-access cards | archive |
| web-search | `workshop-perplex-search` | archive / workshop |
| (engine) | `goclaw` | https://github.com/nextlevelbuilder/goclaw |
| (windows notes) | `openclaw-windows-node` | archive card |
| (ops ref) | `server-doctor-public` | archive card |
| (docs tooling) | `getdocs-skill` | archive card |

## Explicitly custom (not a single archive skill)

- `openwrt` — full router workflow for this product  
- `pc-setup` — Arch/CachyOS + Windows 11  
- `amnezia-adguard` — AdGuard + Amnezia  
- `fabric-offline` — 8GB VRAM local path  
- `admin-check` — elevation gate  

## Rule

Do not copy 235 skills into the USB tree.  
Keep a **small production set**; link Human20/GitHub only as design sources.
