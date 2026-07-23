#!/usr/bin/env bash
# Простое обновление для новичка
# Ничего не меняет без твоего согласия

set -euo pipefail

echo "========================================"
echo "  Проверка обновлений"
echo "========================================"
echo
echo "Этот скрипт НЕ обновляет ничего сам."
echo "Сначала показывает, что можно обновить,"
echo "и только после твоего согласия продолжает."
echo

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "Что можно обновить:"
echo "  1) Файлы помощника (skills, prompts, скрипты)"
echo "  2) Программы goclaw и Fabric (если настроено)"
echo "  3) Локальную модель (только вручную, большой файл)"
echo
echo "Рекомендация: обновлять только когда есть интернет"
echo "и когда ты готов потратить немного времени."
echo

read -r -p "Проверить обновления файлов помощника с GitHub? (да/нет): " ANSWER
ANSWER="$(echo "$ANSWER" | tr '[:upper:]' '[:lower:]')"

if [[ "$ANSWER" != "да" && "$ANSWER" != "y" && "$ANSWER" != "yes" ]]; then
  echo
  echo "Ок, ничего не меняю."
  exit 0
fi

echo
echo "Проверяю..."

if ! command -v git >/dev/null 2>&1; then
  echo "На этом компьютере нет git."
  echo "Чтобы обновить файлы помощника, скачай новую версию с GitHub вручную"
  echo "и скопируй её на флешку."
  exit 1
fi

if [[ ! -d ".git" ]]; then
  echo "Эта папка не является git-репозиторием."
  echo "Самый простой способ обновиться:"
  echo "  1. Скачать свежую версию с GitHub"
  echo "  2. Скопировать новые файлы поверх старых"
  echo "  3. Не трогать файл .env и папку models"
  exit 0
fi

echo "Получаю информацию о новой версии..."
git fetch --quiet origin main 2>/dev/null || true

LOCAL=$(git rev-parse HEAD 2>/dev/null || echo "unknown")
REMOTE=$(git rev-parse origin/main 2>/dev/null || echo "unknown")

if [[ "$LOCAL" == "$REMOTE" ]]; then
  echo
  echo "Обновлений файлов помощника нет. У тебя актуальная версия."
  exit 0
fi

echo
echo "Есть новая версия."
echo "Локально:  $LOCAL"
echo "На GitHub: $REMOTE"
echo
read -r -p "Обновить файлы помощника сейчас? (да/нет): " CONFIRM
CONFIRM="$(echo "$CONFIRM" | tr '[:upper:]' '[:lower:]')"

if [[ "$CONFIRM" != "да" && "$CONFIRM" != "y" && "$CONFIRM" != "yes" ]]; then
  echo
  echo "Ок, обновление отменено."
  exit 0
fi

echo
echo "Обновляю файлы..."
# Сохраняем .env и models
git stash push -m "auto-stash-before-update" -- .env 2>/dev/null || true
git pull --ff-only origin main
echo
echo "Готово. Файлы помощника обновлены."
echo "Файл .env и папка models не должны были пострадать."
echo
echo "Теперь можно запускать: bash старт.sh"
