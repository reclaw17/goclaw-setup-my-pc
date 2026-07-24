#!/usr/bin/env bash
# Start USB agent (GoClaw Lite AppImage)
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
chmod +x scripts/*.sh launcher/*.sh 2>/dev/null || true
# shellcheck source=scripts/lib-lang.sh
source scripts/lib-lang.sh
pick_lang

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Запуск USB-агента"
  MISS="==> GoClaw не найден. Сначала: bash prepare.sh"
  ENV_C="==> Создан .env из .env.example — добавь ключи"
  RUN="==> Стартую..."
  OK="==> Готово"
  BAD="==> Код выхода"
  PRESS="==> Нажми Enter для выхода"
else
  echo "==> USB agent start"
  MISS="==> GoClaw not found. Run: bash prepare.sh"
  ENV_C="==> Created .env from .env.example — add API keys"
  RUN="==> Starting..."
  OK="==> Done"
  BAD="==> Exit code"
  PRESS="==> Press Enter to exit"
fi
echo

APP="apps/GoClaw-Lite-x86_64.AppImage"
if [[ ! -f "$APP" && ! -f goclaw/goclaw-linux ]]; then
  echo "$MISS"
  echo
  echo "$PRESS"
  read -r _
  exit 1
fi

if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
  echo "$ENV_C"
fi

chmod +x "$APP" goclaw/goclaw-linux fabric/fabric-linux 2>/dev/null || true

echo "$RUN"
echo
set +e
bash launcher/start-linux.sh
status=$?
set -e

echo
if [[ "$status" -eq 0 ]]; then
  echo "$OK"
else
  echo "$BAD $status"
fi
echo "$PRESS"
read -r _
exit "$status"
