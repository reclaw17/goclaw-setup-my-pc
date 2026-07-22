# USB Flash Drive Structure

Структура флешки / USB structure for the portable agent.

```
USB:/
│
├── goclaw/                     ← сам агент (бинарники + UI)
│   ├── goclaw-linux
│   ├── goclaw-windows.exe
│   └── ...
│
├── fabric/                     ← локальный движок моделей (offline)
│   ├── fabric-linux
│   ├── fabric-windows.exe
│   └── ...
│
├── models/                     ← локальные модели (GGUF)
│   └── qwen3.5-9b.gguf         ← или другая подходящая модель (~8 GB VRAM)
│
├── docs/                       ← локальная offline-документация
│   ├── openwrt/
│   ├── cachyos-arch/
│   ├── windows11/
│   ├── adguard/
│   ├── amnezia/
│   └── custom/                 ← пользовательские документы
│
├── skills/                     ← навыки агента
│   ├── local-docs/
│   ├── safety-confirm/
│   ├── openwrt/
│   ├── network-vpn/
│   ├── coding-quality/
│   ├── model-router/
│   ├── backup/
│   └── ...
│
├── config/                     ← настройки
│   ├── settings.json
│   └── ...
│
├── launcher/                   ← скрипты запуска
│   ├── start-linux.sh
│   ├── start-windows.bat
│   └── ...
│
├── .env                        ← секреты (НЕ коммитить!)
├── .env.example
│
└── README.txt                  ← короткая инструкция
```

## How it works

1. Insert the USB drive
2. Run the appropriate launcher (`start-linux.sh` or `start-windows.bat`)
3. The agent checks for internet
4. Online → cloud models
5. Offline → starts Fabric + local model from the USB
6. Always asks for confirmation before system-changing actions
