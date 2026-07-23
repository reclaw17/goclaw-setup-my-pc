#!/usr/bin/env bash
# Простая подготовка проекта для новичка
set -euo pipefail

cd "$(dirname "$0")"

echo "======================================"
echo " Подготовка агента"
echo "======================================"
echo ""

# Создаём нужные папки
mkdir -p models goclaw fabric docs/custom

# Создаём .env если его нет
if [[ ! -f .env ]]; then
  if [[ -f .env.example ]]; then
    cp .env.example .env
    echo "[ok] Создан файл .env"
    echo "     Открой его и вставь свои API-ключи (если хочешь online-режим)."
  else
    echo "[!] Нет файла .env.example"
  fi
else
  echo "[ok] Файл .env уже есть"
fi

echo ""
echo "[info] Если есть интернет, можно скачать программы автоматически:"
echo "       FETCH_BINARIES=1 bash scripts/prepare-usb.sh ."
echo ""
echo "[info] Локальная модель при первом запуске скачается сама (~5.7 ГБ)."
echo ""
echo "Готово. Дальше запускай:"
echo "  bash старт.sh"
echo ""
