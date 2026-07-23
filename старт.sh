#!/usr/bin/env bash
# Простой запуск агента для новичка
set -euo pipefail

cd "$(dirname "$0")"
ROOT="$(pwd)"

echo "======================================"
echo " Запуск агента"
echo "======================================"
echo "Папка: $ROOT"
echo ""

if [[ ! -f .env ]]; then
  echo "[!] Сначала выполни подготовку:"
  echo "    bash подготовить.sh"
  exit 1
fi

# internet
if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
  echo "[ok] Интернет: есть → можно использовать облачные модели"
else
  echo "[info] Интернет: нет → нужен offline-режим"
fi

# binaries
if [[ -x goclaw/goclaw-linux || -f goclaw/goclaw-linux ]]; then
  echo "[ok] GoClaw найден"
else
  echo "[!] GoClaw не найден"
  echo "    Запусти: bash подготовить.sh"
  echo "    и согласись скачать программы"
fi

if [[ -x fabric/fabric-linux || -f fabric/fabric-linux ]]; then
  echo "[ok] Fabric найден"
else
  echo "[!] Fabric не найден"
  echo "    Запусти: bash подготовить.sh"
  echo "    и согласись скачать программы"
fi

# model
if [[ -f models/qwen3.5-9b-q4_k_m.gguf ]]; then
  echo "[ok] Локальная модель найдена"
else
  echo "[info] Локальная модель пока отсутствует"
  echo "       При offline-запуске её нужно будет скачать"
fi

echo ""

if [[ -f launcher/start-linux.sh ]]; then
  bash launcher/start-linux.sh
else
  echo "[!] Не найден launcher/start-linux.sh"
  exit 1
fi
