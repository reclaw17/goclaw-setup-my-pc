#!/usr/bin/env bash
# Простое обновление для новичка: проверка → вопрос → действие
set -euo pipefail

cd "$(cd "$(dirname "$0")" && pwd)"

echo
echo "======================================"
echo " Обновление помощника"
echo "======================================"
echo
echo "Что можно обновить:"
echo "  1) файлы проекта (скрипты, skills, prompts)"
echo "  2) программы (goclaw + Fabric)"
echo "  3) всё вместе"
echo "  0) ничего, выйти"
echo
read -r -p "Выбери пункт [0-3]: " choice
echo

ask_yes() {
  local q="$1"
  read -r -p "$q [да/нет]: " ans
  case "${ans,,}" in
    да|д|yes|y) return 0 ;;
    *) return 1 ;;
  esac
}

update_project() {
  echo "[обновление] Файлы проекта..."
  if [[ -d .git ]] && command -v git >/dev/null 2>&1; then
    echo "Найден git. Буду обновлять через git pull."
    if ask_yes "Обновить файлы проекта сейчас?"; then
      git pull --ff-only || {
        echo "[!] Не удалось обновить через git."
        echo "    Можно скачать проект заново с GitHub."
        return 1
      }
      echo "[ok] Файлы проекта обновлены"
    else
      echo "Пропущено"
    fi
  else
    echo "Это не git-копия (или git не установлен)."
    echo "Самый простой способ:"
    echo "  1) скачать новую версию с GitHub"
    echo "  2) скопировать поверх, НЕ затирая:"
    echo "     - .env"
    echo "     - models/"
    echo "     - docs/custom/"
    echo
    echo "Ссылка: https://github.com/reclaw17/goclaw-setup-my-pc"
  fi
}

update_binaries() {
  echo "[обновление] Программы (goclaw + Fabric)..."
  if [[ ! -f scripts/prepare-usb.sh ]]; then
    echo "[!] Не найден scripts/prepare-usb.sh"
    return 1
  fi
  if ask_yes "Скачать/обновить программы сейчас? Нужен интернет"; then
    chmod +x scripts/prepare-usb.sh 2>/dev/null || true
    # force re-fetch by removing markers if user confirmed
    FETCH_BINARIES=1 PREFETCH_MODEL=0 bash scripts/prepare-usb.sh .
    echo "[ok] Программы обновлены (по pinned-версиям из SOURCES.md)"
  else
    echo "Пропущено"
  fi
}

case "${choice}" in
  1)
    update_project
    ;;
  2)
    update_binaries
    ;;
  3)
    update_project
    echo
    update_binaries
    ;;
  0|"")
    echo "Выход без изменений"
    exit 0
    ;;
  *)
    echo "Неизвестный пункт"
    exit 1
    ;;
esac

echo
echo "======================================"
echo " Готово"
echo "======================================"
echo
echo "Важно:"
echo "- файл .env не трогался"
echo "- локальная модель сама не обновлялась"
echo "- запуск: bash старт.sh"
echo
