# Phase D — complete checklist

**Status: DONE** (2026-07-24)

Phase D = content + fetch tooling for the USB agent (before native GoClaw skill loader = Phase E).

## Done

| Item | Location |
|------|----------|
| Procedure skills | `skills/*/SKILL.md` + INDEX |
| Full Human20 shortlist fetch | `scripts/fetch-human20-skill.sh`, `fetch-skills-shortlist.sh` |
| Fabric + model + SHA256 | `scripts/fetch-fabric.sh`, `fetch-model.sh`, `fetch-offline-stack.sh` |
| Offline docs + **GoClaw mirror** | `scripts/fetch-offline-docs.sh` → `docs/mirrors/goclaw/` |
| Hand notes | `docs/openwrt`, `cachyos-arch`, `windows11`, `adguard`, `amnezia` |
| `.env` on USB (models + Perplexity) | `.env.example`, `docs/SECRETS.md` |
| AppImage fetch (Linux answer to upstream) | `scripts/fetch-goclaw-appimage.sh` |
| Win11 honest path | `docs/windows11`, `scripts/fetch-goclaw-windows.md` |
| Embed layout | `docs/EMBED.md` |
| prepare fills 1–4 | `prepare.sh` |

## Not Phase D (Phase E+)

- Auto-inject `bootstrap/` into running GoClaw Lite workspace  
- Native GoClaw YAML skill loader  
- Hardware QA on live router/PC (Phase I)

## One-command fill (32 GB)

```bash
FETCH_OFFLINE=1 FETCH_DOCS=1 FETCH_SKILLS=1 bash prepare.sh
# edit .env on the stick
bash start.sh
```
