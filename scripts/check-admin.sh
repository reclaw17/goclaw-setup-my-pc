#!/usr/bin/env bash
# Simple privilege check for beginners
set -euo pipefail

if [[ "$(id -u)" -eq 0 ]]; then
  echo "ADMIN=yes"
  echo "MODE=root"
  echo "Сообщение: сейчас есть права администратора (root)."
  exit 0
fi

if command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
  echo "ADMIN=yes"
  echo "MODE=sudo-nopass"
  echo "Сообщение: sudo доступен без запроса пароля."
  exit 0
fi

if command -v sudo >/dev/null 2>&1; then
  echo "ADMIN=maybe"
  echo "MODE=sudo-password"
  echo "Сообщение: прав root нет, но sudo есть. Система может запросить пароль."
  exit 0
fi

echo "ADMIN=no"
echo "MODE=user"
echo "Сообщение: прав администратора сейчас нет."
exit 0
