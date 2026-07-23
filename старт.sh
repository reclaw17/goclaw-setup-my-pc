#!/usr/bin/env bash
# Простой запуск для новичка

echo "========================================"
echo "  Запуск портативного AI-агента"
echo "========================================"
echo

if [[ ! -f ".env" ]]; then
  echo "Внимание: файл .env не найден."
  echo "Скопируй .env.example в .env и вставь свои ключи (если нужны облачные модели)."
  echo
fi

echo "Запускаю агент..."
echo

if [[ -x "./launcher/start-linux.sh" ]]; then
  ./launcher/start-linux.sh
else
  bash ./launcher/start-linux.sh
fi
