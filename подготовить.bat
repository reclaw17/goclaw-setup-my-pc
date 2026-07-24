@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

echo ======================================
echo  Prepare agent (Windows 11)
echo ======================================
echo Folder: %CD%
echo.

if not exist apps mkdir apps
if not exist models mkdir models
if not exist goclaw mkdir goclaw
if not exist fabric mkdir fabric
if not exist fabric\win mkdir fabric\win
if not exist docs\custom mkdir docs\custom
if not exist config mkdir config

if not exist .env (
  if exist .env.example (
    copy .env.example .env >nul
    echo [ok] Created .env — set XAI_API_KEY for cloud mode
  ) else (
    echo [!] Missing .env.example
  )
) else (
  echo [ok] .env exists
)

echo.
echo [info] Linux GUI engine: apps\GoClaw-Lite-x86_64.AppImage
echo        (download on Linux: bash prepare.sh — or copy AppImage onto the USB)
echo.
echo [info] Windows offline LLM: place Fabric/llama build under fabric\win\
echo        and model as models\qwen3.5-9b-q4_k_m.gguf
echo        On a Linux PC you can prepare the USB with:
echo          bash scripts/fetch-fabric.sh windows
echo          bash scripts/fetch-model.sh
echo.
echo [info] See docs\EMBED.md and docs\windows11\README.md
echo.
echo Next: edit .env then run  start.bat  or  start.bat
echo.
pause
