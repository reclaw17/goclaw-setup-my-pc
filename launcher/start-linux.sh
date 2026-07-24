#!/usr/bin/env bash
# Linux launcher — prefers GoClaw Lite AppImage (portable)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

APPIMAGE="$ROOT/apps/GoClaw-Lite-x86_64.AppImage"
GOCLAW_BIN="$ROOT/goclaw/goclaw-linux"
FABRIC_BIN="$ROOT/fabric/fabric-linux"
MODEL_FILE="$ROOT/models/qwen3.5-9b-q4_k_m.gguf"
FABRIC_HOST="127.0.0.1"
FABRIC_PORT="8080"
FABRIC_PID=""

log() { echo "==> $*"; }
err() { echo "==> Error: $*" >&2; exit 1; }

cleanup() {
  if [[ -n "${FABRIC_PID}" ]] && kill -0 "$FABRIC_PID" 2>/dev/null; then
    log "Stopping Fabric (PID $FABRIC_PID)"
    kill "$FABRIC_PID" 2>/dev/null || true
    wait "$FABRIC_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

gen_hex() {
  local n="$1"
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -hex "$n"
  else
    head -c "$n" /dev/urandom | od -An -tx1 | tr -d ' \n'
  fi
}

ensure_env() {
  local envf="$ROOT/.env"
  [[ -f "$envf" ]] || { [[ -f "$ROOT/.env.example" ]] && cp "$ROOT/.env.example" "$envf" || touch "$envf"; }

  ensure_key() {
    local key="$1" size="$2"
    if ! grep -qE "^${key}=.+$" "$envf" 2>/dev/null; then
      if grep -qE "^${key}=" "$envf" 2>/dev/null; then
        grep -vE "^${key}=" "$envf" > "$envf.tmp" && mv "$envf.tmp" "$envf"
      fi
      echo "${key}=$(gen_hex "$size")" >> "$envf"
      log "Generated $key"
    fi
  }

  ensure_key GOCLAW_GATEWAY_TOKEN 16
  ensure_key GOCLAW_ENCRYPTION_KEY 32
  if ! grep -qE '^GOCLAW_HOST=' "$envf" 2>/dev/null; then
    echo 'GOCLAW_HOST=127.0.0.1' >> "$envf"
  fi
}

# Load .env into environment for child processes
load_env() {
  local envf="$ROOT/.env"
  [[ -f "$envf" ]] || return 0
  set -a
  # shellcheck disable=SC1090
  source "$envf"
  set +a
}

start_fabric_if_present() {
  if [[ ! -x "$FABRIC_BIN" ]]; then
    log "Fabric binary not found — skip local model sidecar"
    return 0
  fi
  if [[ ! -f "$MODEL_FILE" ]]; then
    log "Model not found — skip Fabric (run prepare to download)"
    return 0
  fi
  log "Starting Fabric on ${FABRIC_HOST}:${FABRIC_PORT}"
  # Best-effort; exact CLI depends on Fabric build
  "$FABRIC_BIN" 2>/dev/null &
  FABRIC_PID=$!
  sleep 1 || true
}

ensure_env
load_env
start_fabric_if_present

# Primary: AppImage
if [[ -x "$APPIMAGE" ]]; then
  log "Launching GoClaw Lite AppImage"
  log "  $APPIMAGE"
  cd "$ROOT"
  if "$APPIMAGE" --help-update >/dev/null 2>&1; then
    :
  fi
  exec "$APPIMAGE"
fi

# Fallback: old linux binary path
if [[ -x "$GOCLAW_BIN" ]]; then
  log "AppImage missing — fallback to goclaw/goclaw-linux"
  exec "$GOCLAW_BIN"
fi

err "No GoClaw runtime found.
Run:  bash scripts/fetch-goclaw-appimage.sh
Or:   bash подготовить.sh
Need: apps/GoClaw-Lite-x86_64.AppImage"
