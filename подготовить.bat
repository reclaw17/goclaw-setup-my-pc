@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ======================================
echo  Подготовка агента
echo ======================================
echo.

if not exist models mkdir models
if not exist goclaw mkdir goclaw
if not exist fabric mkdir fabric
if not exist docs\custom mkdir docs\custom

if not exist .env (
  if exist .env.example (
    copy .env.example .env >nul
    echo [ok] Создан файл .env
    echo      Открой его и вставь свои API-ключи (если хочешь online-режим).
  ) else (
    echo [!] Нет файла .env.example
  )
) else (
  echo [ok] Файл .env уже есть
)

echo.
echo [info] Локальная модель при первом запуске скачается сама (~5.7 ГБ).
echo.
echo Готово. Дальше запускай:
echo   старт.bat
echo.
pause
