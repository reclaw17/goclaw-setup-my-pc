#!/usr/bin/env bash
# Download Fabric / llama.cpp Vulkan binaries (Linux + optional Windows zip)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p fabric

# Pinned QVAC Fabric release (llama.cpp-compatible server tools)
FABRIC_TAG="${FABRIC_TAG:-b7349}"
FABRIC_LINUX_URL="${FABRIC_LINUX_URL:-https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/${FABRIC_TAG}/llama-${FABRIC_TAG}-bin-ubuntu-vulkan-x64.tar.gz}"
FABRIC_LINUX_SHA="${FABRIC_LINUX_SHA:-fb42fb4f4b3ae623ba606f7bbbaebe620be4966e04a95a30b0fb6f9b670ce12a}"
FABRIC_WIN_URL="${FABRIC_WIN_URL:-https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/${FABRIC_TAG}/llama-${FABRIC_TAG}-bin-win-vulkan-x64.zip}"
FABRIC_WIN_SHA="${FABRIC_WIN_SHA:-eb52db3cee6937edbf727a1ecf9a2eb9204e0a13c14c7e4ba78c83815d81d0bc}"

log() { echo "==> $*"; }
err() { echo "==> ERROR: $*" >&2; exit 1; }

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then shasum -a 256 "$1" | awk '{print $1}'
  else err "need sha256sum or shasum"; fi
}

install_linux() {
  local marker="fabric/.fabric-linux-${FABRIC_TAG}"
  if [[ -x fabric/llama-server || -x fabric/fabric-linux ]] && [[ -f "$marker" ]]; then
    log "Linux Fabric tools already present ($FABRIC_TAG)"
    return 0
  fi
  log "Downloading Fabric Linux Vulkan ($FABRIC_TAG)"
  local tmp tdir
  tmp="$(mktemp)"
  tdir="$(mktemp -d)"
  curl -fL --progress-bar -o "$tmp" "$FABRIC_LINUX_URL" || { rm -f "$tmp"; err "linux download failed"; }
  got="$(sha256_of "$tmp")"
  [[ "$got" == "$FABRIC_LINUX_SHA" ]] || { rm -f "$tmp"; err "linux SHA mismatch"; }
  tar -xzf "$tmp" -C "$tdir"
  # Prefer llama-server if present
  find "$tdir" -type f -name 'llama-server' -executable | head -1 | while read -r f; do cp -f "$f" fabric/llama-server; chmod +x fabric/llama-server; done
  find "$tdir" -type f \( -name 'llama-*' -o -name 'fabric*' \) -executable 2>/dev/null | while read -r f; do
    base="$(basename "$f")"
    cp -f "$f" "fabric/$base"
    chmod +x "fabric/$base"
  done
  if [[ -x fabric/llama-server ]]; then
    ln -sfn llama-server fabric/fabric-linux
  fi
  echo "$FABRIC_TAG" > "$marker"
  rm -rf "$tmp" "$tdir"
  log "Linux Fabric ready under fabric/"
  ls -la fabric/ | head -20
}

install_windows_zip() {
  # Optional: store Windows zip tools on a Linux USB for dual-boot sticks
  if [[ "${FETCH_WIN_FABRIC:-0}" != "1" ]]; then
    return 0
  fi
  local marker="fabric/.fabric-win-${FABRIC_TAG}"
  [[ -f "$marker" ]] && { log "Windows Fabric zip already fetched"; return 0; }
  log "Downloading Fabric Windows Vulkan zip"
  local tmp
  tmp="$(mktemp)"
  curl -fL --progress-bar -o "$tmp" "$FABRIC_WIN_URL" || { rm -f "$tmp"; err "win download failed"; }
  got="$(sha256_of "$tmp")"
  [[ "$got" == "$FABRIC_WIN_SHA" ]] || { rm -f "$tmp"; err "win SHA mismatch"; }
  mkdir -p fabric/win
  if command -v unzip >/dev/null 2>&1; then unzip -qo "$tmp" -d fabric/win
  else log "unzip missing — left archive as fabric/win-fabric.zip"; mv -f "$tmp" fabric/win-fabric.zip; echo "$FABRIC_TAG" > "$marker"; return 0; fi
  rm -f "$tmp"
  echo "$FABRIC_TAG" > "$marker"
  log "Windows Fabric extracted to fabric/win/"
}

install_linux
install_windows_zip
log "Done. Start server example:"
echo "  ./fabric/llama-server -m models/qwen3.5-9b-q4_k_m.gguf --port 8080 --host 127.0.0.1"
