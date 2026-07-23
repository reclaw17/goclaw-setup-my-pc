@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0.."
set "ROOT=%cd%"

echo ==============================================
echo  goclaw-setup-my-pc
echo  Portable AI Agent — Windows
echo ==============================================
echo Папка: %ROOT%
echo.

if not exist "%ROOT%\goclaw\goclaw-windows.exe" (
  echo ==^> Ошибка: нет goclaw\goclaw-windows.exe
  echo ==^> Официальный Windows-бинарник GoClaw пока может отсутствовать.
  echo ==^> На Linux путь уже рабочий.
  pause
  exit /b 1
)

if not exist "%ROOT%\models\qwen3.5-9b-q4_k_m.gguf" (
  echo ==^> Локальной модели нет. Скачаю при первом offline-запуске через подготовить.
)

if exist "%ROOT%\.env" (
  for /f "usebackq tokens=* delims=" %%A in ("%ROOT%\.env") do (
    echo %%A | findstr /r "^[A-Za-z0-9_]*=" >nul && set "%%A"
  )
)

echo ==^> Запускаю GoClaw...
echo.
"%ROOT%\goclaw\goclaw-windows.exe"
if errorlevel 1 (
  echo ==^> GoClaw завершился с ошибкой
  pause
  exit /b 1
)

endlocal
