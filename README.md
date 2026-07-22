# goclaw-setup-my-pc

Portable AI agent based on [GoClaw](https://github.com/nextlevelbuilder/goclaw) for setting up computers and OpenWrt routers from a USB flash drive.

## Target systems
- CachyOS / Arch Linux
- Windows 11
- OpenWrt routers

## Key features
- Hybrid models: cloud (Grok 4.5, Qwen 3.8, Minimax) as primary + local Fabric as offline fallback
- Local offline documentation base (OpenWrt, CachyOS, Windows 11, AdGuard, Amnezia, etc.)
- Cursor-style safety (explicit confirmation before dangerous actions)
- Bilingual interface (Russian / English)
- Runs from USB, secrets in `.env`

## Project status
Early development. Structure and system prompts are ready.

## Structure
```
.
├── prompts/           # System prompts (RU + EN)
├── skills/            # Agent skills (to be filled)
├── docs/              # Local offline documentation
├── config/            # Configuration examples
├── .env.example       # Secrets template
└── README.md
```

## License
MIT (planned)
