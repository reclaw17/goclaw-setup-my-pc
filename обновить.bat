@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

echo.
echo ======================================
echo  Обновление помощника
echo ======================================
echo.
echo Что можно обновить:
echo   1) файлы проекта
echo   2) программы (Fabric и доступные бинарники)
echo   3) всё вместе
echo   0) ничего, выйти
echo.
set /p choice=Выбери пункт [0-3]: 
echo.

if "%choice%"=="0" goto end
if "%choice%"=="1" goto project
if "%choice%"=="2" goto bins
if "%choice%"=="3" goto all
echo Неизвестный пункт
goto end

:project
echo [обновление] Файлы проекта...
if exist .git (
  where git >nul 2>nul
  if %errorlevel%==0 (
    set /p ans=Обновить через git pull? [да/нет]: 
    if /i "%ans%"=="да" (
      git pull --ff-only
      if errorlevel 1 (
        echo [!] Не удалось обновить через git
      ) else (
        echo [ok] Файлы проекта обновлены
      )
    ) else (
      echo Пропущено
    )
  ) else (
    echo git не найден
  )
) else (
  echo Это не git-копия.
  echo Скачай новую версию с GitHub и скопируй поверх.
  echo НЕ затирай: .env , models\ , docs\custom\
  echo Ссылка: https://github.com/reclaw17/goclaw-setup-my-pc
)
goto after

:bins
echo [обновление] Программы...
set /p ans=Скачать/обновить программы сейчас? Нужен интернет [да/нет]: 
if /i not "%ans%"=="да" (
  echo Пропущено
  goto after
)
if exist scripts\prepare-usb.ps1 (
  powershell -NoProfile -ExecutionPolicy Bypass -File scripts\prepare-usb.ps1
  echo [ok] Программы обновлены
) else (
  echo [!] Не найден scripts\prepare-usb.ps1
)
goto after

:all
call :project
echo.
call :bins
goto after

:after
echo.
echo ======================================
echo  Готово
echo ======================================
echo.
echo Важно:
echo - файл .env не трогался
echo - локальная модель сама не обновлялась
echo - запуск: старт.bat
echo.

:end
pause
