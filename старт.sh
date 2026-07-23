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
export IN_TERMINAL=1

echo "==> Запуск помощника"
echo

if [[ ! -f goclaw/goclaw-linux ]]; then
  echo "==> Сначала нужна подготовка"
  echo "==> Запусти: bash подготовить.sh"
  echo
  echo "==> Нажмите Enter для выхода"
  read -r _
  exit 1
fi

if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
fi

chmod +x goclaw/goclaw-linux fabric/fabric-linux launcher/start-linux.sh scripts/run-in-terminal.sh 2>/dev/null || true

echo "==> Стартую..."
echo
set +e
bash launcher/start-linux.sh
status=$?
set -e

echo
if [[ "$status" -eq 0 ]]; then
  echo "==> Завершено"
else
  echo "==> Завершено с ошибкой (код $status)"
fi
echo "==> Нажмите Enter для выхода"
read -r _
exit "$status"
