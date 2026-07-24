# Plan: embed GoClaw Lite into main USB agent project

Updated: 2026-07-24

## Status

| Phase | State |
|-------|--------|
| A USB + AppImage | Done |
| B Providers | Done |
| C Fetch-only binary | Done |
| D Skills text/index | Done (slice) |
| D+ Fabric runtime + docs pack | Next |
| D+ Win11 parity | Later |

## Repos

- Packaging: https://github.com/reclaw17/goclaw-lite-cachyos  
- Agent: https://github.com/reclaw17/goclaw-setup-my-pc  

## First path

```bash
bash prepare.sh && cp -n .env.example .env
bash start.sh
```

Skills entrypoint: [../skills/INDEX.md](../skills/INDEX.md)
