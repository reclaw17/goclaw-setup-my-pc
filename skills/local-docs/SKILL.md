# local-docs

**Source:** Adapted from Human20 / [chip-docs-local](https://github.com/evgyur/chip-docs-local)  
**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose
Offline-first knowledge from the USB `docs/` tree. Highest priority before web search.

## Directory layout
```text
docs/
  openwrt/
  cachyos-arch/
  windows11/
  adguard/
  amnezia/
  custom/           ← user-added markdown
  FILELIST.md       ← optional index (see scripts/refresh-docs-index.sh)
```

## chip-docs-local pattern (optional advanced)
Upstream toolkit mirrors public doc sites into Markdown + `FILELIST.md` + `state.json`.  
For this product we keep **hand-maintained** notes under `docs/**` by default.  
Later you may sync larger mirrors with chip-docs-local into e.g. `docs/mirrors/<source>/` (gitignored if huge).

## Workflow
1. Pick folder from the question (router → openwrt, pacman → cachyos-arch, …).  
2. Read relevant `.md` files.  
3. Answer only from what is there.  
4. If missing: say so, then offer `web-search` if online.  
5. Encourage user drops in `docs/custom/` without special setup.  

## Strict rules
- Local > internet  
- Do not invent UCI/pacman/winget commands not supported by docs or known official practice  
- Keep answers short and actionable  

## Integration
Used by openwrt, pc-setup, network-vpn, amnezia-adguard, fabric-offline.
