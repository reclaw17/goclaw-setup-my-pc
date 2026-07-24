@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0.."
set "ROOT=%cd%"

echo ==============================================
echo  goclaw-setup-my-pc — Windows launcher
echo ==============================================
echo Folder: %ROOT%
echo.

if exist "%ROOT%\.env" (
  for /f "usebackq tokens=* delims=" %%A in ("%ROOT%\.env") do (
    echo %%A | findstr /r "^[A-Za-z0-9_]*=" >nul && set "%%A"
  )
)

if exist "%ROOT%\goclaw\goclaw-windows.exe" (
  echo ==^> Starting goclaw-windows.exe
  "%ROOT%\goclaw\goclaw-windows.exe"
  goto end
)

echo ==^> No goclaw-windows.exe (upstream Lite Windows AppImage is not available).
echo ==^> Full agent GUI: use Linux + apps\GoClaw-Lite-x86_64.AppImage
echo ==^> Docs: scripts\fetch-goclaw-windows.md
echo.
if exist "%ROOT%\fabric\win" (
  echo ==^> Fabric win folder exists — you can start llama-server manually on :8080
)
if exist "%ROOT%\models\qwen3.5-9b-q4_k_m.gguf" (
  echo ==^> Local model file is present under models\
)
echo.
echo ==^> Online: put XAI_API_KEY in .env and use cloud clients until Windows GUI exists.
echo.

:end
pause
