@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorlevel%==0 (
  echo ADMIN=yes
  echo MODE=administrator
  echo Сообщение: сейчас есть права администратора.
  exit /b 0
) else (
  echo ADMIN=no
  echo MODE=user
  echo Сообщение: прав администратора сейчас нет.
  exit /b 0
)
