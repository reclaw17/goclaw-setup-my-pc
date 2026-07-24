@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

echo ======================================
echo  Prepare USB agent (Windows 11)
echo ======================================
echo Folder: %CD%
echo.

if not exist models mkdir models
if not exist fabric mkdir fabric
if not exist fabric\win mkdir fabric\win
if not exist apps mkdir apps
if not exist docs\custom mkdir docs\custom

if not exist .env (
  if exist .env.example (
    copy .env.example .env >nul
    echo [ok] Created .env — add XAI_API_KEY for online mode
  )
) else (
  echo [ok] .env exists
)

echo.
echo [info] GoClaw GUI: production path is Linux AppImage
echo        (see scripts\fetch-goclaw-windows.md)
echo.
echo [info] Will try Fabric Windows Vulkan + local model download...
echo        Large download (~GB). Needs network once.
echo.

where curl >nul 2>&1
if errorlevel 1 (
  echo [!] curl not found. Install curl or download manually.
  echo     Model: see MODELS.md
  echo     Fabric: tetherto/qvac-fabric-llm.cpp release b7349 win vulkan zip
  goto end
)

REM --- Model ---
if exist models\qwen3.5-9b-q4_k_m.gguf (
  echo [ok] Model file present
) else (
  echo [..] Downloading model (long)...
  curl -L --fail --progress-bar -o models\qwen3.5-9b-q4_k_m.gguf.tmp "https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf"
  if errorlevel 1 (
    echo [!] Model download failed
    del models\qwen3.5-9b-q4_k_m.gguf.tmp 2>nul
  ) else (
    move /y models\qwen3.5-9b-q4_k_m.gguf.tmp models\qwen3.5-9b-q4_k_m.gguf >nul
    echo [ok] Model saved. Verify SHA256 when possible:
    echo      03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8
  )
)

REM --- Fabric Windows zip ---
if exist fabric\win\.done-b7349 (
  echo [ok] Fabric win marker present
) else (
  echo [..] Downloading Fabric Windows Vulkan b7349...
  curl -L --fail --progress-bar -o fabric\win-fabric.zip "https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/b7349/llama-b7349-bin-win-vulkan-x64.zip"
  if errorlevel 1 (
    echo [!] Fabric download failed
  ) else (
    echo [ok] Saved fabric\win-fabric.zip — unzip into fabric\win\
    echo      Then run llama-server from that folder on port 8080
    echo done> fabric\win\.done-b7349
  )
)

:end
echo.
echo Next:
echo   1) For full GoClaw GUI — boot Linux and run prepare.sh / start.sh
echo   2) On Windows local LLM — unzip Fabric, start server, use any OpenAI-compatible client
echo   3) Online keys — edit .env
echo.
pause
