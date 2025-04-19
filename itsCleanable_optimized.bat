@echo off
setlocal EnableDelayedExpansion
chcp 1251

:: Настройка полного логирования
set Version=2.0.0
set Dates=19.04.2025
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
set datetime=%date:~0,2%-%date:~3,2%-%date:~6,4%_%mytime%
set Username=Администратор
set LogFile=%SYSTEMDRIVE%\LogsCache\itsCleanable_transcript_%datetime%.log

:: Создаем каталог для логов и начинаем логирование
mkdir %SYSTEMDRIVE%\LogsCache\ 2>nul
echo ===== НАЧАЛО ЛОГИРОВАНИЯ itsCleanable ===== > "%LogFile%"
echo Дата: %date% Время: %time% >> "%LogFile%"
echo Пользователь: %Username% >> "%LogFile%"
echo Версия: %Version% (от %Dates%) >> "%LogFile%"
echo ============================================ >> "%LogFile%"

goto :StartScript

:: Функция для логирования команд и их результатов
:Log
echo %* >> "%LogFile%"
exit /b 0

:StartScript
title Очистка диска "itsCleanable | Version: %Version% | Update %Dates%

call :Log "Начало выполнения скрипта"

echo ===
echo Имя компьютера: %ComputerName%
echo Дата и время обработки скрипта: %datetime%
call :Log "Дата и время обработки скрипта: %datetime%"
echo Имя пользователя, запустивший скрипт: %Username%
call :Log "Имя пользователя, запустивший скрипт: %Username%"

echo ===
echo Через 3 секунды выполнится скрипт 'itsCleanable.bat / Version %Version% / Обновление от %Dates%' - очистки диска от временных и неиспользуемых файлов. Если вы хотите это отменить, нажмите комбинацию 'ctrl + c'
call :Log "Отображено предупреждение о начале работы скрипта"

:: Устанавливаем значения по умолчанию для опций очистки
set CLEAN_RECYCLE=N
set CLEAN_BITLOCKER=N
set CLEAN_NVIDIA=N
set CLEAN_AMD=N

:: Интерактивный выбор опций очистки
echo ===
echo ВНИМАНИЕ! Следующие опции очистки могут привести к потере данных или проблемам в работе системы.
echo Рекомендуется выбирать их только если вы понимаете последствия.
echo ===
call :Log "Отображен диалог выбора опциональных действий очистки"

choice /C YN /M "Очистить корзину Windows (может привести к потере удаленных файлов)"
if %ERRORLEVEL% EQU 1 set CLEAN_RECYCLE=Y
call :Log "Выбрана опция очистки корзины: %CLEAN_RECYCLE%"

choice /C YN /M "Удалить данные BitLocker (может нарушить шифрование дисков)"
if %ERRORLEVEL% EQU 1 set CLEAN_BITLOCKER=Y
call :Log "Выбрана опция удаления данных BitLocker: %CLEAN_BITLOCKER%"

choice /C YN /M "Удалить кэш NVIDIA (может потребоваться переустановка драйверов)"
if %ERRORLEVEL% EQU 1 set CLEAN_NVIDIA=Y
call :Log "Выбрана опция удаления кэша NVIDIA: %CLEAN_NVIDIA%"

choice /C YN /M "Удалить файлы AMD (может потребоваться переустановка драйверов)"
if %ERRORLEVEL% EQU 1 set CLEAN_AMD=Y
call :Log "Выбрана опция удаления файлов AMD: %CLEAN_AMD%"

echo ===
echo Выбраны следующие опции:
if "%CLEAN_RECYCLE%"=="Y" echo - Очистка корзины Windows: ДА
if "%CLEAN_RECYCLE%"=="N" echo - Очистка корзины Windows: НЕТ
if "%CLEAN_BITLOCKER%"=="Y" echo - Удаление данных BitLocker: ДА
if "%CLEAN_BITLOCKER%"=="N" echo - Удаление данных BitLocker: НЕТ
if "%CLEAN_NVIDIA%"=="Y" echo - Удаление кэша NVIDIA: ДА
if "%CLEAN_NVIDIA%"=="N" echo - Удаление кэша NVIDIA: НЕТ
if "%CLEAN_AMD%"=="Y" echo - Удаление файлов AMD: ДА
if "%CLEAN_AMD%"=="N" echo - Удаление файлов AMD: НЕТ
echo ===
call :Log "Отображена сводка выбранных опций"

choice /C YN /M "Продолжить с выбранными параметрами?"
if %ERRORLEVEL% NEQ 1 (
    echo Операция отменена пользователем.
    call :Log "Операция отменена пользователем"
    goto Finish
)
call :Log "Пользователь подтвердил продолжение"

echo ===
echo Отключение телеметрии и службы сбора данных Windows
call :Log "Начало отключения телеметрии Windows"

sc stop DiagTrack
call :Log "Остановка службы DiagTrack"
sc config DiagTrack start=disabled
call :Log "Отключение службы DiagTrack"
sc stop dmwappushservice
call :Log "Остановка службы dmwappushservice"
sc config dmwappushservice start=disabled
call :Log "Отключение службы dmwappushservice"
echo "" > C:\\ProgramData\\Microsoft\\Diagnosis\\ETLLogs\\AutoLogger\\AutoLogger-Diagtrack-Listener.etl
call :Log "Очистка AutoLogger-Diagtrack-Listener.etl"
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f
call :Log "Изменение реестра для отключения телеметрии"
reg add HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Diagtrack-Listener\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA} /v Enabled /t REG_DWORD /d 0 /f
call :Log "Отключение Diagtrack-Listener в реестре"
reg add HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Diagtrack-Listener\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA} /v Start /t REG_DWORD /d 0 /f
call :Log "Отключение автозапуска Diagtrack-Listener"
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f
call :Log "Удаление задачи UsbCeip"
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f
call :Log "Удаление задачи Consolidator"
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /f
call :Log "Удаление задачи KernelCeipTask"
del "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\*_APPRAISER_Utc.etl" /s /f /q
call :Log "Удаление APPRAISER ETL логов"

:: Отображение свободного места на диске до очистки
echo ===
echo Свободное место на диске до очистки
call :Log "Получение информации о свободном месте до очистки"
mkdir %SYSTEMDRIVE%\LogsCache\ 2>nul

:: Записываем заголовок в лог-файл
echo Свободное место до очистки: > "%SYSTEMDRIVE%\LogsCache\log-volume-start-itsCleanable_%datetime%.txt"

:: Получаем вывод команды и сохраняем построчно
for /f "usebackq tokens=*" %%i in (`fsutil volume diskfree %SYSTEMDRIVE%\`) do (
    echo %%i >> "%SYSTEMDRIVE%\LogsCache\log-volume-start-itsCleanable_%datetime%.txt"
)

:: Отображаем результаты на экран
fsutil volume diskfree %SYSTEMDRIVE%\

:: Сохраняем информацию для расчета
for /f "skip=1 tokens=2,3" %%A in ('fsutil volume diskfree %SYSTEMDRIVE%\') do (
    if "%%B"=="bytes" set FreeBefore=%%A
    goto :exitloop
)
:exitloop
call :Log "Свободно на диске до очистки: %FreeBefore% байт"

timeout 3 /nobreak

echo ===
echo Остановка служб Windows
call :Log "Начало остановки служб Windows"

:: Массив служб для остановки
set services_to_stop=wuauserv "Xbox Accessory Management Service" WbioSrvc XblAuthManager WpcMonSvc XboxNetApiSvc LicenseManager icssvc RetailDemo RmSvc Fax WSearch "Windows Search" SearchIndexer

for %%s in (%services_to_stop%) do (
    echo Остановка службы: %%s
    call :Log "Остановка службы: %%s"
    net stop %%s 2>nul
)

:: Дополнительно остановим процессы поиска
echo Остановка процессов SearchUI и SearchHost
call :Log "Остановка процессов поисковой системы Windows"
taskkill /F /IM SearchUI.exe 2>nul
call :Log "Остановка SearchUI.exe"
taskkill /F /IM SearchHost.exe 2>nul
call :Log "Остановка SearchHost.exe"
taskkill /F /IM SearchApp.exe 2>nul
call :Log "Остановка SearchApp.exe"

:: ЧАСТЬ 1: ОЧИСТКА ВСТРОЕННЫМИ СРЕДСТВАМИ
call :Log "ЧАСТЬ 1: ОЧИСТКА ВСТРОЕННЫМИ СРЕДСТВАМИ"

echo ===
echo Настройка параметров встроенной утилиты очистки диска
echo Установка параметров очистки через реестр...

:: Создаем подраздел для cleanmgr с настройками
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Memory Dump Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Archive Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Queue Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Archive Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Queue Files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows ESD installation files" /v StateFlags0064 /t REG_DWORD /d 2 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" /v StateFlags0064 /t REG_DWORD /d 2 /f

echo ===
echo Запуск встроенной утилиты очистки диска
echo Выполнение cleanmgr...
start /wait cleanmgr.exe /sagerun:64

:: Очистка DNS и сетевого кэша
echo ===
echo Очистка DNS и сетевого кэша
echo Очистка DNS кэша...
ipconfig /flushdns
echo Сброс сетевого кэша...
netsh winsock reset catalog

:: ЧАСТЬ 2: ОЧИСТКА WINDOWS
call :Log "ЧАСТЬ 2: ОЧИСТКА WINDOWS"

echo ===
echo Очистка Windows от временных файлов
call :Log "Начало очистки Windows от временных файлов"

:: Опциональная очистка корзины Windows
if "%CLEAN_RECYCLE%"=="Y" (
    echo ===
    echo Очистка корзины Windows
    call :Log "Выполняется очистка корзины"
    rd /s /q %SystemDrive%\$Recycle.Bin >nul 2>&1
    echo Корзина очищена.
    call :Log "Корзина очищена"
    
    :: Добавляем удаление корзины в cleanmgr
    REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0064 /t REG_DWORD /d 2 /f
    call :Log "Добавлен ключ реестра для очистки корзины в cleanmgr"
)

:: Массив Windows-директорий для очистки
set windows_dirs="%systemroot%\Logs\*" "%SYSTEMDRIVE%\logs\*" "%systemroot%\Temp\*" "%systemroot%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*" "%systemroot%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" "%systemroot%\Installer\$PatchCache$\*"

for %%d in (%windows_dirs%) do (
    echo Удаление: %%d
    del %%d /s /f /q 2>nul
)
mkdir %SYSTEMDRIVE%\Logs\ 2>nul

echo ===
echo Очистка кэша обновлений Windows
net stop wuauserv
del "%systemroot%\SoftwareDistribution\Download\*" /s /f /q
net start wuauserv

echo ===
echo Очистка Native Images
set native_images="%systemroot%\assembly\NativeImages_v2.0.50727_32\temp\*" "%systemroot%\assembly\NativeImages_v4.0.30319_64\temp\*" "%systemroot%\assembly\NativeImages_v2.0.50727_64\temp\*" "%systemroot%\assembly\NativeImages_v4.0.30319_32\temp\*" "%systemroot%\assembly\temp\*" "%systemroot%\assembly\tmp\*"

for %%n in (%native_images%) do (
    del %%n /s /f /q 2>nul
)

echo ===
echo Очистка системных логов и диагностики
set syslog_files="%systemroot%\System32\WDI\BootPerformanceDiagnostics_SystemData.bin" "%systemroot%\System32\WDI\ShutdownPerformanceDiagnostics_SystemData.bin" "%systemroot%\System32\catroot2\dberr.txt" "%systemroot%\System32\LogFiles\*.log" "%systemroot%\System32\LogFiles\WMI\*.etl" "%systemroot%\System32\LogFiles\WMI\*.001" "%systemroot%\*.log" "%systemroot%\Logs\*.log" "%systemroot%\SoftwareDistribution\*.log" "%systemroot%\System32\LogFiles\WMI\RtBackup\*"

for %%l in (%syslog_files%) do (
    del %%l /s /f /q 2>nul
)

echo ===
echo Очистка логов CLR
set clr_logs="%systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\CLR_v4.0\UsageLogs\*.log" "%systemroot%\SysWOW64\config\systemprofile\AppData\Local\Microsoft\CLR_v4.0\UsageLogs\*.log" "%systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs\*.log" "%systemroot%\SysWOW64\config\systemprofile\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs\*.log"

for %%c in (%clr_logs%) do (
    del %%c /s /f /q 2>nul
)

echo ===
echo Очистка временных файлов Windows
call :Log "Начало очистки временных файлов Windows"

:: Опциональная очистка BitLocker
if "%CLEAN_BITLOCKER%"=="Y" (
    echo ===
    echo Удаление данных BitLocker
    call :Log "Выполняется удаление BitLocker данных"
    del "%systemroot%\BitLockerDiscoveryVolumeContents\*" /s /f /q >nul 2>&1
    echo Данные BitLocker удалены.
    call :Log "Данные BitLocker удалены"
)

set windows_temp="%systemroot%\LastGood.Tmp\*" "%systemroot%\msdownld.tmp\*" "%systemroot%\Minidump\*" "%systemroot%\Downloaded Program Files\*" "%systemroot%\Downloaded Installations\*" "%systemroot%\tracing\*" "%systemroot%\rescache\*" "%systemroot%\ModemLogs\*" "%systemroot%\CbsTemp\*" "%systemroot%\LiveKernelReports\*" "%systemroot%\DeliveryOptimization\*" "%systemroot%\RemotePackages\*" "%systemroot%\bcastdvr\*" "%systemroot%\SchCache\*" "%systemroot%\Speech\Engines\Lexicon\*" "%systemroot%\Speech\Engines\SR\*" "%systemroot%\Speech_OneCore\Engines\Lexicon\*" "%systemroot%\Speech_OneCore\Engines\SR\*" "%systemroot%\System32\wbem\Logs\*" "%systemroot%\SysWOW64\wbem\Logs\*" "%systemroot%\assembly\temp\*" "%systemroot%\Minidump\*" "%systemroot%\ServiceProfiles\NetworkService\AppData\Local\Temp\*" "%systemroot%\System32\DriverStore\Temp\*" "%systemroot%\System32\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*" "%systemroot%\System32\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*" "%systemroot%\ServiceProfiles\LocalService\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*" "%systemroot%\ServiceProfiles\LocalService\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\*" "%systemroot%\System32\LogFiles\Scm\*" "%systemroot%\System32\sysprep\Panther\IE\*" "%systemroot%\System32\WDI\LogFiles\*"

for %%t in (%windows_temp%) do (
    del %%t /s /f /q 2>nul
)

echo ===
echo Очистка журналов событий Windows
for /f "tokens=*" %%G in ('wevtutil el') do (wevtutil cl "%%G" 2>nul)
echo Журналы событий очищены.

:: Системный кэш шрифтов
echo ===
echo Очистка кэша шрифтов
set font_cache="%WINDIR%\ServiceProfiles\LocalService\AppData\Local\FontCache\*" "%LOCALAPPDATA%\Microsoft\Windows\INetCache\IE\*"

for %%f in (%font_cache%) do (
    echo Удаление: %%f
    del %%f /s /f /q 2>nul
)

:: Кэш предыдущих версий Windows
echo ===
echo Очистка кэша старых инсталляций Windows
set windows_old="%SYSTEMDRIVE%\Windows.old\*" "%SYSTEMDRIVE%\$GetCurrent\*" "%SYSTEMDRIVE%\$Windows.~WS\*"

for %%w in (%windows_old%) do (
    echo Удаление: %%w
    del %%w /s /f /q 2>nul
    rd %%w /s /q 2>nul
)

:: Кэш .NET Framework
echo ===
echo Очистка .NET Framework кэша
set dotnet_cache="%LOCALAPPDATA%\Microsoft\CLR_v*\UsageLogs\*" "%TEMP%\*.tmp_proj" "%TEMP%\*.metaproj" "%TEMP%\shadow\*"

for %%d in (%dotnet_cache%) do (
    echo Удаление: %%d
    del %%d /s /f /q 2>nul
)

:: Файлы дампов и логи системных ошибок
echo ===
echo Очистка дампов и логов ошибок
set crash_logs="%LOCALAPPDATA%\CrashDumps\*" "%LOCALAPPDATA%\ElevatedDiagnostics\*" "%LOCALAPPDATA%\Microsoft\Windows\WER\*" "%APPDATA%\Local\Microsoft\CLR_v*.log"

for %%c in (%crash_logs%) do (
    echo Удаление: %%c
    del %%c /s /f /q 2>nul
)

:: ЧАСТЬ 3: ОЧИСТКА PROGRAM FILES
call :Log "ЧАСТЬ 3: ОЧИСТКА PROGRAM FILES"

echo ===
echo Очистка Program Files и ProgramFiles(x86)
call :Log "Начало очистки Program Files"

:: Массив кэш-директорий в Program Files
set programfiles_cache="%programfiles%\Steam\appcache\*" "%programfiles(x86)%\Steam\appcache\*" "%programfiles%\Steam\depotcache\*" "%programfiles(x86)%\Steam\depotcache\*" "%programfiles(x86)%\LANDesk\LDClient\sdmcache\*"

for %%p in (%programfiles_cache%) do (
    echo Удаление: %%p
    del %%p /s /f /q 2>nul
)

:: Опциональная очистка кэша NVIDIA
if "%CLEAN_NVIDIA%"=="Y" (
    echo ===
    echo Удаление NVIDIA кэша
    call :Log "Выполняется удаление кэша NVIDIA"
    del "%programfiles%\NVIDIA Corporation\Installer2\*" /s /f /q >nul 2>&1
    echo Кэш NVIDIA удален.
    call :Log "Кэш NVIDIA удален"
)

echo ===
echo Удаление информации о деинсталляции
set uninstall_dirs="%programfiles%\Uninstall Information\*" "%programfiles%\WindowsUpdate\*" "%programfiles(x86)%\Uninstall Information\*" "%programfiles(x86)%\WindowsUpdate\*"

for %%u in (%uninstall_dirs%) do (
    del %%u /s /f /q 2>nul
)

:: Кэш виртуализации
echo ===
echo Очистка кэша виртуализации
set virt_cache="%PROGRAMFILES%\Microsoft\Hyper-V\*\Temp\*" "%PROGRAMFILES%\Docker\*cache*\*" "%PROGRAMDATA%\Docker\config\*_temp\*"

for %%v in (%virt_cache%) do (
    echo Удаление: %%v
    del %%v /s /f /q 2>nul
)

:: ЧАСТЬ 4: ОЧИСТКА PROGRAMDATA

echo ===
echo Очистка ProgramData

:: Массив директорий ProgramData для очистки
set programdata_dirs="%PROGRAMDATA%\Security Code\Secret Net Studio\localcache\patch.exe" "%PROGRAMDATA%\Aktiv Co\*" "%PROGRAMDATA%\USOShared\Logs\*" "%PROGRAMDATA%\VMware\VDM\logs\*" "%PROGRAMDATA%\VMware\VDM\Dumps\*" "%PROGRAMDATA%\Microsoft\Diagnosis\*" "%PROGRAMDATA%\Kaspersky Lab\KES\Temp\*" "%PROGRAMDATA%\Kaspersky Lab\KES\Cache\*" "%PROGRAMDATA%\KasperskyLab\adminkit\1103\$FTCITmp\*" "%PROGRAMDATA%\Intel\Logs\*" "%PROGRAMDATA%\Intel\Package Cache\*" "%PROGRAMDATA%\Veeam\Setup\Temp\*" "%PROGRAMDATA%\Crypto Pro\Installer Cache\*" "%PROGRAMDATA%\Package Cache\*" "%PROGRAMDATA%\Oracle\Java\installcache_x64\*" "%PROGRAMDATA%\LANDesk\Log\*" "%PROGRAMDATA%\Intel\Logs\*" "%PROGRAMDATA%\LANDesk\Temp\*"

for %%d in (%programdata_dirs%) do (
    echo Удаление: %%d
    del %%d /s /f /q 2>nul
)

echo ===
echo Очистка директорий Microsoft в ProgramData
set ms_programdata="%programdata%\Microsoft\Windows\RetailDemo\OfflineContent\*" "%programdata%\Microsoft\Windows\WER\ReportArchive\*" "%programdata%\Microsoft\Windows\WER\ReportQueue\*" "%programdata%\Microsoft\Windows\Power Efficiency Diagnostics\*" "%programdata%\Microsoft\SmsRouter\MessageStore\*" "%programdata%\Microsoft\Windows\WER\*" "%programdata%\Microsoft\Network\Downloader\*" "%programdata%\Microsoft\Windows Security Health\Logs\*" "%programdata%\Microsoft\Windows Defender\Support\*" "%programdata%\Microsoft\Network\Downloader\*.log" "%programdata%\Microsoft\Windows Defender\Network Inspection System\Support\*.txt" "%programdata%\Microsoft\Windows Defender\Network Inspection System\Support\*.log" "%programdata%\USOShared\Logs\*.log" "%programdata%\Acronis\TrueImageHome\Logs\*.log" "%PROGRAMDATA%\Microsoft\Windows Defender\Scans\History\Results\Resource\*" "%PROGRAMDATA%\Windows Defender\Definition Updates\*" "%PROGRAMDATA%\Windows Defender\Scans\*"

for %%m in (%ms_programdata%) do (
    del %%m /s /f /q 2>nul
)

echo ===
echo Очистка кэша OneDrive
del "%LOCALAPPDATA%\Microsoft\OneDrive\*" /s /f /q 2>nul
echo Кэш OneDrive очищен.

:: ЧАСТЬ 5: ОЧИСТКА СИСТЕМНОГО ДИСКА
call :Log "ЧАСТЬ 5: ОЧИСТКА СИСТЕМНОГО ДИСКА"

echo ===
echo Очистка системного диска
call :Log "Начало очистки системного диска"

:: Массив директорий системного диска для очистки
set systemdrive_dirs="%SYSTEMDRIVE%\Intel\*" "%SYSTEMDRIVE%\SWSetup\*" "%SYSTEMDRIVE%\MSOCache\*" "%SYSTEMDRIVE%\Tracing\*" "%SYSTEMDRIVE%\Config.Msi\*" "%SYSTEMDRIVE%\PerfLogs\*"

for %%s in (%systemdrive_dirs%) do (
    echo Удаление: %%s
    del %%s /s /f /q 2>nul
)

:: Опциональная очистка AMD файлов
if "%CLEAN_AMD%"=="Y" (
    echo ===
    echo Удаление AMD файлов
    call :Log "Выполняется удаление AMD файлов"
    del "%SYSTEMDRIVE%\AMD\*" /s /f /q >nul 2>&1
    echo Файлы AMD удалены.
    call :Log "Файлы AMD удалены"
)

:: Опциональная очистка NVIDIA файлов
if "%CLEAN_NVIDIA%"=="Y" (
    echo ===
    echo Удаление NVIDIA файлов
    call :Log "Выполняется удаление файлов NVIDIA"
    del "%SYSTEMDRIVE%\NVIDIA\*" /s /f /q >nul 2>&1
    echo Файлы NVIDIA удалены.
    call :Log "Файлы NVIDIA удалены"
)

echo ===
echo Удаление Windows Update папок
set win_update_dirs="%SYSTEMDRIVE%\$WINDOWS.~BT" "%SYSTEMDRIVE%\$WINDOWS.~WS" "%SYSTEMDRIVE%\$Windows.~BT" "%SYSTEMDRIVE%\$Windows.~WS" "%SYSTEMDRIVE%\Windows10Upgrade"

for %%w in (%win_update_dirs%) do (
    rd %%w /s /q 2>nul
)

:: Папки для очистки на внешних дисках
echo ===
echo Очистка служебных папок на всех дисках
call :Log "Начало блока очистки внешних дисков"
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo Проверка диска %%d:
        call :Log "Обработка диска %%d:"
        
        call :Log "Удаление: %%d:\System Volume Information\tracking.log"
        del "%%d:\System Volume Information\tracking.log" /f /q >nul 2>&1
        
        call :Log "Удаление: %%d:\.tmp"
        del "%%d:\.tmp" /s /f /q >nul 2>&1
        
        call :Log "Удаление: %%d:\hiberfil.sys"
        del "%%d:\hiberfil.sys" /f /q >nul 2>&1
        
        call :Log "Удаление: %%d:\pagefile.sys"
        del "%%d:\pagefile.sys" /f /q >nul 2>&1
        
        call :Log "Удаление: %%d:\thumbs.db"
        del "%%d:\thumbs.db" /s /f /q >nul 2>&1
        
        call :Log "Завершена обработка диска %%d:"
    )
)
call :Log "Завершение блока очистки внешних дисков"

:: ЧАСТЬ 6: ОЧИСТКА ПРОФИЛЕЙ ПОЛЬЗОВАТЕЛЕЙ
call :Log "ЧАСТЬ 6: ОЧИСТКА ПРОФИЛЕЙ ПОЛЬЗОВАТЕЛЕЙ"

SetLocal EnableExtensions
call :Log "SetLocal EnableExtensions выполнено"

:: Получение пути к профилю
call :Log "Получаем пути к профилям пользователей"
For /F "Tokens=2*" %%I In ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /V ProfilesDirectory') Do Set Profiles=%%J
Call Set Profiles=%Profiles%
call :Log "Получен путь к профилям: %Profiles%"

:: Защита от ошибок при работе с профилями
if "%Profiles%"=="" (
    call :Log "ОШИБКА: Не удалось получить путь к профилям"
    echo Не удалось получить путь к профилям. Пропускаем очистку профилей.
    goto SkipProfileCleanup
)

:: Очистка браузеров
echo ===
echo Очистка кэшей и истории браузеров

call :Log "Начало перебора профилей пользователей"
for /F "Delims=" %%I in ('Dir /B /AD-S-H "%Profiles%" ^| FindStr /V /B /I /C:"All Users" ^| FindStr /V /B /I /C:"Public"') do (
    call :Log "Обработка профиля: %%I"
    echo Обработка профиля %%I
    
    :: Установка прав
    call :Log "Установка прав на Temp каталоги для профиля %%I"
    TAKEOWN /f "%Profiles%\%%I\AppData\Local\Temp" /r /d y >nul 2>&1 && ICACLS "%Profiles%\%%I\AppData\Local\Temp" /grant %Username%:F /t >nul 2>&1
    TAKEOWN /f "%Profiles%\%%I\Local Settings\Temporary Internet Files" /r /d y >nul 2>&1 && ICACLS "%Profiles%\%%I\Local Settings\Temporary Internet Files" /grant %Username%:F /t >nul 2>&1
    TAKEOWN /f "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Temporary Internet Files" /r /d y >nul 2>&1 && ICACLS "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Temporary Internet Files" /grant %Username%:F /t >nul 2>&1
    TAKEOWN /f "%Profiles%\%%I\AppData\LocalLow\Microsoft\CryptnetUrlCache" /r /d y >nul 2>&1 && ICACLS "%Profiles%\%%I\AppData\LocalLow\Microsoft\CryptnetUrlCache" /grant %Username%:F /t >nul 2>&1
    
    :: Chrome кэш и история
    call :Log "Очистка Google Chrome для профиля %%I"
    echo Очистка Google Chrome
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Media Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\History"
    
    :: Firefox кэш и история
    call :Log "Очистка Mozilla Firefox для профиля %%I"
    echo Очистка Mozilla Firefox
    for /d %%F in ("%Profiles%\%%I\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release") do (
        call :SafeDelete "%%F\cache2\*"
        call :SafeDelete "%%F\thumbnails\*"
        call :SafeDelete "%%F\cookies.sqlite"
        call :SafeDelete "%%F\webappsstore.sqlite"
        call :SafeDelete "%%F\chromeappsstore.sqlite"
        call :SafeDelete "%%F\places.sqlite"
        call :SafeDelete "%%F\recovery.jsonlz4"
    )
    
    :: Opera кэш и история
    echo Очистка Opera
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Opera Software\Opera Stable\Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Opera Software\Opera Stable\History"
    
    :: Brave кэш и история
    echo Очистка Brave
    call :SafeDelete "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Code Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Media Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Session Storage\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\History"
    
    :: Tor Browser кэш
    echo Очистка Tor Browser
    for /d %%T in ("%Profiles%\%%I\AppData\Roaming\Tor Browser\Browser\TorBrowser\Data\Browser\profile.default") do (
        call :SafeDelete "%%T\cache2\*"
        call :SafeDelete "%%T\cookies.sqlite"
        call :SafeDelete "%%T\places.sqlite"
        call :SafeDelete "%%T\recovery.jsonlz4"
    )
    
    :: DuckDuckGo кэш
    echo Очистка DuckDuckGo
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Local Extension Settings\kbfnbcaeplbcioakkpcpgfkobkghlhen\*"
    
    :: Прочие временные файлы профиля
    echo Очистка временных файлов профиля
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Temp\*.*"
    call :SafeDelete "%Profiles%\%%I\Local Settings\Temp\*.*"
    call :SafeDelete "%Profiles%\%%I\Local Settings\Temporary Internet Files\*.*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
    call :SafeDelete "%Profiles%\%%I\AppData\LocalLow\Microsoft\CryptnetUrlCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\LocalLow\Microsoft\Windows\AppCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\LocalLow\Temp\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Microsoft\Windows\INetCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Microsoft\Windows\WebCache\*"
    
    :: Кэши магазина Microsoft Store и UWP-приложений
    echo Очистка кэша Microsoft Store и UWP приложений
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Packages\Microsoft.Windows.Photos_8wekyb3d8bbwe\LocalCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Packages\Microsoft.Office.Desktop_8wekyb3d8bbwe\LocalCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Packages\Microsoft.SkypeApp_*\LocalCache\*"
    
    :: Кэши популярных приложений
    echo Очистка кэшей популярных приложений
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Spotify\Data\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\discord\Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\discord\Code Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Telegram Desktop\tdata\temp\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\WhatsApp\*cache*\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Slack\Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Slack\Service Worker\CacheStorage\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Microsoft\Teams\Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Microsoft\Teams\Application Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Zoom\logs\*"
    
    :: Кэши видеоредакторов и графических программ
    echo Очистка кэшей мультимедиа программ
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Adobe\*\*\Media Cache Files\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Adobe\*\*\Media Cache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\VEGAS\*\*\Tmp\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\CyberLink\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Blackmagic Design\DaVinci Resolve\*\CacheClip\*"

    :: Временные файлы офисных программ
    echo Очистка временных файлов офисных приложений
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Microsoft\Word\*.tmp"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Microsoft\Excel\*.tmp"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Microsoft\PowerPoint\*.tmp"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Microsoft\Office\*\OfficeFileCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Microsoft\Office\Recent\*"

    :: Кэш видеодрайверов
    echo Очистка кэша видеодрайверов
    call :SafeDelete "%Profiles%\%%I\AppData\Local\NVIDIA\GLCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\NVIDIA\DXCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\AMD\GLCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\AMD\DxCache\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Intel\ShaderCache\*"

    :: Python кэш
    echo Очистка Python кэша (__pycache__ директории)
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Programs\Python\Python*\Lib\site-packages\*\__pycache__\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Programs\Python\Python*\Lib\__pycache__\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Python*\Lib\site-packages\*\__pycache__\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Local\Python*\Lib\__pycache__\*"
    call :SafeDelete "%Profiles%\%%I\AppData\Roaming\Python\*\site-packages\*\__pycache__\*"
    


    :: Удаляем кэши остальных браузеров и приложений (сокращено)
    call :Log "Очистка других кэшей для профиля %%I завершена"
)
call :Log "Завершен перебор профилей пользователей"

:SkipProfileCleanup
call :Log "Блок очистки профилей завершен"

echo ===
echo Очистка точек восстановления
call :Log "Начало очистки точек восстановления"
echo Очистка точек восстановления системы...
del "%SYSTEMDRIVE%\System Volume Information\*" /s /f /q >nul 2>&1
call :Log "Завершено очистку точек восстановления"

:: Сравнение свободного места до и после очистки
echo ===
call :Log "Получение информации о свободном месте после очистки"
echo Свободное место на диске после очистки

:: Записываем заголовок в лог-файл
echo Свободное место после очистки: > "%SYSTEMDRIVE%\LogsCache\log-volume-end-itsCleanable_%datetime%.txt"

:: Получаем вывод команды и сохраняем построчно
for /f "usebackq tokens=*" %%i in (`fsutil volume diskfree %SYSTEMDRIVE%\`) do (
    echo %%i >> "%SYSTEMDRIVE%\LogsCache\log-volume-end-itsCleanable_%datetime%.txt"
)

:: Отображаем результаты на экран
fsutil volume diskfree %SYSTEMDRIVE%\

:: Сохраняем информацию для расчета
for /f "skip=1 tokens=2,3" %%A in ('fsutil volume diskfree %SYSTEMDRIVE%\') do (
    if "%%B"=="bytes" set FreeAfter=%%A
    goto :exitloop2
)
:exitloop2

call :Log "Свободно на диске после очистки: %FreeAfter% байт"
call :Log "Освобождено места: %FreeAfter% - %FreeBefore% байт"

echo ===
echo Результаты очистки
echo Лог свободного места до очистки:
type %SYSTEMDRIVE%\LogsCache\log-volume-start-itsCleanable_%datetime%.txt
echo.
echo Лог свободного места после очистки:
type %SYSTEMDRIVE%\LogsCache\log-volume-end-itsCleanable_%datetime%.txt
call :Log "Отображены результаты очистки"

:Finish
echo ===
echo Завершение работы...
echo itsCleanable 'Version: %Version% / Обновление от: %Dates%'
echo Автор: Захаров Илья Алексеевич.
echo Исходный код на github.com/itsmyfox в разделе 'itsCleanable'
echo Свои идеи вы можете предложить в разделе 'pull requests'
call :Log "Достигнут конец скрипта"

echo ===
echo Ожидание завершения очистки диска...
timeout 7
call :Log "Скрипт завершен"

echo Нажмите любую клавишу для закрытия окна...
echo Полный журнал выполнения доступен в файле: %LogFile%
pause
goto :eof

:: Функция безопасного удаления файлов с логированием
:SafeDelete
call :Log "SafeDelete: %~1"
del %~1 /s /f /q >nul 2>&1
exit /b 0 
