@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ======================================
echo  Запуск агента
echo ======================================
echo.

if not exist .env (
  echo [!] Сначала запусти подготовку:
  echo     подготовить.bat
  pause
  exit /b 1
)

if exist launcher\start-windows.bat (
  call launcher\start-windows.bat
) else (
  echo [!] Не найден launcher\start-windows.bat
  echo     Проверь, что ты запускаешь файл из папки проекта.
  pause
  exit /b 1
)
