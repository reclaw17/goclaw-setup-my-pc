#!/usr/bin/env bash
# Language picker — default English
# Usage: source scripts/lib-lang.sh && pick_lang

pick_lang() {
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
}
