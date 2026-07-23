#!/usr/bin/env bash
# Re-launch a script inside a visible terminal (Cachy/KDE friendly)
set -euo pipefail

TARGET_SCRIPT="${1:-}"
if [[ -z "$TARGET_SCRIPT" ]]; then
  echo "Usage: run-in-terminal.sh /path/to/script.sh"
  exit 1
fi

TARGET_SCRIPT="$(readlink -f "$TARGET_SCRIPT" 2>/dev/null || realpath "$TARGET_SCRIPT" 2>/dev/null || echo "$TARGET_SCRIPT")"
DIR="$(cd "$(dirname "$TARGET_SCRIPT")" && pwd)"
BASE="$(basename "$TARGET_SCRIPT")"

CMD="export IN_TERMINAL=1; cd '$DIR'; bash '$TARGET_SCRIPT'; ec=\$?; echo; echo '==> Нажмите Enter для выхода'; read -r _; exit \$ec"

# Already in a normal terminal?
if [[ -n "${IN_TERMINAL:-}" || ( -t 0 && -t 1 ) ]]; then
  export IN_TERMINAL=1
  cd "$DIR"
  bash "$TARGET_SCRIPT"
  exit $?
fi

# Open a real terminal window
if command -v konsole >/dev/null 2>&1; then
  exec konsole --noclose -e bash -lc "$CMD"
elif command -v gnome-terminal >/dev/null 2>&1; then
  exec gnome-terminal -- bash -lc "$CMD"
elif command -v xfce4-terminal >/dev/null 2>&1; then
  exec xfce4-terminal -e "bash -lc '$CMD'"
elif command -v xterm >/dev/null 2>&1; then
  exec xterm -hold -e bash -lc "$CMD"
else
  # last resort
  export IN_TERMINAL=1
  cd "$DIR"
  bash "$TARGET_SCRIPT"
fi
