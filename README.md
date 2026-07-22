# goclaw-setup-my-pc

**Portable AI agent** based on [GoClaw](https://github.com/nextlevelbuilder/goclaw) for setting up computers and OpenWrt routers from a USB flash drive.

Портативный AI-агент на базе [GoClaw](https://github.com/nextlevelbuilder/goclaw) для настройки компьютеров и OpenWrt-роутеров с флешки.

---

## Target systems / Целевые системы

- **CachyOS / Arch Linux**
- **Windows 11**
- **OpenWrt routers**

---

## Key features / Основные возможности

| Feature | Описание |
|---------|----------|
| **Hybrid models** | Cloud models (Grok 4.5, Qwen 3.8, Minimax) as primary + local Fabric as offline fallback |
| **Offline docs** | Local documentation base (OpenWrt, CachyOS, Windows 11, AdGuard, Amnezia + custom) |
| **Safety** | Cursor-style confirmations before any dangerous action |
| **Bilingual** | Russian and English interface |
| **Portable** | Runs from USB, secrets stored in `.env` |
| **OpenWrt** | Backup → update → configure Wi-Fi / VPN / DNS |

---

## How it works / Как это работает

1. Insert USB and launch the agent
2. Agent checks internet connection
3. **Online** → uses powerful cloud models
4. **Offline** → automatically starts Fabric + local model from USB
5. First looks for answers in local documentation
6. Before any system/router change — asks for confirmation

---

## Project structure / Структура проекта

```
goclaw-setup-my-pc/
├── prompts/
│   ├── system-ru.md      # System prompt (Russian)
│   └── system-en.md      # System prompt (English)
├── skills/               # Agent skills (in progress)
├── docs/                 # Local offline documentation
│   ├── openwrt/
│   ├── cachyos-arch/
│   ├── windows11/
│   ├── adguard/
│   ├── amnezia/
│   └── custom/           # User-added docs
├── config/               # Configuration examples
├── .env.example          # Secrets template
└── README.md
```

---

## Current status / Текущий статус

- [x] Project repository created
- [x] System prompts (RU + EN)
- [x] Basic folder structure
- [ ] Skills implementation
- [ ] USB launcher
- [ ] Fabric offline integration
- [ ] Local docs population

---

## Roadmap (high level)

1. Finalize system prompts & safety rules
2. Implement core skills (docs, search, backup, network, OpenWrt)
3. USB structure + launcher scripts (Linux + Windows)
4. Fabric offline inference integration
5. First working MVP for personal use
6. Public release (without secrets)

---

## License

MIT (planned)
