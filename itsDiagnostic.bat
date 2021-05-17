@echo off
set Version=1.0.9
set Dates=17.05.2021
title Диагностика и восстановление системных файлов "itsDiagnostic | Version: %Version% | Update %Dates%

echo Через 7 секунд запуститься скрипт 'itsDiagnostic.bat / Version %Version% / Обновление от 09.05.2021' Если не хотите этого делать, нажмите комбинацию 'ctrl + c'

echo ===
echo ========================= Сканирование системы =========================

echo ===
echo Обновление политиков.
timeout 2
gpupdate /force

msg * /TIME:10 "Начинаю производить диагностику и восстановление системных файлов Windows. Пожалуйста, подождите..."

echo ===
echo Чтобы исправить ошибки, автоматически скачать и заменить файлы повреждённых или отсутствующих компонентов эталонными версиями файлов из центра обновлений Windows.
timeout 2
DISM /Online /Cleanup-Image /RestoreHealth

echo ===
echo Сканирование системы на ошибки.
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
timeout 2
%windir%\system32\cmd.exe /c "start sfc /scannow

echo ===
echo Завершения работы...
echo itsCleanable 'Version: %Version% | Update %Dates%'
echo Автор: Захаров Илья Алексеевич.
echo Новая версия github.com/itsmyfox в разделе 'itsCleanable'
echo Свои идеи Вы можете предложить в разделе 'pull requests'
echo ===
echo Скрипт автоматически завершиться через 10 секунд и запишет результаты в лог фаил.
echo Если не хотите ждать, нажмите любую клавишу.
echo ===

timeout 10
