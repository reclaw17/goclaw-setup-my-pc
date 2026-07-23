@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

echo ======================================
echo  Подготовка агента
echo ======================================
echo Папка: %CD%
echo.

if not exist models mkdir models
if not exist goclaw mkdir goclaw
if not exist fabric mkdir fabric
if not exist docs\custom mkdir docs\custom

if not exist .env (
  if exist .env.example (
    copy .env.example .env >nul
    echo [ok] Создан файл .env
    echo      Открой его и вставь API-ключи, если нужен online-режим.
  ) else (
    echo [!] Нет .env.example
  )
) else (
  echo [ok] Файл .env уже есть
)

echo.
echo [info] На Windows автоскачивание программ пока упрощено.
echo        Если бинарники уже лежат в папках goclaw\ и fabric\ — всё ок.
echo        Локальную модель можно скачать при первом запуске (~5.7 ГБ).
echo.
echo Готово. Дальше запускай:
echo   старт.bat
echo.
pause
