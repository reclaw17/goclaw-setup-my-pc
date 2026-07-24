#!/usr/bin/env bash
# Prepare USB agent — download GoClaw Lite AppImage
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
  TITLE="Подготовка USB-агента"
  INTRO="Скачаю GoClaw Lite AppImage в apps/"
  SRC="Источник: github.com/reclaw17/goclaw-lite-cachyos (v0.2.0-cachyos)"
  CONT="Продолжить? [Y/n]: "
  CANCEL="Отменено."
  STEP1="==> 1/2 Загрузка AppImage"
  ENV_MSG="==> Создан .env — добавь API-ключи (XAI_API_KEY=...)"
  READY="Готово"
  NEXT="Дальше:"
  NEXT1="  1) Отредактируй .env"
  NEXT2="  2) bash start.sh"
  UPD="Обновление позже: bash update.sh"
  PRESS="Нажми Enter..."
else
  TITLE="Prepare USB agent"
  INTRO="Download GoClaw Lite AppImage into apps/"
  SRC="Source: github.com/reclaw17/goclaw-lite-cachyos (v0.2.0-cachyos)"
  CONT="Continue? [Y/n]: "
  CANCEL="Cancelled."
  STEP1="==> 1/2 Fetch AppImage"
  ENV_MSG="==> Created .env — add API keys (XAI_API_KEY=...)"
  READY="Ready"
  NEXT="Next:"
  NEXT1="  1) Edit .env"
  NEXT2="  2) bash start.sh"
  UPD="Update later: bash update.sh"
  PRESS="Press Enter..."
fi

echo
echo "======================================"
echo " $TITLE"
echo "======================================"
echo
echo "$INTRO"
echo "$SRC"
echo

if [[ -t 0 ]]; then
  read -r -p "$CONT" ans
  case "${ans,,}" in n|no|н|нет) echo "$CANCEL"; exit 0 ;; esac
fi

mkdir -p apps config models skills docs fabric goclaw

echo
echo "$STEP1"
bash scripts/fetch-goclaw-appimage.sh

if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
  echo "$ENV_MSG"
fi

echo
echo "======================================"
echo " $READY"
echo "======================================"
echo
echo "$NEXT"
echo "$NEXT1"
echo "$NEXT2"
echo
echo "$UPD"
echo
if [[ -t 0 ]]; then
  read -r -p "$PRESS" _
fi
