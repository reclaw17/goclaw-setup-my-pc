# USB Flash Drive Structure

Production structure for the portable agent.

```
USB:/
│
├── goclaw/                     ← binaries (downloaded from release / fork on first run or by setup script)
│   ├── goclaw-linux
│   └── goclaw-windows.exe
│
├── fabric/                     ← Fabric binaries (from QVAC / fork)
│   ├── fabric-linux
│   └── fabric-windows.exe
│
├── models/                     ← empty by default
│   └── qwen3.5-9b-q4_k_m.gguf  ← auto-downloaded on first offline launch
│
├── docs/                       ← offline documentation
│   ├── openwrt/
│   ├── cachyos-arch/
│   ├── windows11/
│   ├── adguard/
│   ├── amnezia/
│   └── custom/
│
├── skills/
├── prompts/
│   ├── system-common.md
│   └── wrappers/
│
├── config/
├── launcher/
│   ├── start-linux.sh
│   ├── start-windows.bat
│   ├── bootstrap.md
│   └── FIRST-RUN.md
│
├── .env                        ← secrets (never in git)
├── .env.example
└── README.txt
```

## Key principles

1. **Binaries** are obtained via controlled downloads from official/forked releases (not stored in git).
2. **Model** is auto-downloaded on first launch when missing (QVAC-style).
3. Git repository stays light.
4. After first successful offline run the model stays on the USB for future use.
