@echo off
chcp 1251
set Username=Администратор
set Version=1.1.12
set Dates=21.05.2021
title Очистка диска "itsCleanable | Version: %Version% | Update %Dates%

echo Через 7 секунд запустится скрипт 'itsCleanable.bat / Version %Version% / Обновление от %Dates%' - очистки диска от временных и неиспользуемых файлов. Если не хотите этого делать, нажмите комбинацию 'ctrl + c'

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

mkdir C:\LogsCache\
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-start-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
fsutil volume diskfree C:\

timeout 7 /nobreak

echo ===
echo ========== Остановка служб на момент работы скрипта ==========
echo ===

echo Остановка службы 'Центр обновления Windows'
timeout 2
net stop wuauserv

echo ===
echo ========== Остановка других служб ==========
echo ===

timeout 1
echo XBOX
net stop "Xbox Accessory Management Service"
timeout 1
echo Биометрическая служба Windows
net stop "WbioSrvc"
timeout 1
echo Диспетчер проверки подлинности Xbox Live
net stop "XblAuthManager"
timeout 1
echo Родительский контроль
net stop "WpcMonSvc"
timeout 1
echo Сетевая служба Xbox Live
net stop "XboxNetApiSvc"
timeout 1
echo Служба Windows License Manager
net stop "LicenseManager"
timeout 1
echo Windows Mobile Hotspot
net stop "icssvc"
timeout 1
echo Служба демонстрации магазина
net stop "RetailDemo"
timeout 1
echo Служба управления радио
net stop "RmSvc"
timeout 1
echo Факс
net stop "Fax"

echo ===
echo ========== Остановка службы поиска для удаления файла ==========
echo ===

echo ===
echo Windows.edb является индексной базой данных службы поиска Windows. Благодаря такой индексации поиск происходит быстрее и эффективнее. Необходимо ли удалять Windows.edb и генерировать новый файл для освобождения пространства? (Y/N)
choice /m "Windows.edb является индексной базой данных службы поиска Windows. Благодаря такой индексации поиск происходит быстрее и эффективнее. Необходимо ли удалять Windows.edb и генерировать новый файл для освобождения пространства?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo Вы отказались от удаления файла Windows.edb (Удаления индексной базы данных службы поиска Windows).
goto NOWINDOWSEDB

:Y

echo Остановка службы 'Поиск Windows'
timeout 2
net stop "Windows Search"
echo Удаление файла Windows.edb и генерация нового файла.
timeout 2
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
del %PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\Windows.edb
timeout 2

echo ===
echo ========== Запуск службы поиска для генерации файла ==========
echo ===

echo Запуск службы 'Поиск Windows'
net start "Windows Search"

:NOWINDOWSEDB

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
echo ========== Выдаю особые права на временные папки ==========
echo ===
timeout 2
%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\Windows.edb

TAKEOWN /f "%WINDIR%\Logs" /r /d y && ICACLS "%WINDIR%\Logs" /grant %Username%:F /t
TAKEOWN /f "C:\logs" /r /d y && ICACLS "C:\logs" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\Temp" /r /d y && ICACLS "%WINDIR%\Temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\SoftwareDistribution\Download" /r /d y && ICACLS "%WINDIR%\SoftwareDistribution\Download" /grant %Username%:F /t
TAKEOWN /f "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows" /r /d y && ICACLS "%PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp" /r /d y && ICACLS "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp" /r /d y && ICACLS "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp" /r /d y && ICACLS "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\temp" /r /d y && ICACLS "%WINDIR%\assembly\temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\assembly\tmp" /r /d y && ICACLS "%WINDIR%\assembly\tmp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\SoftwareDistribution\Download\SharedFileCache" /r /d y && ICACLS "%WINDIR%\SoftwareDistribution\Download\SharedFileCache" /grant %Username%:F /t
TAKEOWN /f "%USERPROFILE%\AppData\Local\Temp" /r /d y && ICACLS "%USERPROFILE%\AppData\Local\Temp" /grant %Username%:F /t
TAKEOWN /f "C:\Users\User\AppData\Local\Temp" /r /d y && ICACLS "C:\Users\User\AppData\Local\Temp" /grant %Username%:F /t
TAKEOWN /f "C:\Users\Администратор\AppData\Local\Temp" /r /d y && ICACLS "C:\Users\Администратор\AppData\Local\Temp" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Microsoft\Diagnosis" /r /d y && ICACLS "C:\ProgramData\Microsoft\Diagnosis" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Kaspersky Lab\KES\Temp" /r /d y && ICACLS "C:\ProgramData\Kaspersky Lab\KES\Temp" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Kaspersky Lab\KES\Cache" /r /d y && ICACLS "C:\ProgramData\Kaspersky Lab\KES\Cache" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp" /r /d y && ICACLS "C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Intel\Logs" /r /d y && ICACLS "C:\ProgramData\Intel\Logs" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Intel\Package Cache" /r /d y && ICACLS "C:\ProgramData\Intel\Package Cache" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Crypto Pro\Installer Cache" /r /d y && ICACLS "C:\ProgramData\Crypto Pro\Installer Cache" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Package Cache" /r /d y && ICACLS "C:\ProgramData\Package Cache" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Oracle\Java\installcache_x64" /r /d y && ICACLS "C:\ProgramData\Oracle\Java\installcache_x64" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\LANDesk\Log" /r /d y && ICACLS "C:\ProgramData\LANDesk\Log" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Crypto Pro\Installer Cache" /r /d y && ICACLS "C:\ProgramData\Crypto Pro\Installer Cache" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Intel\Logs" /r /d y && ICACLS "C:\ProgramData\Intel\Logs" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\LANDesk\Temp" /r /d y && ICACLS "C:\ProgramData\LANDesk\Temp" /grant %Username%:F /t
TAKEOWN /f "C:\Intel" /r /d y && ICACLS "C:\Intel" /grant %Username%:F /t
TAKEOWN /f "C:\SWSetup" /r /d y && ICACLS "C:\SWSetup" /grant %Username%:F /t
TAKEOWN /f "C:\MSOCache\All Users" /r /d y && ICACLS "C:\MSOCache\All Users" /grant %Username%:F /t
TAKEOWN /f "C:\AMD" /r /d y && ICACLS "C:\AMD" /grant %Username%:F /t
TAKEOWN /f "C:\$WINDOWS.~BT" /r /d y && ICACLS "C:\$WINDOWS.~BT" /grant %Username%:F /t
TAKEOWN /f "C:\Windows10Upgrade" /r /d y && ICACLS "C:\Windows10Upgrade" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Security Code\Secret Net Studio\localcache" /r /d y && ICACLS "C:\ProgramData\Security Code\Secret Net Studio\localcache" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\VMware\VDM\logs" /r /d y && ICACLS "C:\ProgramData\VMware\VDM\logs" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\VMware\VDM\Dumps" /r /d y && ICACLS "C:\ProgramData\VMware\VDM\Dumps" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Veeam\Setup\Temp" /r /d y && ICACLS "C:\ProgramData\Veeam\Setup\Temp" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache" /r /d y && ICACLS "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs" /r /d y && ICACLS "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs" /grant %Username%:F /t
TAKEOWN /f "%WINDIR%\Installer\$PatchCache$" /r /d y && ICACLS "%WINDIR%\Installer\$PatchCache$" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Aktiv Co" /r /d y && ICACLS "C:\ProgramData\Aktiv Co" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\USOShared\Logs" /r /d y && ICACLS "C:\ProgramData\USOShared\Logs" /grant %Username%:F /t
TAKEOWN /f "C:\ProgramData\Crypto Pro\Installer Cache" /r /d y && ICACLS "C:\ProgramData\Crypto Pro\Installer Cache" /grant %Username%:F /t
TAKEOWN /f "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application" /r /d y && ICACLS "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application" /grant %Username%:F /t

echo ===
echo ========== Очистка диска от временных файлов ==========
echo ===

echo ===
echo ========== Очистка в папке "C:\Windows" ==========
echo ===

echo Удаление временных файлов в директории 'C:\Windows\Logs\' и 'C:\logs\'
timeout 2
del "%WINDIR%\Logs\*" /s /f /q
del "C:\logs\*" /s /f /q
mkdir C:\Logs\

echo ===
echo Удаление временных файлов в директории 'C:\Windows\Temp'
timeout 2
del "%WINDIR%\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов в директории 'C:\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*'
timeout 2
del "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*" /s /f /q

echo ===
echo Удаление временных файлов в директории 'C:\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*'
timeout 2
del "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Windows\SoftwareDistribution\Download\*'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Windows\Installer\$PatchCache$\*'
timeout 2
del "%WINDIR%\Installer\$PatchCache$\*" /s /f /q

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

echo Удаление временных файлов по директории: '\AppData\Local\Yandex\YandexBrowser\'
timeout 2
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\browser.7z" /s /f /q
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\brand-package.cab" /s /f /q
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\setup.exe" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Users\User\AppData\Local\Temp\*'
timeout 2
del "C:\Users\User\AppData\Local\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\Users\Администратор\AppData\Local\Temp\*'
timeout 2
del "C:\Users\Администратор\AppData\Local\Temp\*" /s /f /q

echo ===
echo ========== Очистка в папке "ProgramData" ==========
echo ===

echo Удаление временных файлов в директории 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "C:\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo Удаление временных файлов в директории 'C:\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe' и 'Ищет по всей папке и удаляет patch.exe'
timeout 2
del "C:\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe" /s /f /q

echo Удаление временных файлов в директории 'C:\ProgramData\Aktiv Co\*'
timeout 2
del "C:\ProgramData\Aktiv Co\*" /s /f /q

echo Удаление временных файлов в директории 'C:\ProgramData\USOShared\Logs\*'
timeout 2
del "C:\ProgramData\USOShared\Logs\*" /s /f /q

echo Удаление временных файлов в директории 'C:\ProgramData\VMware\VDM\logs' и 'C:\ProgramData\VMware\VDM\Dumps\'
timeout 2
del "C:\ProgramData\VMware\VDM\logs\*" /s /f /q
del "C:\ProgramData\VMware\VDM\Dumps\*" /s /f /q

echo Удаление временных файлов по директории: 'C:\ProgramData\Microsoft\Diagnosis\*'
timeout 2
del "C:\ProgramData\Microsoft\Diagnosis\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Kaspersky Lab\KES\Temp\* и C:\ProgramData\Kaspersky Lab\KES\Cache\*'
timeout 2
del "C:\ProgramData\Kaspersky Lab\KES\Temp\*" /s /f /q
del "C:\ProgramData\Kaspersky Lab\KES\Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*'
timeout 2
del "C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Intel\Logs\*' и 'C:\ProgramData\Intel\Package Cache\*'
timeout 2
del "C:\ProgramData\Intel\Logs\*" /s /f /q
del "C:\ProgramData\Intel\Package Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Veeam\Setup\Temp\*'
timeout 2
del "C:\ProgramData\Veeam\Setup\Temp\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "C:\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Package Cache\*'
timeout 2
del "C:\ProgramData\Package Cache\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Oracle\Java\installcache_x64\*'
timeout 2
del "C:\ProgramData\Oracle\Java\installcache_x64\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\LANDesk\Log\*'
timeout 2
del "C:\ProgramData\LANDesk\Log\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\Intel\Logs\*'
timeout 2
del "C:\ProgramData\Intel\Logs\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\ProgramData\LANDesk\Temp\*'
timeout 2
del "C:\ProgramData\LANDesk\Temp\*" /s /f /q

echo ===
echo ========== Очистка в диске "C:\" ==========
echo ===
echo Удаление временных файлов по директории: 'C:\Intel\*'
timeout 2
del "C:\Intel\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\SWSetup\*'
timeout 2
del "C:\SWSetup\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\MSOCache\All Users\*'
timeout 2
del "C:\MSOCache\All Users\*" /s /f /q

echo ===
echo Удаление временных файлов по директории: 'C:\AMD'
timeout 2
del "C:\AMD\*" /s /f /q

echo ===
echo Удаление папки по директории: 'C:\$WINDOWS.~BT'
timeout 2
rd "C:\$WINDOWS.~BT" /s /q

echo ===
echo Удаление папки по директории: 'C:\Windows10Upgrade'
timeout 2
rd "C:\Windows10Upgrade" /s /q

echo ===
echo ========== Запуск служб ==========
echo ===

echo Запуск службы 'Центр обновления Windows'
timeout 2
net start wuauserv

echo ===
echo Завершения работы...
echo itsCleanable 'Version: %Version% / Обновление от: %Dates%'
echo Автор: Захаров Илья Алексеевич.
echo Новая версия github.com/itsmyfox в разделе 'itsCleanable'
echo Свои идеи Вы можете предложить в разделе 'pull requests'

echo ===
echo Ожидаем завершения очистки диска...
timeout 7

pause 
