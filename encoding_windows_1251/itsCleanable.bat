@echo off
set Version=1.0.6
title Очистка диска "itsCleanable | Version: %Version%

echo Через 7 секунд запуститься скрипт 'itsCleanable.bat / Version %Version% / Обновление от 06.05.2021' - очистки диска от временных и неиспользуемых файлов. Если не хотите этого делать, нажмите комбинацию 'ctrl + c'

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

mkdir C:\Logs\
fsutil volume diskfree C:\ > C:\Logs\log-volume-start-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
fsutil volume diskfree C:\


timeout 7 /nobreak


echo ===
echo ========== Остановка служб на момент работы скрипта ==========
echo ===

echo Остановка службы 'Центр обновления Windows'
timeout 2
net stop wuauserv


echo ===
echo ========== Очистка диска от временных файлов ==========
echo ===

echo ===
echo ========== Очистка в папке "C:\Windows" ==========
echo ===

echo Удаление временных файлов в директории 'C:\Windows\Logs\'
timeout 2
del "%WINDIR%\Logs\*" /s /f /q

echo ===
echo Удаление временных файлов в директории 'C:\Windows\Temp'
timeout 2
del "%WINDIR%\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Windows\SoftwareDistribution\Download\*'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Windows\assembly\NativeImages_*\temp\*'
timeout 2
del "%WINDIR%\assembly\NativeImages_v2.0.50727_32\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp\*" /s /f /q
del "%WINDIR%\assembly\temp\*" /s /f /q
del "%WINDIR%\assembly\tmp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Windows\SoftwareDistribution\Download\SharedFileCache'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\SharedFileCache\*" /s /f /q

echo ===
echo ========== Очистка в папках "AppData" ==========
echo ===

echo Удаление временных файлов по директории: '\AppData\Local\Temp\*'
timeout 2
del "%USERPROFILE%\AppData\Local\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Users\User\AppData\Local\Temp\*'
timeout 2
del "%SystemDrive%\Users\User\AppData\Local\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Users\Администратор\AppData\Local\Temp\*'
timeout 2
del "C:\Users\Администратор\AppData\Local\Temp\*" /s /f /q

echo ===
echo ========== Очистка в папке "ProgramData" ==========
echo ===

echo Удаление временных файлов по директории: 'C:\ProgramData\Microsoft\Diagnosis\*'
timeout 2
del "%SystemDrive%\ProgramData\Microsoft\Diagnosis\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Kaspersky Lab\KES\Temp\*'
timeout 2
del "%SystemDrive%\ProgramData\Kaspersky Lab\KES\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*'
timeout 2
del "%SystemDrive%\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Intel\Logs\*' и 'C:\ProgramData\Intel\Package Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Intel\Logs\*" /s /f /q
del "%SystemDrive%\ProgramData\Intel\Package Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Package Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Package Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Oracle\Java\installcache_x64\*'
timeout 2
del "%SystemDrive%\ProgramData\Oracle\Java\installcache_x64\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\LANDesk\Log\*'
timeout 2
del "%SystemDrive%\ProgramData\LANDesk\Log\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Intel\Logs\*'
timeout 2
del "%SystemDrive%\ProgramData\Intel\Logs\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\LANDesk\Temp\*'
timeout 2
del "%SystemDrive%\ProgramData\LANDesk\Temp\*" /s /f /q


echo ===
echo ========== Очистка в диске "C:\" ==========
echo ===
echo Удаление временных файлов по директории: 'C:\Intel\*'
timeout 2
del "%SystemDrive%\Intel\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\SWSetup\*'
timeout 2
del "%SystemDrive%\SWSetup\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\MSOCache\All Users\*'
timeout 2
del "%SystemDrive%\MSOCache\All Users\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\AMD'
timeout 2
del "%SystemDrive%\AMD\*" /s /f /q

echo ===
echo Открывает окно 'Очистка диска' и спрашивает, что хотите удалить. Следует проставить галочки.
timeout 2
%windir%\system32\cmd.exe /c "start cleanmgr /sageset:64541

echo ===
echo Необходимые галочки проставил? (Y/N)
choice /m "Необходимые галочки проставил?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo Вы отказались от очистки диска.
goto COMPLETE

:Y

timeout 2
echo Продолжаем производить очистку диска...
echo Подождите, работает команда cleanmgr.exe /SETUP
cleanmgr.exe /SETUP
echo Запускается cleanmgr...
%windir%\system32\cmd.exe /c "start cleanmgr /sagerun:64541

:COMPLETE

echo ===
echo ========== Запуск служб ==========
echo ===

echo Запуск службы 'Центр обновления Windows'
timeout 2
net start wuauserv



echo ===
echo Завершения работы...
echo itsCleanable Version: %Version%
echo Автор: Захаров Илья Алексеевич.
echo Новая версия github.com/itsmyfox в разделе 'itsCleanable'
echo Свои идеи Вы можете предложить в разделе 'pull requests'

echo ===
echo Ожидаем завершения очистки диска...
timeout 7

exit 