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

echo "==> Обновление помощника"
echo
echo "1) файлы проекта"
echo "2) программы (goclaw + Fabric)"
echo "3) всё вместе"
echo "0) выйти"
echo
read -r -p "==> Выбери пункт [0-3]: " choice
echo

ask() {
  read -r -p "==> $1 [да/нет]: " a
  case "${a,,}" in да|д|yes|y) return 0 ;; *) return 1 ;; esac
}

case "${choice}" in
  1)
    if [[ -d .git ]] && command -v git >/dev/null 2>&1; then
      if ask "Обновить файлы через git?"; then
        git pull --ff-only && echo "==> Файлы обновлены" || echo "==> Не удалось обновить"
      fi
    else
      echo "==> Это не git-копия"
      echo "==> Скачай новую версию с GitHub и скопируй поверх"
      echo "==> Не затирай: .env  models/  docs/custom/"
    fi
    ;;
  2)
    if ask "Скачать/обновить программы?"; then
      FETCH_BINARIES=1 bash scripts/prepare-usb.sh .
      echo "==> Программы обновлены"
    fi
    ;;
  3)
    if [[ -d .git ]] && command -v git >/dev/null 2>&1; then
      if ask "Обновить файлы через git?"; then
        git pull --ff-only || true
      fi
    fi
    if ask "Скачать/обновить программы?"; then
      FETCH_BINARIES=1 bash scripts/prepare-usb.sh .
    fi
    echo "==> Готово"
    ;;
  0|"")
    echo "==> Выход"
    ;;
  *)
    echo "==> Неизвестный пункт"
    ;;
esac

echo
echo "==> Нажмите Enter для выхода"
read -r _
exit 0
