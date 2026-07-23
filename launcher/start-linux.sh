#!/usr/bin/env bash
# Real Linux launcher for goclaw-setup-my-pc
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

GOCLAW_BIN="$ROOT/goclaw/goclaw-linux"
FABRIC_BIN="$ROOT/fabric/fabric-linux"
MODEL_FILE="$ROOT/models/qwen3.5-9b-q4_k_m.gguf"
MODEL_URL="https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf"
MODEL_SHA256="03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8"
FABRIC_HOST="127.0.0.1"
FABRIC_PORT="8080"
FABRIC_PID=""

log() { echo "==> $*"; }
err() { echo "==> Ошибка: $*" >&2; exit 1; }

cleanup() {
  if [[ -n "${FABRIC_PID}" ]] && kill -0 "$FABRIC_PID" 2>/dev/null; then
    log "Останавливаю Fabric (PID $FABRIC_PID)"
    kill "$FABRIC_PID" 2>/dev/null || true
    wait "$FABRIC_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

verify_sha256() {
  local file="$1" expected="$2" actual
  if command -v sha256sum >/dev/null 2>&1; then
    actual="$(sha256sum "$file" | awk '{print $1}')"
  else
    actual="$(shasum -a 256 "$file" | awk '{print $1}')"
  fi
  [[ "$actual" == "$expected" ]] || err "Контрольная сумма модели не совпала"
}

echo "=============================================="
echo " goclaw-setup-my-pc"
echo " Portable AI Agent — Linux"
echo "=============================================="
echo "Папка: $ROOT"
echo

# 1) goclaw binary
if [[ ! -f "$GOCLAW_BIN" ]]; then
  err "Нет файла goclaw/goclaw-linux. Сначала: bash подготовить.sh"
fi
chmod +x "$GOCLAW_BIN" 2>/dev/null || true
log "GoClaw найден"

# 2) model
mkdir -p "$ROOT/models"
if [[ ! -f "$MODEL_FILE" ]]; then
  log "Локальной модели нет. Скачиваю (~5.7 ГБ)..."
  command -v curl >/dev/null 2>&1 || err "Нужен curl"
  curl -L --fail --progress-bar -o "$MODEL_FILE.partial" "$MODEL_URL" \
    || err "Не удалось скачать модель"
  mv "$MODEL_FILE.partial" "$MODEL_FILE"
fi
log "Проверяю модель..."
verify_sha256 "$MODEL_FILE" "$MODEL_SHA256"
log "Модель OK"

# 3) online/offline
ONLINE=0
if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1 || ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
  ONLINE=1
  log "Режим: ONLINE (облачные модели)"
else
  log "Режим: OFFLINE (локальная модель)"
fi

# 4) offline → start Fabric
if [[ "$ONLINE" -eq 0 ]]; then
  if [[ ! -f "$FABRIC_BIN" ]]; then
    err "Нет fabric/fabric-linux для offline-режима. Сначала: bash подготовить.sh"
  fi
  chmod +x "$FABRIC_BIN" 2>/dev/null || true

  log "Запускаю Fabric на ${FABRIC_HOST}:${FABRIC_PORT}..."
  # llama-server compatible flags
  ("$FABRIC_BIN" -m "$MODEL_FILE" --host "$FABRIC_HOST" --port "$FABRIC_PORT" \
    >"$ROOT/fabric/fabric.log" 2>&1) &
  FABRIC_PID=$!
  sleep 2
  if ! kill -0 "$FABRIC_PID" 2>/dev/null; then
    echo "==> Лог Fabric:"
    tail -n 30 "$ROOT/fabric/fabric.log" 2>/dev/null || true
    err "Fabric не запустился. Смотри fabric/fabric.log"
  fi
  log "Fabric PID: $FABRIC_PID"
  log "Endpoint: http://${FABRIC_HOST}:${FABRIC_PORT}/v1"
  export GOCLAW_LOCAL_ENDPOINT="http://${FABRIC_HOST}:${FABRIC_PORT}/v1"
  export GOCLAW_MODE="offline"
  export GOCLAW_WRAPPER="$ROOT/prompts/wrappers/qwen-local.md"
else
  export GOCLAW_MODE="online"
  export GOCLAW_WRAPPER="$ROOT/prompts/wrappers/grok.md"
fi

# 5) common env for agent
export GOCLAW_ROOT="$ROOT"
export GOCLAW_PROMPTS="$ROOT/prompts"
export GOCLAW_SKILLS="$ROOT/skills"
export GOCLAW_DOCS="$ROOT/docs"
export GOCLAW_COMMON_PROMPT="$ROOT/prompts/system-common.md"
if [[ -f "$ROOT/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT/.env"
  set +a
fi

log "Запускаю GoClaw..."
echo
cd "$ROOT"

# Try common invocation styles; first successful path wins via exec
if "$GOCLAW_BIN" --help >/dev/null 2>&1; then
  exec "$GOCLAW_BIN"
elif "$GOCLAW_BIN" help >/dev/null 2>&1; then
  exec "$GOCLAW_BIN"
else
  # raw binary start
  exec "$GOCLAW_BIN"
fi
