@echo off
chcp 1251
set Username=Администратор
set Version=2.0.0
set Dates=18.04.2025
title Очистка диска "itsCleanable | Version: %Version% | Update %Dates%

echo ===
echo Имя компьютера: %ComputerName%
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
set datetime=%date:~0,2%-%date:~3,2%-%date:~6,4%_%mytime%
echo Дата и время обработки скрипта: %datetime%
echo Имя пользователя, запустивший скрипт: %Username%

echo ===
echo Через 3 секунды выполнится скрипт 'itsCleanable.bat / Version %Version% / Обновление от %Dates%' - очистки диска от временных и неиспользуемых файлов. Если вы хотите это отменить, нажмите комбинацию 'ctrl + c'

echo ===
echo Отключение телеметрии и службы сбора данных Windows
sc stop DiagTrack
sc config DiagTrack start=disabled
sc stop dmwappushservice
sc config dmwappushservice start=disabled
echo "" > C:\\ProgramData\\Microsoft\\Diagnosis\\ETLLogs\\AutoLogger\\AutoLogger-Diagtrack-Listener.etl
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Diagtrack-Listener\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA} /v Enabled /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Diagtrack-Listener\{DD17FA14-CDA6-7191-9B61-37A28F7A10DA} /v Start /t REG_DWORD /d 0 /f
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /f
del "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\*_APPRAISER_Utc.etl" /s /f /q

:: Отображение свободного места на диске до очистки
echo ===
echo Свободное место на диске до очистки
mkdir %SYSTEMDRIVE%\LogsCache\ 2>nul
chcp 1251
fsutil volume diskfree %SYSTEMDRIVE%\ > %SYSTEMDRIVE%\LogsCache\log-volume-start-itsCleanable_%datetime%.txt
chcp 866
fsutil volume diskfree %SYSTEMDRIVE%\

timeout 3 /nobreak

echo ===
echo Остановка служб Windows

:: Массив служб для остановки
set services_to_stop=wuauserv "Xbox Accessory Management Service" WbioSrvc XblAuthManager WpcMonSvc XboxNetApiSvc LicenseManager icssvc RetailDemo RmSvc Fax WSearch "Windows Search" SearchIndexer

for %%s in (%services_to_stop%) do (
    echo Остановка службы: %%s
    net stop %%s 2>nul
)

:: Дополнительно остановим процессы поиска
echo Остановка процессов SearchUI и SearchHost
taskkill /F /IM SearchUI.exe 2>nul
taskkill /F /IM SearchHost.exe 2>nul
taskkill /F /IM SearchApp.exe 2>nul

:: ЧАСТЬ 1: ОЧИСТКА ВСТРОЕННЫМИ СРЕДСТВАМИ

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

:: Специально не добавляем корзину в очистку
:: REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0064 /t REG_DWORD /d 2 /f

echo ===
echo Запуск встроенной утилиты очистки диска
echo Выполнение cleanmgr...
start /wait cleanmgr.exe /sagerun:64

:: echo ===
:: echo Очистка корзины Windows
:: rd /s /q %SystemDrive%\$Recycle.Bin 2>nul
:: echo Корзина очищена.

:: Очистка DNS и сетевого кэша
echo ===
echo Очистка DNS и сетевого кэша
echo Очистка DNS кэша...
ipconfig /flushdns
echo Сброс сетевого кэша...
netsh winsock reset catalog

:: ЧАСТЬ 2: ОЧИСТКА WINDOWS

echo ===
echo Очистка Windows от временных файлов

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

:: КОМЕНТАРИЙ: Убираем удаление BitLocker данных по запросу
:: del "%systemroot%\BitLockerDiscoveryVolumeContents\*" /s /f /q

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

echo ===
echo Очистка Program Files и ProgramFiles(x86)

:: Массив кэш-директорий в Program Files
set programfiles_cache="%programfiles%\Steam\appcache\*" "%programfiles(x86)%\Steam\appcache\*" "%programfiles%\Steam\depotcache\*" "%programfiles(x86)%\Steam\depotcache\*" "%programfiles(x86)%\LANDesk\LDClient\sdmcache\*"

for %%p in (%programfiles_cache%) do (
    echo Удаление: %%p
    del %%p /s /f /q 2>nul
)

echo ===
echo Удаление NVIDIA кэша
:: КОМЕНТАРИЙ: Убираем удаление файлов NVIDIA по запросу
:: del "%programfiles%\NVIDIA Corporation\Installer2\*" /s /f /q

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

echo ===
echo Очистка системного диска

:: Массив директорий системного диска для очистки
set systemdrive_dirs="%SYSTEMDRIVE%\Intel\*" "%SYSTEMDRIVE%\SWSetup\*" "%SYSTEMDRIVE%\MSOCache\*" "%SYSTEMDRIVE%\Tracing\*" "%SYSTEMDRIVE%\Config.Msi\*" "%SYSTEMDRIVE%\PerfLogs\*"

for %%s in (%systemdrive_dirs%) do (
    echo Удаление: %%s
    del %%s /s /f /q 2>nul
)

:: echo ===
:: echo Удаление AMD файлов
:: КОМЕНТАРИЙ: Убираем удаление AMD данных по запросу
:: del "%SYSTEMDRIVE%\AMD\*" /s /f /q

:: echo ===
:: echo Удаление NVIDIA файлов
:: КОМЕНТАРИЙ: Убираем удаление NVIDIA данных по запросу
:: del "%SYSTEMDRIVE%\NVIDIA\*" /s /f /q

echo ===
echo Удаление Windows Update папок
set win_update_dirs="%SYSTEMDRIVE%\$WINDOWS.~BT" "%SYSTEMDRIVE%\$WINDOWS.~WS" "%SYSTEMDRIVE%\$Windows.~BT" "%SYSTEMDRIVE%\$Windows.~WS" "%SYSTEMDRIVE%\Windows10Upgrade"

for %%w in (%win_update_dirs%) do (
    rd %%w /s /q 2>nul
)

:: Папки для очистки на внешних дисках
echo ===
echo Очистка служебных папок на всех дисках
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo Проверка диска %%d:
        del "%%d:\System Volume Information\tracking.log" /f /q 2>nul
        del "%%d:\.tmp" /s /f /q 2>nul
        del "%%d:\hiberfil.sys" /f /q 2>nul
        del "%%d:\pagefile.sys" /f /q 2>nul
        :: Корзину не очищаем, так как она исключена
        :: rd /s /q "%%d:\$RECYCLE.BIN" 2>nul
        del "%%d:\thumbs.db" /s /f /q 2>nul
    )
)

:: ЧАСТЬ 6: ОЧИСТКА ПРОФИЛЕЙ ПОЛЬЗОВАТЕЛЕЙ

echo ===
echo Очистка профилей пользователей

SetLocal EnableExtensions

:: Получение пути к профилю
For /F "Tokens=2*" %%I In ('Reg Query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /V ProfilesDirectory') Do Set Profiles=%%J
Call Set Profiles=%Profiles%

:: Очистка браузеров
echo ===
echo Очистка кэшей и истории браузеров

For /F "Delims=" %%I In ('Dir /B /AD-S-H "%Profiles%" ^| FindStr /V /B /I /C:"All Users"') Do (
    echo Обработка профиля %%I
    
    :: Установка прав
    TAKEOWN /f "%Profiles%\%%I\AppData\Local\Temp" /r /d y >nul && ICACLS "%Profiles%\%%I\AppData\Local\Temp" /grant %Username%:F /t >nul
    TAKEOWN /f "%Profiles%\%%I\Local Settings\Temporary Internet Files" /r /d y >nul && ICACLS "%Profiles%\%%I\Local Settings\Temporary Internet Files" /grant %Username%:F /t >nul
    TAKEOWN /f "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Temporary Internet Files" /r /d y >nul && ICACLS "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Temporary Internet Files" /grant %Username%:F /t >nul
    TAKEOWN /f "%Profiles%\%%I\AppData\LocalLow\Microsoft\CryptnetUrlCache" /r /d y >nul && ICACLS "%Profiles%\%%I\AppData\LocalLow\Microsoft\CryptnetUrlCache" /grant %Username%:F /t >nul
    :: TAKEOWN /f "%Profiles%\%%I\AppData\Local\Microsoft\Windows\PRICache" /r /d y >nul && ICACLS "%Profiles%\%%I\AppData\Local\Microsoft\Windows\PRICache" /grant %Username%:F /t >nul
    :: TAKEOWN /f "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Caches" /r /d y >nul && ICACLS "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Caches" /grant %Username%:F /t >nul
    :: TAKEOWN /f "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Explorer" /r /d y >nul && ICACLS "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Explorer" /grant %Username%:F /t >nul
    
    :: Chrome кэш и история
    echo Очистка Google Chrome
    del "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Code Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Media Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\History" /f /q 2>nul
    
    :: Firefox кэш и история
    echo Очистка Mozilla Firefox
    for /d %%F in ("%Profiles%\%%I\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release") do (
        del "%%F\cache2\*" /s /f /q 2>nul
        del "%%F\thumbnails\*" /s /f /q 2>nul
        del "%%F\cookies.sqlite" /f /q 2>nul
        del "%%F\webappsstore.sqlite" /f /q 2>nul
        del "%%F\chromeappsstore.sqlite" /f /q 2>nul
        del "%%F\places.sqlite" /f /q 2>nul
        del "%%F\recovery.jsonlz4" /f /q 2>nul
    )
    
    :: Opera кэш и история
    echo Очистка Opera
    del "%Profiles%\%%I\AppData\Local\Opera Software\Opera Stable\Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Roaming\Opera Software\Opera Stable\History" /f /q 2>nul
    
    :: Brave кэш и история
    echo Очистка Brave
    del "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Code Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Media Cache\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\Session Storage\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\History" /f /q 2>nul
    
    :: Tor Browser кэш
    echo Очистка Tor Browser
    for /d %%T in ("%Profiles%\%%I\AppData\Roaming\Tor Browser\Browser\TorBrowser\Data\Browser\profile.default") do (
        del "%%T\cache2\*" /s /f /q 2>nul
        del "%%T\cookies.sqlite" /f /q 2>nul
        del "%%T\places.sqlite" /f /q 2>nul
        del "%%T\recovery.jsonlz4" /f /q 2>nul
    )
    
    :: DuckDuckGo кэш
    echo Очистка DuckDuckGo
    del "%Profiles%\%%I\AppData\Local\Google\Chrome\User Data\Default\Local Extension Settings\kbfnbcaeplbcioakkpcpgfkobkghlhen\*" /s /f /q 2>nul
    
    :: Прочие временные файлы профиля
    echo Очистка временных файлов профиля
    set temp_profile_dirs="%Profiles%\%%I\AppData\Local\Temp\*.*" "%Profiles%\%%I\Local Settings\Temp\*.*" "%Profiles%\%%I\Local Settings\Temporary Internet Files\*.*" "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" "%Profiles%\%%I\AppData\LocalLow\Microsoft\CryptnetUrlCache\*" "%Profiles%\%%I\AppData\LocalLow\Microsoft\Windows\AppCache\*" "%Profiles%\%%I\AppData\LocalLow\Temp\*" "%Profiles%\%%I\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations\*" "%Profiles%\%%I\AppData\Local\Microsoft\Windows\INetCache\*" "%Profiles%\%%I\AppData\Local\Microsoft\Windows\WebCache\*"
    
    for %%t in (%temp_profile_dirs%) do (
        del %%t /s /f /q 2>nul
    )
    
    :: PRICache и Explorer - закомментировано, так как может нарушить отображение иконок
    :: del "%Profiles%\%%I\AppData\Local\Microsoft\Windows\PRICache\*" /s /f /q
    :: del "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Caches\*" /s /f /q
    :: del "%Profiles%\%%I\AppData\Local\Microsoft\Windows\Explorer\*" /s /f /q

    :: Кэши магазина Microsoft Store и UWP-приложений
    echo Очистка кэша Microsoft Store и UWP приложений
    set uwp_cache="%Profiles%\%%I\AppData\Local\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*" "%Profiles%\%%I\AppData\Local\Packages\Microsoft.Windows.Photos_8wekyb3d8bbwe\LocalCache\*" "%Profiles%\%%I\AppData\Local\Packages\Microsoft.Office.Desktop_8wekyb3d8bbwe\LocalCache\*" "%Profiles%\%%I\AppData\Local\Packages\Microsoft.SkypeApp_*\LocalCache\*" "%Profiles%\%%I\AppData\Local\Packages\*\AC\*" "%Profiles%\%%I\AppData\Local\Packages\*\LocalCache\*"
    
    for %%u in (%uwp_cache%) do (
        del %%u /s /f /q 2>nul
    )
    
    :: Кэши популярных приложений
    echo Очистка кэшей популярных приложений
    set popular_apps_cache="%Profiles%\%%I\AppData\Roaming\Spotify\Data\*" "%Profiles%\%%I\AppData\Roaming\discord\Cache\*" "%Profiles%\%%I\AppData\Roaming\discord\Code Cache\*" "%Profiles%\%%I\AppData\Roaming\Telegram Desktop\tdata\temp\*" "%Profiles%\%%I\AppData\Local\WhatsApp\*cache*\*" "%Profiles%\%%I\AppData\Local\Slack\Cache\*" "%Profiles%\%%I\AppData\Local\Slack\Service Worker\CacheStorage\*" "%Profiles%\%%I\AppData\Local\Microsoft\Teams\Cache\*" "%Profiles%\%%I\AppData\Local\Microsoft\Teams\Application Cache\*" "%Profiles%\%%I\AppData\Roaming\Zoom\logs\*"
    
    for %%p in (%popular_apps_cache%) do (
        del %%p /s /f /q 2>nul
    )
    
    :: Кэши видеоредакторов и графических программ
    echo Очистка кэшей мультимедиа программ
    set media_cache="%Profiles%\%%I\AppData\Roaming\Adobe\*\*\Media Cache Files\*" "%Profiles%\%%I\AppData\Roaming\Adobe\*\*\Media Cache\*" "%Profiles%\%%I\AppData\Local\VEGAS\*\*\Tmp\*" "%Profiles%\%%I\AppData\Local\CyberLink\*" "%Profiles%\%%I\AppData\Local\Blackmagic Design\DaVinci Resolve\*\CacheClip\*"
    
    for %%m in (%media_cache%) do (
        del %%m /s /f /q 2>nul
    )

    :: Временные файлы офисных программ
    echo Очистка временных файлов офисных приложений
    set office_temp="%Profiles%\%%I\AppData\Roaming\Microsoft\Word\*.tmp" "%Profiles%\%%I\AppData\Roaming\Microsoft\Excel\*.tmp" "%Profiles%\%%I\AppData\Roaming\Microsoft\PowerPoint\*.tmp" "%Profiles%\%%I\AppData\Local\Microsoft\Office\*\OfficeFileCache\*" "%Profiles%\%%I\AppData\Roaming\Microsoft\Office\Recent\*"
    
    for %%o in (%office_temp%) do (
        del %%o /s /f /q 2>nul
    )

    :: Кэш видеодрайверов
    echo Очистка кэша видеодрайверов
    set gpu_cache="%Profiles%\%%I\AppData\Local\NVIDIA\GLCache\*" "%Profiles%\%%I\AppData\Local\NVIDIA\DXCache\*" "%Profiles%\%%I\AppData\Roaming\AMD\GLCache\*" "%Profiles%\%%I\AppData\Roaming\AMD\DxCache\*" "%Profiles%\%%I\AppData\Roaming\Intel\ShaderCache\*"
    
    for %%g in (%gpu_cache%) do (
        del %%g /s /f /q 2>nul
    )

    :: Python кэш
    echo Очистка Python кэша (__pycache__ директории)
    del "%Profiles%\%%I\AppData\Local\Programs\Python\Python*\Lib\site-packages\*\__pycache__\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\Programs\Python\Python*\Lib\__pycache__\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\Python*\Lib\site-packages\*\__pycache__\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Local\Python*\Lib\__pycache__\*" /s /f /q 2>nul
    del "%Profiles%\%%I\AppData\Roaming\Python\*\site-packages\*\__pycache__\*" /s /f /q 2>nul
)

echo ===
echo Очистка точек восстановления
echo Очистка точек восстановления системы...
del "%SYSTEMDRIVE%\System Volume Information\*" /s /f /q

:: Сравнение свободного места до и после очистки
echo ===
echo Свободное место на диске после очистки
chcp 1251
fsutil volume diskfree %SYSTEMDRIVE%\ > %SYSTEMDRIVE%\LogsCache\log-volume-end-itsCleanable_%datetime%.txt
chcp 866
fsutil volume diskfree %SYSTEMDRIVE%\

echo ===
echo Результаты очистки
echo Лог свободного места до очистки:
type %SYSTEMDRIVE%\LogsCache\log-volume-start-itsCleanable_%datetime%.txt
echo.
echo Лог свободного места после очистки:
type %SYSTEMDRIVE%\LogsCache\log-volume-end-itsCleanable_%datetime%.txt

echo ===
echo Завершение работы...
echo itsCleanable 'Version: %Version% / Обновление от: %Dates%'
echo Автор: Захаров Илья Алексеевич.
echo Исходный код на github.com/itsmyfox в разделе 'itsCleanable'
echo Свои идеи вы можете предложить в разделе 'pull requests'

echo ===
echo Ожидание завершения очистки диска...
timeout 7

exit 
