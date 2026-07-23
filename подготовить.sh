#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${IN_TERMINAL:-}" && ( ! -t 0 || ! -t 1 ) ]]; then
  SELF="$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")"
  DIR="$(cd "$(dirname "$SELF")" && pwd)"
  if [[ -f "$DIR/scripts/run-in-terminal.sh" ]]; then
    chmod +x "$DIR/scripts/run-in-terminal.sh" 2>/dev/null || true
    exec bash "$DIR/scripts/run-in-terminal.sh" "$SELF"
  fi
fi

cd "$(cd "$(dirname "$0")" && pwd)"
ROOT="$(pwd)"
export IN_TERMINAL=1

echo "==> Подготовка помощника"
echo "==> Папка: $ROOT"
echo

mkdir -p models goclaw fabric docs/custom docs/openwrt docs/cachyos-arch docs/windows11 docs/adguard docs/amnezia

if [[ ! -f .env ]]; then
  if [[ -f .env.example ]]; then
    cp .env.example .env
    echo "==> Создан файл .env"
    echo "    Для online-режима открой .env и вставь ключи"
  else
    echo "==> Нет .env.example"
  fi
else
  echo "==> Файл .env уже есть"
fi

echo
ONLINE=0
if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1 || ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
  ONLINE=1
  echo "==> Интернет есть"
else
  echo "==> Интернета нет — скачать программы сейчас не получится"
fi
echo

ask_yes_no() {
  local prompt="$1" answer
  while true; do
    read -r -p "==> $prompt [да/нет]: " answer
    case "${answer,,}" in
      да|д|yes|y) return 0 ;;
      нет|н|no|n) return 1 ;;
      *) echo "    Напиши: да или нет" ;;
    esac
  done
}

if [[ "$ONLINE" -eq 1 ]]; then
  if ask_yes_no "Скачать программы (goclaw + Fabric)?"; then
    echo
    echo "==> Скачиваю программы..."
    echo "==> Это может занять несколько минут"
    echo
    chmod +x scripts/prepare-usb.sh scripts/run-in-terminal.sh 2>/dev/null || true
    FETCH_BINARIES=1 bash scripts/prepare-usb.sh "$ROOT"
  else
    echo "==> Программы не скачаны"
  fi

  echo
  if ask_yes_no "Скачать локальную модель сейчас (~5.7 ГБ)?"; then
    echo
    echo "==> Скачиваю модель..."
    echo
    PREFETCH_MODEL=1 bash scripts/prepare-usb.sh "$ROOT"
  else
    echo "==> Модель можно скачать позже при первом запуске"
  fi
else
  echo "==> Когда появится интернет, снова запусти подготовить.sh"
fi

echo
echo "==> Готово"
echo "==> Дальше запусти: bash старт.sh"
echo
echo "==> Нажмите Enter для выхода"
read -r _
exit 0
