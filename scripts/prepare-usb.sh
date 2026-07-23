#!/usr/bin/env bash
set -euo pipefail

# prepare-usb.sh — layout + optional download of pinned binaries/model
# Usage:
#   bash scripts/prepare-usb.sh [root_dir]
#   FETCH_BINARIES=1 bash scripts/prepare-usb.sh .
#   PREFETCH_MODEL=1 bash scripts/prepare-usb.sh .

ROOT_DIR="${1:-.}"
ROOT_DIR="$(cd "$ROOT_DIR" && pwd)"
TMP_DIR="${TMPDIR:-/tmp}/goclaw-setup-bins-$$"
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

log()  { echo "[prepare] $*"; }
ok()   { echo "[ok] $*"; }
warn() { echo "[!] $*"; }
err()  { echo "[ошибка] $*" >&2; exit 1; }

cleanup() { rm -rf "$TMP_DIR" 2>/dev/null || true; }
trap cleanup EXIT

verify_sha256() {
  local file="$1" expected="$2" actual
  if command -v sha256sum >/dev/null 2>&1; then
    actual="$(sha256sum "$file" | awk '{print $1}')"
  elif command -v shasum >/dev/null 2>&1; then
    actual="$(shasum -a 256 "$file" | awk '{print $1}')"
  else
    err "Нужна утилита sha256sum или shasum"
  fi
  if [[ "$actual" != "$expected" ]]; then
    err "Контрольная сумма не совпала для $file
ожидалось: $expected
получено:  $actual"
  fi
  ok "Проверка SHA256 пройдена"
}

download() {
  local url="$1" out="$2" label="${3:-файл}"
  command -v curl >/dev/null 2>&1 || err "Нужен curl"
  log "Скачиваю: $label"
  log "URL: $url"
  # --progress-bar показывает прогресс в консоли
  if ! curl -L --fail --progress-bar --retry 3 --retry-delay 2 -o "$out" "$url"; then
    rm -f "$out" 2>/dev/null || true
    err "Не удалось скачать: $label"
  fi
  ok "Скачано: $label"
}

find_first() {
  # find first matching file under a directory
  local dir="$1" name="$2"
  find "$dir" -type f -name "$name" 2>/dev/null | head -n 1
}

log "Корневая папка: $ROOT_DIR"

for d in goclaw fabric models docs/openwrt docs/cachyos-arch docs/windows11 docs/adguard docs/amnezia docs/custom prompts/wrappers skills config launcher scripts; do
  mkdir -p "$ROOT_DIR/$d"
done

if [[ "${FETCH_BINARIES:-0}" == "1" ]]; then
  log "Режим: скачивание программ"

  # GoClaw Linux
  if [[ -x "$ROOT_DIR/goclaw/goclaw-linux" ]]; then
    ok "GoClaw Linux уже есть"
  else
    download "$GOCLAW_URL" "$TMP_DIR/goclaw-linux.tar.gz" "GoClaw Linux"
    verify_sha256 "$TMP_DIR/goclaw-linux.tar.gz" "$GOCLAW_SHA"
    mkdir -p "$TMP_DIR/goclaw-extract"
    tar -xzf "$TMP_DIR/goclaw-linux.tar.gz" -C "$TMP_DIR/goclaw-extract"
    local_bin="$(find_first "$TMP_DIR/goclaw-extract" "goclaw")"
    [[ -n "$local_bin" ]] || err "В архиве GoClaw не найден файл goclaw"
    cp "$local_bin" "$ROOT_DIR/goclaw/goclaw-linux"
    chmod +x "$ROOT_DIR/goclaw/goclaw-linux"
    ok "GoClaw Linux установлен → goclaw/goclaw-linux"
  fi

  # Fabric Linux
  if [[ -x "$ROOT_DIR/fabric/fabric-linux" ]]; then
    ok "Fabric Linux уже есть"
  else
    download "$FABRIC_LINUX_URL" "$TMP_DIR/fabric-linux.tar.gz" "Fabric Linux"
    verify_sha256 "$TMP_DIR/fabric-linux.tar.gz" "$FABRIC_LINUX_SHA"
    mkdir -p "$TMP_DIR/fabric-linux-extract"
    tar -xzf "$TMP_DIR/fabric-linux.tar.gz" -C "$TMP_DIR/fabric-linux-extract"
    local_bin="$(find_first "$TMP_DIR/fabric-linux-extract" "llama-server")"
    [[ -n "$local_bin" ]] || err "В архиве Fabric не найден llama-server"
    cp "$local_bin" "$ROOT_DIR/fabric/fabric-linux"
    chmod +x "$ROOT_DIR/fabric/fabric-linux"
    # copy shared libs next to binary if present
    find "$TMP_DIR/fabric-linux-extract" -type f -name 'lib*.so*' -exec cp {} "$ROOT_DIR/fabric/" \; 2>/dev/null || true
    ok "Fabric Linux установлен → fabric/fabric-linux"
  fi

  # Fabric Windows
  if [[ -f "$ROOT_DIR/fabric/fabric-windows.exe" ]]; then
    ok "Fabric Windows уже есть"
  else
    download "$FABRIC_WIN_URL" "$TMP_DIR/fabric-win.zip" "Fabric Windows"
    verify_sha256 "$TMP_DIR/fabric-win.zip" "$FABRIC_WIN_SHA"
    mkdir -p "$TMP_DIR/fabric-win-extract"
    if command -v unzip >/dev/null 2>&1; then
      unzip -q "$TMP_DIR/fabric-win.zip" -d "$TMP_DIR/fabric-win-extract"
    else
      python3 - "$TMP_DIR/fabric-win.zip" "$TMP_DIR/fabric-win-extract" <<'PY'
import sys, zipfile
zipfile.ZipFile(sys.argv[1]).extractall(sys.argv[2])
PY
    fi
    local_bin="$(find_first "$TMP_DIR/fabric-win-extract" "llama-server.exe")"
    [[ -n "$local_bin" ]] || err "В архиве Fabric Windows не найден llama-server.exe"
    cp "$local_bin" "$ROOT_DIR/fabric/fabric-windows.exe"
    find "$TMP_DIR/fabric-win-extract" -type f -name '*.dll' -exec cp {} "$ROOT_DIR/fabric/" \; 2>/dev/null || true
    ok "Fabric Windows установлен → fabric/fabric-windows.exe"
  fi

  warn "Официального Windows-бинарника GoClaw пока нет"
else
  log "Программы не скачивались (интерактивный режим решает это в подготовить.sh)"
fi

if [[ "${PREFETCH_MODEL:-0}" == "1" ]]; then
  log "Режим: скачивание модели"
  mkdir -p "$ROOT_DIR/models"
  if [[ -f "$MODEL_FILE" ]]; then
    log "Модель уже есть, проверяю SHA256..."
    verify_sha256 "$MODEL_FILE" "$MODEL_SHA256"
    ok "Модель в порядке"
  else
    download "$MODEL_URL" "$MODEL_FILE.partial" "Локальная модель (~5.7 ГБ)"
    verify_sha256 "$MODEL_FILE.partial" "$MODEL_SHA256"
    mv "$MODEL_FILE.partial" "$MODEL_FILE"
    ok "Модель сохранена → models/qwen3.5-9b-q4_k_m.gguf"
  fi
fi

[[ -f "$ROOT_DIR/launcher/start-linux.sh" ]] && chmod +x "$ROOT_DIR/launcher/start-linux.sh" || true
[[ -f "$ROOT_DIR/scripts/prepare-usb.sh" ]] && chmod +x "$ROOT_DIR/scripts/prepare-usb.sh" || true
[[ -f "$ROOT_DIR/подготовить.sh" ]] && chmod +x "$ROOT_DIR/подготовить.sh" || true
[[ -f "$ROOT_DIR/старт.sh" ]] && chmod +x "$ROOT_DIR/старт.sh" || true
[[ -f "$ROOT_DIR/обновить.sh" ]] && chmod +x "$ROOT_DIR/обновить.sh" || true

echo ""
ok "Готово"
if [[ -f "$ROOT_DIR/goclaw/goclaw-linux" ]]; then
  echo "  GoClaw:  $ROOT_DIR/goclaw/goclaw-linux"
fi
if [[ -f "$ROOT_DIR/fabric/fabric-linux" ]]; then
  echo "  Fabric:  $ROOT_DIR/fabric/fabric-linux"
fi
if [[ -f "$MODEL_FILE" ]]; then
  echo "  Модель:  $MODEL_FILE"
fi
