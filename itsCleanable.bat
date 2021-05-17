@echo off
chcp 866
set Username=СИСТЕМА
set Version=1.0.9
set Dates=17.05.2021
title Очистка диска "itsCleanable | Version: %Version% | Update %Dates%

echo Через 7 секунд запуститься скрипт 'itsCleanable.bat / Version %Version% / Обновление от %Dates%' - очистки диска от временных и неиспользуемых файлов. Если не хотите этого делать, нажмите комбинацию 'ctrl + c'

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

chcp 1251
mkdir C:\LogsCache\
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-start-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\


timeout 7 /nobreak


echo ===
echo ========== Остановка служб на момент работы скрипта ==========
echo ===

echo Остановка службы 'Центр обновления Windows'
timeout 2
net stop wuauserv

echo ===
echo ========== Выдаю особые права на временные папки ==========
echo ===
timeout 2
TAKEOWN /f "%WINDIR%\Logs" /r /d y && ICACLS "%WINDIR%\Logs" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\logs" /r /d y && ICACLS "%SystemDrive%\logs" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\Temp" /r /d y && ICACLS "%WINDIR%\Temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\SoftwareDistribution\Download" /r /d y && ICACLS "%WINDIR%\SoftwareDistribution\Download" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp" /r /d y && ICACLS "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp" /r /d y && ICACLS "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp" /r /d y && ICACLS "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\temp" /r /d y && ICACLS "%WINDIR%\assembly\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\tmp" /r /d y && ICACLS "%WINDIR%\assembly\tmp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\SoftwareDistribution\Download\SharedFileCache" /r /d y && ICACLS "%WINDIR%\SoftwareDistribution\Download\SharedFileCache" /grant %Username%:F /t
TAKEOWN /f "%USERPROFILE%\AppData\Local\Temp" /r /d y && ICACLS "%USERPROFILE%\AppData\Local\Temp" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\Users\User\AppData\Local\Temp" /r /d y && ICACLS "%SystemDrive%\Users\User\AppData\Local\Temp" /grant %Username%:F /t
TAKEOWN /f "C:\Users\Администратор\AppData\Local\Temp" /r /d y && ICACLS "C:\Users\Администратор\AppData\Local\Temp" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Microsoft\Diagnosis" /r /d y && ICACLS "%SystemDrive%\ProgramData\Microsoft\Diagnosis" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Kaspersky Lab\KES\Temp" /r /d y && ICACLS "%SystemDrive%\ProgramData\Kaspersky Lab\KES\Temp" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp" /r /d y && ICACLS "%SystemDrive%\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Intel\Logs" /r /d y && ICACLS "%SystemDrive%\ProgramData\Intel\Logs" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Intel\Package Cache" /r /d y && ICACLS "%SystemDrive%\ProgramData\Intel\Package Cache" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache" /r /d y && ICACLS "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Package Cache" /r /d y && ICACLS "%SystemDrive%\ProgramData\Package Cache" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Oracle\Java\installcache_x64" /r /d y && ICACLS "%SystemDrive%\ProgramData\Oracle\Java\installcache_x64" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\LANDesk\Log" /r /d y && ICACLS "%SystemDrive%\ProgramData\LANDesk\Log" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache" /r /d y && ICACLS "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\Intel\Logs" /r /d y && ICACLS "%SystemDrive%\ProgramData\Intel\Logs" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\ProgramData\LANDesk\Temp" /r /d y && ICACLS "%SystemDrive%\ProgramData\LANDesk\Temp" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\Intel" /r /d y && ICACLS "%SystemDrive%\Intel" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\SWSetup" /r /d y && ICACLS "%SystemDrive%\SWSetup" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\MSOCache\All Users" /r /d y && ICACLS "%SystemDrive%\MSOCache\All Users" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\AMD" /r /d y && ICACLS "%SystemDrive%\AMD" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\$WINDOWS.~BT" /r /d y && ICACLS "%SystemDrive%\$WINDOWS.~BT" /grant %Username%:F /t
TAKEOWN /f "%SystemDrive%\Windows10Upgrade" /r /d y && ICACLS "%SystemDrive%\Windows10Upgrade" /grant %Username%:F /t
echo ===
echo ========== Очистка диска от временных файлов ==========
echo ===

echo ===
echo ========== Очистка в папке "C:\Windows" ==========
echo ===

echo Удаление временных файлов в директории 'C:\Windows\Logs\' и 'C:\logs\'
timeout 2
del "%WINDIR%\Logs\*" /s /f /q
del "%SystemDrive%\logs\*" /s /f /q
mkdir C:\Logs\

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
echo Удаление папки по директории: 'C:\$WINDOWS.~BT'
timeout 2
rd "%SystemDrive%\$WINDOWS.~BT" /s /q

echo ===
echo Удаление папки по директории: 'C:\Windows10Upgrade'
timeout 2
rd "%SystemDrive%\Windows10Upgrade" /s /q


C:\Windows10Upgrade\

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
echo itsCleanable 'Version: %Version% | Update %Dates%'
echo Автор: Захаров Илья Алексеевич.
echo Новая версия github.com/itsmyfox в разделе 'itsCleanable'
echo Свои идеи Вы можете предложить в разделе 'pull requests'

echo ===
echo Ожидаем завершения очистки диска...
timeout 7

exit 