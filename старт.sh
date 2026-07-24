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

echo "==> USB agent start"
echo

APP="apps/GoClaw-Lite-x86_64.AppImage"
if [[ ! -f "$APP" && ! -f goclaw/goclaw-linux ]]; then
  echo "==> GoClaw not found. Run prepare first:"
  echo "    bash подготовить.sh"
  echo "    or: bash scripts/fetch-goclaw-appimage.sh"
  echo
  echo "==> Press Enter to exit"
  read -r _
  exit 1
fi

if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
  echo "==> Created .env from .env.example — add your API keys"
fi

chmod +x "$APP" goclaw/goclaw-linux fabric/fabric-linux launcher/start-linux.sh scripts/*.sh 2>/dev/null || true

echo "==> Starting..."
echo
set +e
bash launcher/start-linux.sh
status=$?
set -e

echo
if [[ "$status" -eq 0 ]]; then
  echo "==> Done"
else
  echo "==> Exit code $status"
fi
echo "==> Press Enter to exit"
read -r _
exit "$status"
