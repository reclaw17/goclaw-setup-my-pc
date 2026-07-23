#!/usr/bin/env bash
# Re-launch a script inside a visible terminal (Cachy/KDE friendly)
# After script finishes (and its own Enter wait), the window must close.
set -euo pipefail

TARGET_SCRIPT="${1:-}"
if [[ -z "$TARGET_SCRIPT" ]]; then
  echo "Usage: run-in-terminal.sh /path/to/script.sh"
  exit 1
fi

TARGET_SCRIPT="$(readlink -f "$TARGET_SCRIPT" 2>/dev/null || realpath "$TARGET_SCRIPT" 2>/dev/null || echo "$TARGET_SCRIPT")"
DIR="$(cd "$(dirname "$TARGET_SCRIPT")" && pwd)"

# Script itself already waits for Enter at the end.
# Do NOT add a second read here, and do NOT use konsole --noclose.
CMD="export IN_TERMINAL=1; cd '$DIR'; bash '$TARGET_SCRIPT'; exit \$?"

# Already inside a normal terminal → just run, do not force-close user's terminal
if [[ -n "${IN_TERMINAL:-}" || ( -t 0 && -t 1 ) ]]; then
  export IN_TERMINAL=1
  cd "$DIR"
  bash "$TARGET_SCRIPT"
  exit $?
fi

# Open a temporary terminal window that closes when the script exits
if command -v konsole >/dev/null 2>&1; then
  exec konsole -e bash -lc "$CMD"
elif command -v gnome-terminal >/dev/null 2>&1; then
  exec gnome-terminal --wait -- bash -lc "$CMD"
elif command -v xfce4-terminal >/dev/null 2>&1; then
  exec xfce4-terminal -e "bash -lc '$CMD'"
elif command -v xterm >/dev/null 2>&1; then
  exec xterm -e bash -lc "$CMD"
else
  export IN_TERMINAL=1
  cd "$DIR"
  bash "$TARGET_SCRIPT"
  exit $?
fi
