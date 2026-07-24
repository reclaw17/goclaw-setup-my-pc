#!/usr/bin/env bash
# Prepare USB agent — GoClaw AppImage + optional offline Fabric/model
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
  INTRO="1) GoClaw Lite AppImage → apps/   2) опционально Fabric + модель"
  SRC="AppImage: goclaw-lite-cachyos v0.2.0-cachyos"
  CONT="Продолжить? [Y/n]: "
  CANCEL="Отменено."
  STEP1="==> 1/3 AppImage"
  ASK_OFF="Скачать офлайн Fabric + модель (~несколько ГБ)? [y/N]: "
  STEP2="==> 2/3 Offline stack"
  SKIP_OFF="==> Офлайн-стек пропущен (позже: bash scripts/fetch-offline-stack.sh linux)"
  ENV_MSG="==> Создан .env — укажи XAI_API_KEY=..."
  READY="Готово"
  NEXT="Дальше:"
  NEXT1="  1) Отредактируй .env"
  NEXT2="  2) bash start.sh"
  PRESS="Нажми Enter..."
else
  TITLE="Prepare USB agent"
  INTRO="1) GoClaw Lite AppImage → apps/   2) optional Fabric + model"
  SRC="AppImage: goclaw-lite-cachyos v0.2.0-cachyos"
  CONT="Continue? [Y/n]: "
  CANCEL="Cancelled."
  STEP1="==> 1/3 AppImage"
  ASK_OFF="Download offline Fabric + model (several GB)? [y/N]: "
  STEP2="==> 2/3 Offline stack"
  SKIP_OFF="==> Offline stack skipped (later: bash scripts/fetch-offline-stack.sh linux)"
  ENV_MSG="==> Created .env — set XAI_API_KEY=..."
  READY="Ready"
  NEXT="Next:"
  NEXT1="  1) Edit .env"
  NEXT2="  2) bash start.sh"
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

FETCH_OFFLINE="${FETCH_OFFLINE:-}"
if [[ -z "$FETCH_OFFLINE" && -t 0 ]]; then
  read -r -p "$ASK_OFF" off_ans
  case "${off_ans,,}" in y|yes|д|да) FETCH_OFFLINE=1 ;; *) FETCH_OFFLINE=0 ;; esac
fi
FETCH_OFFLINE="${FETCH_OFFLINE:-0}"

if [[ "$FETCH_OFFLINE" == "1" ]]; then
  echo
  echo "$STEP2"
  bash scripts/fetch-offline-stack.sh linux
else
  echo "$SKIP_OFF"
fi

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
echo "Embed layout: docs/EMBED.md"
echo
if [[ -t 0 ]]; then
  read -r -p "$PRESS" _
fi
