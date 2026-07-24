#!/usr/bin/env bash
# Prepare USB agent (Phase D complete fill)
# 1) GoClaw Lite AppImage
# 2) optional Fabric + model
# 3) offline docs (incl. GoClaw mirror)
# 4) full skills shortlist → skills/vendor/
# 5) .env from example
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
  TITLE="Подготовка USB-агента (фаза D)"
  INTRO="AppImage → офлайн-стек → доки → полные скиллы (флешка ~32 ГБ)"
  SRC="AppImage: reclaw17/goclaw-lite-cachyos (Latest)"
  CONT="Продолжить? [Y/n]: "
  CANCEL="Отменено."
  S1="==> 1/4 AppImage"
  ASK_OFF="Скачать Fabric + модель (~несколько ГБ)? [Y/n]: "
  S2="==> 2/4 Offline stack"
  SKIP_OFF="==> Offline stack пропущен"
  ASK_DOCS="Скачать offline-доки (включая GoClaw)? [Y/n]: "
  S3="==> 3/4 Offline docs"
  SKIP_DOCS="==> Docs пропущены (позже: bash scripts/fetch-offline-docs.sh)"
  ASK_SK="Скачать полные Human20-скиллы shortlist? [Y/n]: "
  S4="==> 4/4 Skills vendor shortlist"
  SKIP_SK="==> Skills shortlist пропущен"
  ENV_MSG="==> Создан .env — ключи моделей + PERPLEXITY_API_KEY на флешке"
  READY="Фаза D: подготовка готова"
  NEXT="Дальше:"
  NEXT1="  1) Отредактируй .env (только на флешке)"
  NEXT2="  2) bash start.sh"
  PRESS="Нажми Enter..."
else
  TITLE="Prepare USB agent (Phase D)"
  INTRO="AppImage → offline stack → docs → full skills (USB ~32 GB)"
  SRC="AppImage: reclaw17/goclaw-lite-cachyos (Latest)"
  CONT="Continue? [Y/n]: "
  CANCEL="Cancelled."
  S1="==> 1/4 AppImage"
  ASK_OFF="Download Fabric + model (several GB)? [Y/n]: "
  S2="==> 2/4 Offline stack"
  SKIP_OFF="==> Offline stack skipped"
  ASK_DOCS="Download offline docs (including GoClaw)? [Y/n]: "
  S3="==> 3/4 Offline docs"
  SKIP_DOCS="==> Docs skipped (later: bash scripts/fetch-offline-docs.sh)"
  ASK_SK="Download full Human20 skill shortlist? [Y/n]: "
  S4="==> 4/4 Skills vendor shortlist"
  SKIP_SK="==> Skills shortlist skipped"
  ENV_MSG="==> Created .env — model keys + PERPLEXITY_API_KEY on the stick"
  READY="Phase D prepare complete"
  NEXT="Next:"
  NEXT1="  1) Edit .env (USB only)"
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

mkdir -p apps config models skills/vendor docs/mirrors docs/custom fabric goclaw bootstrap

echo
echo "$S1"
bash scripts/fetch-goclaw-appimage.sh

ask_default_yes() {
  local prompt="$1" var="$2"
  local cur="${!var:-}"
  if [[ -n "$cur" ]]; then return 0; fi
  if [[ -t 0 ]]; then
    read -r -p "$prompt" a
    case "${a,,}" in n|no|н|нет) printf -v "$var" '%s' "0" ;; *) printf -v "$var" '%s' "1" ;; esac
  else
    printf -v "$var" '%s' "1"
  fi
}

FETCH_OFFLINE="${FETCH_OFFLINE:-}"
FETCH_DOCS="${FETCH_DOCS:-}"
FETCH_SKILLS="${FETCH_SKILLS:-}"

ask_default_yes "$ASK_OFF" FETCH_OFFLINE
ask_default_yes "$ASK_DOCS" FETCH_DOCS
ask_default_yes "$ASK_SK" FETCH_SKILLS

if [[ "$FETCH_OFFLINE" == "1" ]]; then
  echo
  echo "$S2"
  bash scripts/fetch-offline-stack.sh linux
else
  echo "$SKIP_OFF"
fi

if [[ "$FETCH_DOCS" == "1" ]]; then
  echo
  echo "$S3"
  bash scripts/fetch-offline-docs.sh
else
  echo "$SKIP_DOCS"
fi

if [[ "$FETCH_SKILLS" == "1" ]]; then
  echo
  echo "$S4"
  bash scripts/fetch-skills-shortlist.sh
else
  echo "$SKIP_SK"
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
echo "Checklist: docs/PHASE-D.md"
echo
if [[ -t 0 ]]; then
  read -r -p "$PRESS" _
fi
