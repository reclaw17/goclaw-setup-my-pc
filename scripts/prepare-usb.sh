#!/usr/bin/env bash
set -euo pipefail

# prepare-usb.sh — create layout and optionally download pinned binaries/model
# Usage:
#   ./scripts/prepare-usb.sh [root_dir]
#   FETCH_BINARIES=1 ./scripts/prepare-usb.sh .
#   PREFETCH_MODEL=1 FETCH_BINARIES=1 ./scripts/prepare-usb.sh .

ROOT_DIR="${1:-.}"
ROOT_DIR="$(cd "$ROOT_DIR" && pwd)"
TMP_DIR="${TMPDIR:-/tmp}/goclaw-setup-bins"
mkdir -p "$TMP_DIR"

MODEL_URL="https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf"
MODEL_FILE="$ROOT_DIR/models/qwen3.5-9b-q4_k_m.gguf"
MODEL_SHA256="03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8"

GOCLAW_URL="https://github.com/nextlevelbuilder/goclaw/releases/download/v3.15.0-beta.177/goclaw-v3.15.0-beta.177-linux-amd64.tar.gz"
GOCLAW_SHA="cc9b317f72be755e1e2f6dab933cc66ed49fce47dad7cadcf05c9da214de1cfc"
FABRIC_LINUX_URL="https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/b7349/llama-b7349-bin-ubuntu-vulkan-x64.tar.gz"
FABRIC_LINUX_SHA="fb42fb4f4b3ae623ba606f7bbbaebe620be4966e04a95a30b0fb6f9b670ce12a"
FABRIC_WIN_URL="https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/b7349/llama-b7349-bin-win-vulkan-x64.zip"
FABRIC_WIN_SHA="eb52db3cee6937edbf727a1ecf9a2eb9204e0a13c14c7e4ba78c83815d81d0bc"

log() { echo "[prepare-usb] $*"; }
err() { echo "[prepare-usb:error] $*" >&2; exit 1; }

verify_sha256() {
  local file="$1" expected="$2" actual
  if command -v sha256sum >/dev/null 2>&1; then
    actual="$(sha256sum "$file" | awk '{print $1}')"
  elif command -v shasum >/dev/null 2>&1; then
    actual="$(shasum -a 256 "$file" | awk '{print $1}')"
  else
    err "sha256sum or shasum required"
  fi
  [[ "$actual" == "$expected" ]] || err "Checksum mismatch for $file\nexpected: $expected\nactual:   $actual"
}

download() {
  local url="$1" out="$2"
  command -v curl >/dev/null 2>&1 || err "curl required"
  curl -L --fail --progress-bar -o "$out" "$url"
}

log "Root: $ROOT_DIR"
for d in goclaw fabric models docs/openwrt docs/cachyos-arch docs/windows11 docs/adguard docs/amnezia docs/custom prompts/wrappers skills config launcher scripts; do
  mkdir -p "$ROOT_DIR/$d"
done
touch "$ROOT_DIR/docs/custom/.gitkeep"

if [[ "${FETCH_BINARIES:-0}" == "1" ]]; then
  log "Fetching pinned binaries..."

  # GoClaw Linux
  if [[ ! -x "$ROOT_DIR/goclaw/goclaw-linux" ]]; then
    download "$GOCLAW_URL" "$TMP_DIR/goclaw-linux.tar.gz"
    verify_sha256 "$TMP_DIR/goclaw-linux.tar.gz" "$GOCLAW_SHA"
    mkdir -p "$TMP_DIR/goclaw-extract"
    tar -xzf "$TMP_DIR/goclaw-linux.tar.gz" -C "$TMP_DIR/goclaw-extract"
    if [[ -f "$TMP_DIR/goclaw-extract/goclaw" ]]; then
      cp "$TMP_DIR/goclaw-extract/goclaw" "$ROOT_DIR/goclaw/goclaw-linux"
    else
      err "goclaw binary not found inside archive"
    fi
    chmod +x "$ROOT_DIR/goclaw/goclaw-linux"
    log "GoClaw Linux ready"
  else
    log "GoClaw Linux already present"
  fi

  # Fabric Linux (Vulkan)
  if [[ ! -x "$ROOT_DIR/fabric/fabric-linux" ]]; then
    download "$FABRIC_LINUX_URL" "$TMP_DIR/fabric-linux.tar.gz"
    verify_sha256 "$TMP_DIR/fabric-linux.tar.gz" "$FABRIC_LINUX_SHA"
    mkdir -p "$TMP_DIR/fabric-linux-extract"
    tar -xzf "$TMP_DIR/fabric-linux.tar.gz" -C "$TMP_DIR/fabric-linux-extract" || true
    # copy server + libs into fabric/
    cp "$TMP_DIR/fabric-linux-extract/llama-server" "$ROOT_DIR/fabric/fabric-linux"
    chmod +x "$ROOT_DIR/fabric/fabric-linux"
    cp "$TMP_DIR/fabric-linux-extract"/lib*.so* "$ROOT_DIR/fabric/" 2>/dev/null || true
    log "Fabric Linux ready"
  else
    log "Fabric Linux already present"
  fi

  # Fabric Windows (Vulkan)
  if [[ ! -f "$ROOT_DIR/fabric/fabric-windows.exe" ]]; then
    download "$FABRIC_WIN_URL" "$TMP_DIR/fabric-win.zip"
    verify_sha256 "$TMP_DIR/fabric-win.zip" "$FABRIC_WIN_SHA"
    mkdir -p "$TMP_DIR/fabric-win-extract"
    python3 - "$TMP_DIR/fabric-win.zip" "$TMP_DIR/fabric-win-extract" <<'PY'
import sys, zipfile
zipfile.ZipFile(sys.argv[1]).extractall(sys.argv[2])
PY
    cp "$TMP_DIR/fabric-win-extract/llama-server.exe" "$ROOT_DIR/fabric/fabric-windows.exe"
    cp "$TMP_DIR/fabric-win-extract"/*.dll "$ROOT_DIR/fabric/" 2>/dev/null || true
    log "Fabric Windows ready"
  else
    log "Fabric Windows already present"
  fi

  log "NOTE: official GoClaw Windows binary is not published yet"
else
  log "Skipping binary fetch (set FETCH_BINARIES=1 to download)"
fi

if [[ "${PREFETCH_MODEL:-0}" == "1" ]]; then
  if [[ -f "$MODEL_FILE" ]]; then
    verify_sha256 "$MODEL_FILE" "$MODEL_SHA256"
    log "Model OK"
  else
    download "$MODEL_URL" "$MODEL_FILE.partial"
    mv "$MODEL_FILE.partial" "$MODEL_FILE"
    verify_sha256 "$MODEL_FILE" "$MODEL_SHA256"
    log "Model downloaded and verified"
  fi
else
  log "Skipping model prefetch (set PREFETCH_MODEL=1 to download)"
fi

[[ -f "$ROOT_DIR/launcher/start-linux.sh" ]] && chmod +x "$ROOT_DIR/launcher/start-linux.sh" || true
[[ -f "$ROOT_DIR/scripts/prepare-usb.sh" ]] && chmod +x "$ROOT_DIR/scripts/prepare-usb.sh" || true

log "Done"
log "Linux binary path: $ROOT_DIR/goclaw/goclaw-linux"
log "Fabric Linux path: $ROOT_DIR/fabric/fabric-linux"
log "Fabric Windows path: $ROOT_DIR/fabric/fabric-windows.exe"
