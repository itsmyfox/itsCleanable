@echo off
chcp 866
set Username=‘ˆ‘’…Œ€
set Version=1.1.12
set Dates=21.05.2021
title Žç¨áâª  ¤¨áª  "itsCleanable | Version: %Version% | Update %Dates%

echo —¥à¥§ 7 á¥ªã­¤ § ¯ãáâ¨âìáï áªà¨¯â 'itsCleanable.bat / Version %Version% / Ž¡­®¢«¥­¨¥ ®â %Dates%' - ®ç¨áâª¨ ¤¨áª  ®â ¢à¥¬¥­­ëå ¨ ­¥¨á¯®«ì§ã¥¬ëå ä ©«®¢. …á«¨ ­¥ å®â¨â¥ íâ®£® ¤¥« âì, ­ ¦¬¨â¥ ª®¬¡¨­ æ¨î 'ctrl + c'

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

chcp 1251
mkdir C:\LogsCache\
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-start-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\

timeout 7 /nobreak

echo ===
echo ========== Žáâ ­®¢ª  á«ã¦¡ ­  ¬®¬¥­â à ¡®âë áªà¨¯â  ==========
echo ===

echo Žáâ ­®¢ª  á«ã¦¡ë '–¥­âà ®¡­®¢«¥­¨ï Windows'
timeout 2
net stop wuauserv

echo ===
echo ========== Žáâ ­®¢ª  ¤àã£¨å á«ã¦¡ ==========
echo ===

timeout 1
echo XBOX
net stop "Xbox Accessory Management Service"
timeout 1
echo ¨®¬¥âà¨ç¥áª ï á«ã¦¡  Windows
net stop "WbioSrvc"
timeout 1
echo „¨á¯¥âç¥à ¯à®¢¥àª¨ ¯®¤«¨­­®áâ¨ Xbox Live
net stop "XblAuthManager"
timeout 1
echo ®¤¨â¥«ìáª¨© ª®­âà®«ì
net stop "WpcMonSvc"
timeout 1
echo ‘¥â¥¢ ï á«ã¦¡  Xbox Live
net stop "XboxNetApiSvc"
timeout 1
echo ‘«ã¦¡  Windows License Manager
net stop "LicenseManager"
timeout 1
echo Windows Mobile Hotspot
net stop "icssvc"
timeout 1
echo ‘«ã¦¡  ¤¥¬®­áâà æ¨¨ ¬ £ §¨­ 
net stop "RetailDemo"
timeout 1
echo ‘«ã¦¡  ã¯à ¢«¥­¨ï à ¤¨®
net stop "RmSvc"
timeout 1
echo ” ªá
net stop "Fax"

echo ===
echo ========== Žáâ ­®¢ª  á«ã¦¡ë ¯®¨áª  ¤«ï ã¤ «¥­¨ï ä ©«  ==========
echo ===

echo ===
echo Windows.edb ï¢«ï¥âáï ¨­¤¥ªá­®© ¡ §®© ¤ ­­ëå á«ã¦¡ë ¯®¨áª  Windows. « £®¤ àï â ª®© ¨­¤¥ªá æ¨¨ ¯®¨áª ¯à®¨áå®¤¨â ¡ëáâà¥¥ ¨ íää¥ªâ¨¢­¥¥. ¥®¡å®¤¨¬® «¨ ã¤ «ïâì Windows.edb ¨ £¥­¥à¨à®¢ âì ­®¢ë© ä ¨« ¤«ï ®á¢®¡®¦¤¥­¨ï ¯à®áâà ­áâ¢ ? (Y/N)
choice /m "Windows.edb ï¢«ï¥âáï ¨­¤¥ªá­®© ¡ §®© ¤ ­­ëå á«ã¦¡ë ¯®¨áª  Windows. « £®¤ àï â ª®© ¨­¤¥ªá æ¨¨ ¯®¨áª ¯à®¨áå®¤¨â ¡ëáâà¥¥ ¨ íää¥ªâ¨¢­¥¥. ¥®¡å®¤¨¬® «¨ ã¤ «ïâì Windows.edb ¨ £¥­¥à¨à®¢ âì ­®¢ë© ä ¨« ¤«ï ®á¢®¡®¦¤¥­¨ï ¯à®áâà ­áâ¢ ?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo ‚ë ®âª § «¨áì ®â ã¤ «¥­¨ï ä ©«  Windows.edb (“¤ «¥­¨ï ¨­¤¥ªá­®© ¡ §ë ¤ ­­ëå á«ã¦¡ë ¯®¨áª  Windows).
goto NOWINDOWSEDB

:Y

echo Žáâ ­®¢ª  á«ã¦¡ë '®¨áª Windows'
timeout 2
net stop "Windows Search"
echo “¤ «¥­¨¥ ä ©«  Windows.edb ¨ £¥­¥à æ¨ï ­®¢®£® ä ©« .
timeout 2
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
del %PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\Windows.edb
timeout 2

echo ===
echo ========== ‡ ¯ãáª á«ã¦¡ë ¯®¨áª  ¤«ï £¥­¥à æ¨¨ ä ©«  ==========
echo ===

echo ‡ ¯ãáª á«ã¦¡ë '®¨áª Windows'
net start "Windows Search"

:NOWINDOWSEDB

echo ===
echo Žâªàë¢ ¥â ®ª­® 'Žç¨áâª  ¤¨áª ' ¨ á¯à è¨¢ ¥â, çâ® å®â¨â¥ ã¤ «¨âì. ‘«¥¤ã¥â ¯à®áâ ¢¨âì £ «®çª¨.
timeout 2
%windir%\system32\cmd.exe /c "start cleanmgr /sageset:64541

echo ===
echo ¥®¡å®¤¨¬ë¥ £ «®çª¨ ¯à®áâ ¢¨«? (Y/N)
choice /m "¥®¡å®¤¨¬ë¥ £ «®çª¨ ¯à®áâ ¢¨«?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo ‚ë ®âª § «¨áì ®â ®ç¨áâª¨ ¤¨áª .
goto COMPLETE

:Y

timeout 2
echo à®¤®«¦ ¥¬ ¯à®¨§¢®¤¨âì ®ç¨áâªã ¤¨áª ...
echo ®¤®¦¤¨â¥, à ¡®â ¥â ª®¬ ­¤  cleanmgr.exe /SETUP
cleanmgr.exe /SETUP
echo ‡ ¯ãáª ¥âáï cleanmgr...
%windir%\system32\cmd.exe /c "start cleanmgr /sagerun:64541

:COMPLETE

echo ===
echo ========== ‚ë¤ î ®á®¡ë¥ ¯à ¢  ­  ¢à¥¬¥­­ë¥ ¯ ¯ª¨ ==========
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
TAKEOWN /f "C:\Users\€¤¬¨­¨áâà â®à\AppData\Local\Temp" /r /d y && ICACLS "C:\Users\€¤¬¨­¨áâà â®à\AppData\Local\Temp" /grant %Username%:F /t
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
echo ========== Žç¨áâª  ¤¨áª  ®â ¢à¥¬¥­­ëå ä ©«®¢ ==========
echo ===

echo ===
echo ========== Žç¨áâª  ¢ ¯ ¯ª¥ "C:\Windows" ==========
echo ===

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\Windows\Logs\' ¨ 'C:\logs\'
timeout 2
del "%WINDIR%\Logs\*" /s /f /q
del "C:\logs\*" /s /f /q
mkdir C:\Logs\

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\Windows\Temp'
timeout 2
del "%WINDIR%\Temp\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*'
timeout 2
del "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*'
timeout 2
del "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Windows\SoftwareDistribution\Download\*'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Windows\Installer\$PatchCache$\*'
timeout 2
del "%WINDIR%\Installer\$PatchCache$\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Windows\assembly\NativeImages_*\temp\*'
timeout 2
del "%WINDIR%\assembly\NativeImages_v2.0.50727_32\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp\*" /s /f /q
del "%WINDIR%\assembly\temp\*" /s /f /q
del "%WINDIR%\assembly\tmp\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Windows\SoftwareDistribution\Download\SharedFileCache'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\SharedFileCache\*" /s /f /q

echo ===
echo ========== Žç¨áâª  ¢ ¯ ¯ª å "AppData" ==========
echo ===

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: '\AppData\Local\Temp\*'
timeout 2
del "%USERPROFILE%\AppData\Local\Temp\*" /s /f /q

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: '\AppData\Local\Yandex\YandexBrowser\'
timeout 2
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\browser.7z" /s /f /q
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\brand-package.cab" /s /f /q
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\setup.exe" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Users\User\AppData\Local\Temp\*'
timeout 2
del "C:\Users\User\AppData\Local\Temp\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Users\€¤¬¨­¨áâà â®à\AppData\Local\Temp\*'
timeout 2
del "C:\Users\€¤¬¨­¨áâà â®à\AppData\Local\Temp\*" /s /f /q

echo ===
echo ========== Žç¨áâª  ¢ ¯ ¯ª¥ "ProgramData" ==========
echo ===

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "C:\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe' ¨ 'ˆé¥â ¯® ¢á¥© ¯ ¯ª¥ ¨ ã¤ «ï¥â patch.exe'
timeout 2
del "C:\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe" /s /f /q

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ProgramData\Aktiv Co\*'
timeout 2
del "C:\ProgramData\Aktiv Co\*" /s /f /q

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ProgramData\USOShared\Logs\*'
timeout 2
del "C:\ProgramData\USOShared\Logs\*" /s /f /q

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¢ ¤¨à¥ªâ®à¨¨ 'C:\ProgramData\VMware\VDM\logs' ¨ 'C:\ProgramData\VMware\VDM\Dumps\'
timeout 2
del "C:\ProgramData\VMware\VDM\logs\*" /s /f /q
del "C:\ProgramData\VMware\VDM\Dumps\*" /s /f /q

echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Microsoft\Diagnosis\*'
timeout 2
del "C:\ProgramData\Microsoft\Diagnosis\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Kaspersky Lab\KES\Temp\* ¨ C:\ProgramData\Kaspersky Lab\KES\Cache\*'
timeout 2
del "C:\ProgramData\Kaspersky Lab\KES\Temp\*" /s /f /q
del "C:\ProgramData\Kaspersky Lab\KES\Cache\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*'
timeout 2
del "C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Intel\Logs\*' ¨ 'C:\ProgramData\Intel\Package Cache\*'
timeout 2
del "C:\ProgramData\Intel\Logs\*" /s /f /q
del "C:\ProgramData\Intel\Package Cache\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Veeam\Setup\Temp\*'
timeout 2
del "C:\ProgramData\Veeam\Setup\Temp\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "C:\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Package Cache\*'
timeout 2
del "C:\ProgramData\Package Cache\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Oracle\Java\installcache_x64\*'
timeout 2
del "C:\ProgramData\Oracle\Java\installcache_x64\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\LANDesk\Log\*'
timeout 2
del "C:\ProgramData\LANDesk\Log\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\Intel\Logs\*'
timeout 2
del "C:\ProgramData\Intel\Logs\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\ProgramData\LANDesk\Temp\*'
timeout 2
del "C:\ProgramData\LANDesk\Temp\*" /s /f /q

echo ===
echo ========== Žç¨áâª  ¢ ¤¨áª¥ "C:\" ==========
echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Intel\*'
timeout 2
del "C:\Intel\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\SWSetup\*'
timeout 2
del "C:\SWSetup\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\MSOCache\All Users\*'
timeout 2
del "C:\MSOCache\All Users\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¢à¥¬¥­­ëå ä ©«®¢ ¯® ¤¨à¥ªâ®à¨¨: 'C:\AMD'
timeout 2
del "C:\AMD\*" /s /f /q

echo ===
echo “¤ «¥­¨¥ ¯ ¯ª¨ ¯® ¤¨à¥ªâ®à¨¨: 'C:\$WINDOWS.~BT'
timeout 2
rd "C:\$WINDOWS.~BT" /s /q

echo ===
echo “¤ «¥­¨¥ ¯ ¯ª¨ ¯® ¤¨à¥ªâ®à¨¨: 'C:\Windows10Upgrade'
timeout 2
rd "C:\Windows10Upgrade" /s /q

echo ===
echo ========== ‡ ¯ãáª á«ã¦¡ ==========
echo ===

echo ‡ ¯ãáª á«ã¦¡ë '–¥­âà ®¡­®¢«¥­¨ï Windows'
timeout 2
net start wuauserv

echo ===
echo ‡ ¢¥àè¥­¨ï à ¡®âë...
echo itsCleanable 'Version: %Version% / Ž¡­®¢«¥­¨¥ ®â: %Dates%'
echo €¢â®à: ‡ å à®¢ ˆ«ìï €«¥ªá¥¥¢¨ç.
echo ®¢ ï ¢¥àá¨ï github.com/itsmyfox ¢ à §¤¥«¥ 'itsCleanable'
echo ‘¢®¨ ¨¤¥¨ ‚ë ¬®¦¥â¥ ¯à¥¤«®¦¨âì ¢ à §¤¥«¥ 'pull requests'

echo ===
echo Ž¦¨¤ ¥¬ § ¢¥àè¥­¨ï ®ç¨áâª¨ ¤¨áª ...
timeout 7

exit 
