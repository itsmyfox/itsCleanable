@echo off
chcp 866
set Username=�������
set Version=1.1.12
set Dates=21.05.2021
title ���⪠ ��᪠ "itsCleanable | Version: %Version% | Update %Dates%

echo ��१ 7 ᥪ㭤 ���������� �ਯ� 'itsCleanable.bat / Version %Version% / ���������� �� %Dates%' - ���⪨ ��᪠ �� �६����� � ���ᯮ��㥬�� 䠩���. �᫨ �� ��� �⮣� ������, ������ ��������� 'ctrl + c'

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

chcp 1251
mkdir C:\LogsCache\
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-start-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\

timeout 7 /nobreak

echo ===
echo ========== ��⠭���� �㦡 �� ������ ࠡ��� �ਯ� ==========
echo ===

echo ��⠭���� �㦡� '����� ���������� Windows'
timeout 2
net stop wuauserv

echo ===
echo ========== ��⠭���� ��㣨� �㦡 ==========
echo ===

timeout 1
echo XBOX
net stop "Xbox Accessory Management Service"
timeout 1
echo ��������᪠� �㦡� Windows
net stop "WbioSrvc"
timeout 1
echo ��ᯥ��� �஢�ન ���������� Xbox Live
net stop "XblAuthManager"
timeout 1
echo ����⥫�᪨� ����஫�
net stop "WpcMonSvc"
timeout 1
echo ��⥢�� �㦡� Xbox Live
net stop "XboxNetApiSvc"
timeout 1
echo ��㦡� Windows License Manager
net stop "LicenseManager"
timeout 1
echo Windows Mobile Hotspot
net stop "icssvc"
timeout 1
echo ��㦡� ��������樨 ��������
net stop "RetailDemo"
timeout 1
echo ��㦡� �ࠢ����� ࠤ��
net stop "RmSvc"
timeout 1
echo ����
net stop "Fax"

echo ===
echo ========== ��⠭���� �㦡� ���᪠ ��� 㤠����� 䠩�� ==========
echo ===

echo ===
echo Windows.edb ���� �����᭮� ����� ������ �㦡� ���᪠ Windows. ��������� ⠪�� ������樨 ���� �ந�室�� ����॥ � ��䥪⨢���. ����室��� �� 㤠���� Windows.edb � �����஢��� ���� 䠨� ��� �᢮�������� ����࠭�⢠? (Y/N)
choice /m "Windows.edb ���� �����᭮� ����� ������ �㦡� ���᪠ Windows. ��������� ⠪�� ������樨 ���� �ந�室�� ����॥ � ��䥪⨢���. ����室��� �� 㤠���� Windows.edb � �����஢��� ���� 䠨� ��� �᢮�������� ����࠭�⢠?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo �� �⪠������ �� 㤠����� 䠩�� Windows.edb (�������� �����᭮� ���� ������ �㦡� ���᪠ Windows).
goto NOWINDOWSEDB

:Y

echo ��⠭���� �㦡� '���� Windows'
timeout 2
net stop "Windows Search"
echo �������� 䠩�� Windows.edb � ������� ������ 䠩��.
timeout 2
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
del %PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\Windows.edb
timeout 2

echo ===
echo ========== ����� �㦡� ���᪠ ��� �����樨 䠩�� ==========
echo ===

echo ����� �㦡� '���� Windows'
net start "Windows Search"

:NOWINDOWSEDB

echo ===
echo ���뢠�� ���� '���⪠ ��᪠' � ��訢���, �� ��� 㤠����. ������ ���⠢��� ����窨.
timeout 2
%windir%\system32\cmd.exe /c "start cleanmgr /sageset:64541

echo ===
echo ����室��� ����窨 ���⠢��? (Y/N)
choice /m "����室��� ����窨 ���⠢��?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo �� �⪠������ �� ���⪨ ��᪠.
goto COMPLETE

:Y

timeout 2
echo �த������ �ந������� ����� ��᪠...
echo ��������, ࠡ�⠥� ������� cleanmgr.exe /SETUP
cleanmgr.exe /SETUP
echo ����᪠���� cleanmgr...
%windir%\system32\cmd.exe /c "start cleanmgr /sagerun:64541

:COMPLETE

echo ===
echo ========== �뤠� �ᮡ� �ࠢ� �� �६���� ����� ==========
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
TAKEOWN /f "C:\Users\�����������\AppData\Local\Temp" /r /d y && ICACLS "C:\Users\�����������\AppData\Local\Temp" /grant %Username%:F /t
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
echo ========== ���⪠ ��᪠ �� �६����� 䠩��� ==========
echo ===

echo ===
echo ========== ���⪠ � ����� "C:\Windows" ==========
echo ===

echo �������� �६����� 䠩��� � ��४�ਨ 'C:\Windows\Logs\' � 'C:\logs\'
timeout 2
del "%WINDIR%\Logs\*" /s /f /q
del "C:\logs\*" /s /f /q
mkdir C:\Logs\

echo ===
echo �������� �६����� 䠩��� � ��४�ਨ 'C:\Windows\Temp'
timeout 2
del "%WINDIR%\Temp\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*'
timeout 2
del "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*'
timeout 2
del "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Windows\SoftwareDistribution\Download\*'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Windows\Installer\$PatchCache$\*'
timeout 2
del "%WINDIR%\Installer\$PatchCache$\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Windows\assembly\NativeImages_*\temp\*'
timeout 2
del "%WINDIR%\assembly\NativeImages_v2.0.50727_32\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp\*" /s /f /q
del "%WINDIR%\assembly\temp\*" /s /f /q
del "%WINDIR%\assembly\tmp\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Windows\SoftwareDistribution\Download\SharedFileCache'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\SharedFileCache\*" /s /f /q

echo ===
echo ========== ���⪠ � ������ "AppData" ==========
echo ===

echo �������� �६����� 䠩��� �� ��४�ਨ: '\AppData\Local\Temp\*'
timeout 2
del "%USERPROFILE%\AppData\Local\Temp\*" /s /f /q

echo �������� �६����� 䠩��� �� ��४�ਨ: '\AppData\Local\Yandex\YandexBrowser\'
timeout 2
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\browser.7z" /s /f /q
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\brand-package.cab" /s /f /q
del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\setup.exe" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Users\User\AppData\Local\Temp\*'
timeout 2
del "C:\Users\User\AppData\Local\Temp\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Users\�����������\AppData\Local\Temp\*'
timeout 2
del "C:\Users\�����������\AppData\Local\Temp\*" /s /f /q

echo ===
echo ========== ���⪠ � ����� "ProgramData" ==========
echo ===

echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "C:\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe' � '��� �� �ᥩ ����� � 㤠��� patch.exe'
timeout 2
del "C:\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe" /s /f /q

echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ProgramData\Aktiv Co\*'
timeout 2
del "C:\ProgramData\Aktiv Co\*" /s /f /q

echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ProgramData\USOShared\Logs\*'
timeout 2
del "C:\ProgramData\USOShared\Logs\*" /s /f /q

echo �������� �६����� 䠩��� � ��४�ਨ 'C:\ProgramData\VMware\VDM\logs' � 'C:\ProgramData\VMware\VDM\Dumps\'
timeout 2
del "C:\ProgramData\VMware\VDM\logs\*" /s /f /q
del "C:\ProgramData\VMware\VDM\Dumps\*" /s /f /q

echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Microsoft\Diagnosis\*'
timeout 2
del "C:\ProgramData\Microsoft\Diagnosis\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Kaspersky Lab\KES\Temp\* � C:\ProgramData\Kaspersky Lab\KES\Cache\*'
timeout 2
del "C:\ProgramData\Kaspersky Lab\KES\Temp\*" /s /f /q
del "C:\ProgramData\Kaspersky Lab\KES\Cache\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*'
timeout 2
del "C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Intel\Logs\*' � 'C:\ProgramData\Intel\Package Cache\*'
timeout 2
del "C:\ProgramData\Intel\Logs\*" /s /f /q
del "C:\ProgramData\Intel\Package Cache\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Veeam\Setup\Temp\*'
timeout 2
del "C:\ProgramData\Veeam\Setup\Temp\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "C:\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Package Cache\*'
timeout 2
del "C:\ProgramData\Package Cache\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Oracle\Java\installcache_x64\*'
timeout 2
del "C:\ProgramData\Oracle\Java\installcache_x64\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\LANDesk\Log\*'
timeout 2
del "C:\ProgramData\LANDesk\Log\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\Intel\Logs\*'
timeout 2
del "C:\ProgramData\Intel\Logs\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\ProgramData\LANDesk\Temp\*'
timeout 2
del "C:\ProgramData\LANDesk\Temp\*" /s /f /q

echo ===
echo ========== ���⪠ � ��᪥ "C:\" ==========
echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\Intel\*'
timeout 2
del "C:\Intel\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\SWSetup\*'
timeout 2
del "C:\SWSetup\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\MSOCache\All Users\*'
timeout 2
del "C:\MSOCache\All Users\*" /s /f /q

echo ===
echo �������� �६����� 䠩��� �� ��४�ਨ: 'C:\AMD'
timeout 2
del "C:\AMD\*" /s /f /q

echo ===
echo �������� ����� �� ��४�ਨ: 'C:\$WINDOWS.~BT'
timeout 2
rd "C:\$WINDOWS.~BT" /s /q

echo ===
echo �������� ����� �� ��४�ਨ: 'C:\Windows10Upgrade'
timeout 2
rd "C:\Windows10Upgrade" /s /q

echo ===
echo ========== ����� �㦡 ==========
echo ===

echo ����� �㦡� '����� ���������� Windows'
timeout 2
net start wuauserv

echo ===
echo �����襭�� ࠡ���...
echo itsCleanable 'Version: %Version% / ���������� ��: %Dates%'
echo ����: ���஢ ���� ����ᥥ���.
echo ����� ����� github.com/itsmyfox � ࠧ���� 'itsCleanable'
echo ���� ���� �� ����� �।������ � ࠧ���� 'pull requests'

echo ===
echo ������� �����襭�� ���⪨ ��᪠...
timeout 7

exit 