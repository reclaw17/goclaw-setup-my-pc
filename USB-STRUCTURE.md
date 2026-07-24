# USB structure (Phase A — GoClaw Lite AppImage)

```text
USB/  (or this repo cloned on a stick)
├── apps/
│   └── GoClaw-Lite-x86_64.AppImage   ← from goclaw-lite-cachyos Releases
├── config/
├── scripts/
│   ├── fetch-goclaw-appimage.sh
│   ├── update-goclaw.sh
│   └── ...
├── launcher/
│   └── start-linux.sh               ← prefers AppImage
├── skills/
├── docs/
├── models/                          ← later (Fabric offline)
├── fabric/                          ← later
├── .env.example
├── .env                             ← local secrets only
├── подготовить.sh
├── старт.sh
└── обновить.sh
```

## Principles

1. **Engine** = GoClaw **Lite** AppImage (SQLite, no PostgreSQL).
2. AppImage comes from https://github.com/reclaw17/goclaw-lite-cachyos/releases (Latest: **v0.2.0-cachyos**).
3. Do not commit the binary to git.
4. Secrets only in `.env`.
5. Skills / OpenWrt / Fabric = later phases.
