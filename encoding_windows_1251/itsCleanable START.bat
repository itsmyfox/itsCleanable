@echo off
chcp 1251
set Version=1.0.6
title Очистка диска "itsCleanable | Version: %Version%

mkdir C:\Logs\

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "Запуск itsCleanable.bat" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

powershell "C:\itsCleanable.bat | Add-Content C:\Logs\log_itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "Создаю Лог фаил и помещаю его по директории 'C:\Logs\'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

fsutil volume diskfree C:\ > C:\Logs\log-volume-end-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
fsutil volume diskfree C:\
start C:\Logs

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "Запуск 'itsDiagnostic.bat'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1


powershell "C:\itsDiagnostic.bat | Add-Content C:\Logs\log_itsDiagnostic_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

echo ===
call :color5 "Скрипт отработан. Для завершения нажмите любую клавишу." Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

pause
exit

