#!/usr/bin/env bash
# Prepare USB agent — download GoClaw Lite AppImage
# Default language: English. Russian: choose 2 or LANG_UI=ru
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
LANG_UI="${LANG_UI:-en}"

if [[ -t 0 && -z "${LANG_UI_SET:-}" && "${SKIP_LANG_PROMPT:-}" != "1" ]]; then
  echo
  echo "======================================"
  echo " Language / Язык"
  echo "======================================"
  echo "  1) English   (default)"
  echo "  2) Русский"
  echo
  read -r -p "Choose / Выбери [1/2] (default 1): " lang_ans
  case "${lang_ans:-1}" in
    2|ru|RU|рус*) LANG_UI="ru" ;;
    *) LANG_UI="en" ;;
  esac
fi
export LANG_UI
export LANG_UI_SET=1

if [[ "$LANG_UI" == "ru" ]]; then
  TITLE="Подготовка агента (CachyOS / Arch)"
  INTRO="Скачаю GoClaw Lite AppImage в apps/"
  SRC="Источник: github.com/reclaw17/goclaw-lite-cachyos (v0.2.0-cachyos)"
  CONT="Продолжить? [Y/n]: "
  CANCEL="Отменено."
  STEP1="==> 1/2 Загрузка GoClaw Lite AppImage"
  ENV_MSG="==> Создан .env — пропиши ключи (XAI_API_KEY / и т.д.)"
  NEXT_TITLE="Дальше:"
  NEXT1="  1) Отредактируй .env — XAI_API_KEY=..."
  NEXT2="  2) bash start.sh"
  UPD="Обновить AppImage позже:"
  UPD1="  bash update.sh"
  UPD2="  или: ./apps/GoClaw-Lite-x86_64.AppImage --update"
  READY="Готово"
  PRESS="Нажми Enter..."
else
  TITLE="Prepare USB agent (CachyOS / Arch)"
  INTRO="This will download GoClaw Lite AppImage into apps/"
  SRC="Source: github.com/reclaw17/goclaw-lite-cachyos (v0.2.0-cachyos)"
  CONT="Continue? [Y/n]: "
  CANCEL="Cancelled."
  STEP1="==> 1/2 Fetch GoClaw Lite AppImage"
  ENV_MSG="==> Created .env — edit and put API keys (XAI_API_KEY / etc.)"
  NEXT_TITLE="Next:"
  NEXT1="  1) Edit .env — add XAI_API_KEY=... (or other cloud keys)"
  NEXT2="  2) bash start.sh"
  UPD="Update AppImage later:"
  UPD1="  bash update.sh"
  UPD2="  or: ./apps/GoClaw-Lite-x86_64.AppImage --update"
  READY="Ready"
  PRESS="Press Enter to exit..."
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

chmod +x scripts/*.sh 2>/dev/null || true
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
echo "$NEXT_TITLE"
echo "$NEXT1"
echo "$NEXT2"
echo
echo "$UPD"
echo "$UPD1"
echo "$UPD2"
echo
if [[ -t 0 ]]; then
  read -r -p "$PRESS" _
fi
