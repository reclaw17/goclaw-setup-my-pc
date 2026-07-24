# Offline documentation on the USB

All agent knowledge that must work **without internet** lives under the project folder on the stick.

## Layout

```text
docs/
  openwrt/          # hand notes — router
  cachyos-arch/     # hand notes — Linux PC
  windows11/        # hand notes — Windows
  adguard/
  amnezia/
  custom/           # drop your own .md here
  mirrors/
    goclaw/         # FULL upstream GoClaw markdown (fetch-offline-docs)
    …               # optional chip-docs-local mirrors
  FILELIST.md       # index after fetch
  PROVIDERS.md
  …
```

## Fetch / refresh (on a machine with internet, once)

```bash
bash scripts/fetch-offline-docs.sh     # GoClaw official docs → docs/mirrors/goclaw/
bash scripts/fetch-human20-skill.sh chip-docs-local   # tool for more mirrors
```

Then copy the whole project folder to the 32 GB USB (or run the same commands with the repo already on the stick).

## Agent rules

1. Prefer `docs/` + `docs/mirrors/` before any web search.  
2. GoClaw product behavior → `docs/mirrors/goclaw/`.  
3. Router/PC recipes → hand folders + skills.  
4. User extras → `docs/custom/`.

Online docs site (when online only): https://docs.goclaw.sh  
Upstream source mirrored: https://github.com/nextlevelbuilder/goclaw
