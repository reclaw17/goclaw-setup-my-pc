# STATUS

**Date:** 2026-07-24

## Capacity

USB kit **32 GB** — full offline stack + full useful Human20 skill clones **on the stick** are OK.  
Git remains without AppImage/GGUF/vendor. Policy: [docs/USB-CAPACITY.md](docs/USB-CAPACITY.md).

## Phases A–D — done

Shell, providers, fetch scripts, procedure pack.

## Skills policy

- **Procedure pack** in git (`skills/*/SKILL.md`) — always  
- **Full skills** on USB via `scripts/fetch-human20-skill.sh` — **encouraged** (32 GB)  

## Next (E)

Bootstrap + loader wiring + default vendor shortlist on stick.

## Run

```bash
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-human20-skill.sh chip-docs-local
bash start.sh
```
