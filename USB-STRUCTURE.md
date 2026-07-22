# USB Flash Drive Structure

```
USB:/
│
├── goclaw/                     ← binary from fork / pinned release
│   ├── goclaw-linux
│   └── goclaw-windows.exe
│
├── fabric/                     ← binary from fork / pinned release
│   ├── fabric-linux
│   └── fabric-windows.exe
│
├── models/                     ← empty at first; auto-download on first run
│   └── qwen3.5-9b-q4_k_m.gguf  ← appears after first launch
│
├── docs/                       ← offline documentation
│   ├── openwrt/
│   ├── cachyos-arch/
│   ├── windows11/
│   ├── adguard/
│   ├── amnezia/
│   └── custom/
│
├── skills/                     ← agent skills
├── prompts/                    ← system-common + model wrappers
├── config/
├── launcher/
│   ├── start-linux.sh
│   └── start-windows.bat
│
├── .env                        ← secrets (local only, never in git)
├── .env.example
└── README.txt
```

## Key principles

1. **Binaries** come from fork / pinned GitHub Releases (not committed as large blobs if avoidable).
2. **Model** is auto-downloaded on first run (QVAC-style).
3. **Secrets** stay only in `.env`.
4. **docs/custom/** is writable by the user.

## First run

See `FIRST-RUN.md`.
