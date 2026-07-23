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
  [[ -f "$envf" ]] || touch "$envf"

  ensure_key() {
    local key="$1" size="$2"
    if ! grep -qE "^${key}=.+$" "$envf" 2>/dev/null; then
      # remove empty key lines
      if grep -qE "^${key}=" "$envf" 2>/dev/null; then
        grep -vE "^${key}=" "$envf" > "$envf.tmp" && mv "$envf.tmp" "$envf"
      fi
      echo "${key}=$(gen_hex "$size")" >> "$envf"
      log "Сгенерирован $key"
    fi
  }

  ensure_key GOCLAW_GATEWAY_TOKEN 16
  ensure_key GOCLAW_ENCRYPTION_KEY 32

  # local portable defaults (safe for USB single-user)
  if ! grep -qE '^GOCLAW_HOST=' "$envf" 2>/dev/null; then
    echo 'GOCLAW_HOST=127.0.0.1' >> "$envf"
  fi
}

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

[[ -f "$GOCLAW_BIN" ]] || err "Нет goclaw/goclaw-linux. Сначала: bash подготовить.sh"
chmod +x "$GOCLAW_BIN" 2>/dev/null || true
log "GoClaw найден"

mkdir -p "$ROOT/models"
if [[ ! -f "$MODEL_FILE" ]]; then
  log "Скачиваю локальную модель (~5.7 ГБ)..."
  command -v curl >/dev/null 2>&1 || err "Нужен curl"
  curl -L --fail --progress-bar -o "$MODEL_FILE.partial" "$MODEL_URL" || err "Не удалось скачать модель"
  mv "$MODEL_FILE.partial" "$MODEL_FILE"
fi
log "Проверяю модель..."
verify_sha256 "$MODEL_FILE" "$MODEL_SHA256"
log "Модель OK"

# secrets + local bind
ensure_env
set -a
# shellcheck disable=SC1091
source "$ROOT/.env"
set +a

# Force local-safe bind (override dangerous 0.0.0.0 if present)
export GOCLAW_HOST="${GOCLAW_HOST:-127.0.0.1}"
if [[ "$GOCLAW_HOST" == "0.0.0.0" ]]; then
  export GOCLAW_HOST="127.0.0.1"
  log "GOCLAW_HOST сменён на 127.0.0.1 (безопасный локальный режим)"
fi

if [[ -z "${GOCLAW_GATEWAY_TOKEN:-}" ]]; then
  # last-resort local only
  export GOCLAW_ALLOW_INSECURE_NO_AUTH=1
  log "Включён GOCLAW_ALLOW_INSECURE_NO_AUTH=1 (только локально)"
fi

ONLINE=0
if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1 || ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
  ONLINE=1
  log "Сеть: ONLINE"
else
  log "Сеть: OFFLINE"
fi

if [[ "$ONLINE" -eq 0 ]]; then
  [[ -f "$FABRIC_BIN" ]] || err "Нет fabric/fabric-linux для offline. Сначала: bash подготовить.sh"
  chmod +x "$FABRIC_BIN" 2>/dev/null || true
  log "Запускаю Fabric на ${FABRIC_HOST}:${FABRIC_PORT}..."
  ("$FABRIC_BIN" -m "$MODEL_FILE" --host "$FABRIC_HOST" --port "$FABRIC_PORT" \
    >"$ROOT/fabric/fabric.log" 2>&1) &
  FABRIC_PID=$!
  sleep 2
  if ! kill -0 "$FABRIC_PID" 2>/dev/null; then
    tail -n 40 "$ROOT/fabric/fabric.log" 2>/dev/null || true
    err "Fabric не запустился. Смотри fabric/fabric.log"
  fi
  log "Fabric PID: $FABRIC_PID"
  export GOCLAW_LOCAL_ENDPOINT="http://${FABRIC_HOST}:${FABRIC_PORT}/v1"
fi

export GOCLAW_ROOT="$ROOT"
export GOCLAW_DATA_DIR="${GOCLAW_DATA_DIR:-$ROOT/data}"
export GOCLAW_WORKSPACE="${GOCLAW_WORKSPACE:-$ROOT/workspace}"
export GOCLAW_CONFIG="${GOCLAW_CONFIG:-$ROOT/config/goclaw.json}"
mkdir -p "$GOCLAW_DATA_DIR" "$GOCLAW_WORKSPACE"

if [[ -z "${GOCLAW_POSTGRES_DSN:-}" ]]; then
  echo
  log "Внимание: у GoClaw Standard нужен PostgreSQL"
  log "Сейчас GOCLAW_POSTGRES_DSN не задан в .env"
  log "Без базы следующий запуск, скорее всего, снова упадёт"
  log "См. файл DEBUG.md — раздел PostgreSQL"
  echo
fi

log "Запускаю GoClaw (host=$GOCLAW_HOST)..."
echo
cd "$ROOT"
set +e
"$GOCLAW_BIN"
status=$?
set -e
exit "$status"
