#!/usr/bin/env bash
# Простая подготовка агента для новичка
set -euo pipefail

cd "$(dirname "$0")"
ROOT="$(pwd)"

echo "======================================"
echo " Подготовка агента"
echo "======================================"
echo "Папка: $ROOT"
echo ""

# --- folders ---
mkdir -p models goclaw fabric docs/custom docs/openwrt docs/cachyos-arch docs/windows11 docs/adguard docs/amnezia

# --- .env ---
if [[ ! -f .env ]]; then
  if [[ -f .env.example ]]; then
    cp .env.example .env
    echo "[ok] Создан файл .env"
    echo "     Открой его и вставь API-ключи, если нужен online-режим."
  else
    echo "[!] Нет .env.example — создай .env вручную"
  fi
else
  echo "[ok] Файл .env уже есть"
fi

echo ""

# --- check internet ---
ONLINE=0
if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1 || ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
  ONLINE=1
  echo "[ok] Интернет есть"
else
  echo "[!] Интернета нет — скачать программы сейчас не получится"
fi

echo ""

ask_yes_no() {
  local prompt="$1"
  local answer
  while true; do
    read -r -p "$prompt [да/нет]: " answer
    case "${answer,,}" in
      да|д|yes|y) return 0 ;;
      нет|н|no|n) return 1 ;;
      *) echo "  Напиши: да или нет" ;;
    esac
  done
}

# --- download binaries ---
if [[ "$ONLINE" -eq 1 ]]; then
  if ask_yes_no "Скачать программы (goclaw + Fabric)?"; then
    echo ""
    echo "Скачиваю программы..."
    echo "Это может занять несколько минут."
    echo ""
    FETCH_BINARIES=1 bash scripts/prepare-usb.sh "$ROOT"
  else
    echo "[info] Программы не скачаны."
    echo "       Без них агент не запустится полностью."
  fi

  echo ""

  if ask_yes_no "Скачать локальную модель сейчас (~5.7 ГБ)?"; then
    echo ""
    echo "Скачиваю модель... Пожалуйста, подожди."
    echo ""
    PREFETCH_MODEL=1 bash scripts/prepare-usb.sh "$ROOT"
  else
    echo "[info] Модель можно скачать позже при первом запуске."
  fi
else
  echo "[info] Когда появится интернет, снова запусти:"
  echo "       bash подготовить.sh"
fi

echo ""
echo "======================================"
echo " Готово"
echo "======================================"
echo "Дальше запускай:"
echo "  bash старт.sh"
echo ""
echo "Нажми Enter, чтобы закрыть окно..."
read -r _
