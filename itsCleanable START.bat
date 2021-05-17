@echo off
chcp 866
set Version=1.0.9
set Dates=17.05.2021
title Очистка диска "itsCleanable | Version: %Version% | Update %Dates%

echo Копирование скриптов в диск C.
set drive=%~dp0
timeout 2
copy "%drive%\itsCleanable.bat" "C:\"
copy "%drive%\itsDiagnostic.bat" "C:\"
timeout 2

msg * /TIME:60 "Запуск программы itsCleanable 'Version: %Version% | Update %Dates%'. Очистка компьютера от ненужных временных файлов может занять от 2 до 15 минут. В ходе выполнения программы Вам необходимо проставить галочки. Пожалуйста, подождите..."

mkdir C:\LogsCache\
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
echo ===
call :color5 "Запуск itsCleanable.bat" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsCleanable.bat | Add-Content C:\LogsCache\log_itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "Создаю Лог фаил и помещаю его по директории 'C:\LogsCache\'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

chcp 1251
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-end-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

del "C:\itsCleanable.bat" /f /q

echo ===
call :color5 "Запуск 'itsDiagnostic.bat'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsDiagnostic.bat | Add-Content C:\LogsCache\log_itsDiagnostic_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

echo ===
call :color5 "Скрипт отработан. Для завершения нажмите любую клавишу." Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1


del "C:\itsDiagnostic.bat" /f /q
msg * /TIME:60 "Программа успешно завершена. Результаты очистки диска можно найти по следующему пути: 'C:\LogsCache'"
start C:\LogsCache

pause
exit

