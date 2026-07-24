#!/usr/bin/env bash
# Update GoClaw Lite AppImage from GitHub Releases
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
chmod +x scripts/*.sh 2>/dev/null || true
# shellcheck source=scripts/lib-lang.sh
source scripts/lib-lang.sh
pick_lang

if [[ "$LANG_UI" == "ru" ]]; then
  echo "==> Обновление GoClaw Lite AppImage"
  PRESS="==> Нажми Enter для выхода"
else
  echo "==> Update GoClaw Lite AppImage"
  PRESS="==> Press Enter to exit"
fi
echo
bash scripts/update-goclaw.sh
echo
echo "$PRESS"
read -r _
