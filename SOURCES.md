# Sources — Binaries & Model

## 1. Local model (PINNED)

```text
MODEL_URL=https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf
MODEL_PATH=models/qwen3.5-9b-q4_k_m.gguf
MODEL_SHA256=03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8
MODEL_SIZE_GB=5.68
```

## 2. GoClaw (PINNED for Linux)

```text
GOCLAW_VERSION=v3.15.0-beta.177
GOCLAW_ARCHIVE_URL_LINUX=https://github.com/nextlevelbuilder/goclaw/releases/download/v3.15.0-beta.177/goclaw-v3.15.0-beta.177-linux-amd64.tar.gz
GOCLAW_ARCHIVE_SHA256_LINUX=cc9b317f72be755e1e2f6dab933cc66ed49fce47dad7cadcf05c9da214de1cfc
GOCLAW_BIN_LINUX=goclaw/goclaw-linux
```

Notes:
- Official recent releases currently ship **linux-amd64** archive only.
- Archive contains binary named `goclaw` (we rename/copy to `goclaw/goclaw-linux`).
- **Windows prebuilt asset is not available** in current official releases. For Windows you must build from source or wait for an official Windows asset.

## 3. Fabric / QVAC (PINNED)

```text
FABRIC_VERSION=b7349
FABRIC_ARCHIVE_URL_LINUX=https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/b7349/llama-b7349-bin-ubuntu-vulkan-x64.tar.gz
FABRIC_ARCHIVE_SHA256_LINUX=fb42fb4f4b3ae623ba606f7bbbaebe620be4966e04a95a30b0fb6f9b670ce12a
FABRIC_ARCHIVE_URL_WINDOWS=https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/b7349/llama-b7349-bin-win-vulkan-x64.zip
FABRIC_ARCHIVE_SHA256_WINDOWS=eb52db3cee6937edbf727a1ecf9a2eb9204e0a13c14c7e4ba78c83815d81d0bc
FABRIC_BIN_LINUX=fabric/fabric-linux
FABRIC_BIN_WINDOWS=fabric/fabric-windows.exe
```

Inside archives:
- Linux server binary: `llama-server` → copy as `fabric/fabric-linux`
- Windows server binary: `llama-server.exe` → copy as `fabric/fabric-windows.exe`
- Keep sibling `.so` / `.dll` libraries next to the binary (required at runtime)

## 4. Why binaries are not committed to git

They are large (tens of MB) and platform-specific.  
`prepare-usb.sh` downloads and verifies them automatically.

## 5. Safety rules

1. Download only from the pinned URLs above
2. Verify archive SHA256 before extract
3. On mismatch → stop
