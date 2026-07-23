#!/usr/bin/env bash
# Простой запуск для новичка
set -euo pipefail

cd "$(dirname "$0")"

echo "======================================"
echo " Запуск агента"
echo "======================================"
echo ""

if [[ ! -f .env ]]; then
  echo "[!] Сначала запусти подготовку:"
  echo "    bash подготовить.sh"
  exit 1
fi

if [[ -x launcher/start-linux.sh ]]; then
  bash launcher/start-linux.sh
elif [[ -f launcher/start-linux.sh ]]; then
  bash launcher/start-linux.sh
else
  echo "[!] Не найден launcher/start-linux.sh"
  echo "    Проверь, что ты запускаешь скрипт из папки проекта."
  exit 1
fi
