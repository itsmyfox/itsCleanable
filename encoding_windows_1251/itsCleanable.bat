@echo off
set Version=1.0.6
title ������� ����� "itsCleanable | Version: %Version%

echo ����� 7 ������ ����������� ������ 'itsCleanable.bat / Version %Version% / ���������� �� 06.05.2021' - ������� ����� �� ��������� � �������������� ������. ���� �� ������ ����� ������, ������� ���������� 'ctrl + c'

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

mkdir C:\Logs\
fsutil volume diskfree C:\ > C:\Logs\log-volume-start-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
fsutil volume diskfree C:\


timeout 7 /nobreak


echo ===
echo ========== ��������� ����� �� ������ ������ ������� ==========
echo ===

echo ��������� ������ '����� ���������� Windows'
timeout 2
net stop wuauserv


echo ===
echo ========== ������� ����� �� ��������� ������ ==========
echo ===

echo ===
echo ========== ������� � ����� "C:\Windows" ==========
echo ===

echo �������� ��������� ������ � ���������� 'C:\Windows\Logs\'
timeout 2
del "%WINDIR%\Logs\*" /s /f /q

echo ===
echo �������� ��������� ������ � ���������� 'C:\Windows\Temp'
timeout 2
del "%WINDIR%\Temp\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\Windows\SoftwareDistribution\Download\*'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\Windows\assembly\NativeImages_*\temp\*'
timeout 2
del "%WINDIR%\assembly\NativeImages_v2.0.50727_32\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v2.0.50727_64\temp\*" /s /f /q
del "%WINDIR%\assembly\NativeImages_v4.0.30319_32\temp\*" /s /f /q
del "%WINDIR%\assembly\temp\*" /s /f /q
del "%WINDIR%\assembly\tmp\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\Windows\SoftwareDistribution\Download\SharedFileCache'
timeout 2
del "%WINDIR%\SoftwareDistribution\Download\SharedFileCache\*" /s /f /q

echo ===
echo ========== ������� � ������ "AppData" ==========
echo ===

echo �������� ��������� ������ �� ����������: '\AppData\Local\Temp\*'
timeout 2
del "%USERPROFILE%\AppData\Local\Temp\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\Users\User\AppData\Local\Temp\*'
timeout 2
del "%SystemDrive%\Users\User\AppData\Local\Temp\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\Users\�������������\AppData\Local\Temp\*'
timeout 2
del "C:\Users\�������������\AppData\Local\Temp\*" /s /f /q

echo ===
echo ========== ������� � ����� "ProgramData" ==========
echo ===

echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Microsoft\Diagnosis\*'
timeout 2
del "%SystemDrive%\ProgramData\Microsoft\Diagnosis\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Kaspersky Lab\KES\Temp\*'
timeout 2
del "%SystemDrive%\ProgramData\Kaspersky Lab\KES\Temp\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*'
timeout 2
del "%SystemDrive%\ProgramData\KasperskyLab\adminkit\1103\$FTCITmp\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Intel\Logs\*' � 'C:\ProgramData\Intel\Package Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Intel\Logs\*" /s /f /q
del "%SystemDrive%\ProgramData\Intel\Package Cache\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Package Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Package Cache\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Oracle\Java\installcache_x64\*'
timeout 2
del "%SystemDrive%\ProgramData\Oracle\Java\installcache_x64\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\LANDesk\Log\*'
timeout 2
del "%SystemDrive%\ProgramData\LANDesk\Log\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Crypto Pro\Installer Cache\*'
timeout 2
del "%SystemDrive%\ProgramData\Crypto Pro\Installer Cache\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\Intel\Logs\*'
timeout 2
del "%SystemDrive%\ProgramData\Intel\Logs\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\ProgramData\LANDesk\Temp\*'
timeout 2
del "%SystemDrive%\ProgramData\LANDesk\Temp\*" /s /f /q


echo ===
echo ========== ������� � ����� "C:\" ==========
echo ===
echo �������� ��������� ������ �� ����������: 'C:\Intel\*'
timeout 2
del "%SystemDrive%\Intel\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\SWSetup\*'
timeout 2
del "%SystemDrive%\SWSetup\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\MSOCache\All Users\*'
timeout 2
del "%SystemDrive%\MSOCache\All Users\*" /s /f /q

echo ===
echo �������� ��������� ������ �� ����������: 'C:\AMD'
timeout 2
del "%SystemDrive%\AMD\*" /s /f /q

echo ===
echo ��������� ���� '������� �����' � ����������, ��� ������ �������. ������� ���������� �������.
timeout 2
%windir%\system32\cmd.exe /c "start cleanmgr /sageset:64541

echo ===
echo ����������� ������� ���������? (Y/N)
choice /m "����������� ������� ���������?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo �� ���������� �� ������� �����.
goto COMPLETE

:Y

timeout 2
echo ���������� ����������� ������� �����...
echo ���������, �������� ������� cleanmgr.exe /SETUP
cleanmgr.exe /SETUP
echo ����������� cleanmgr...
%windir%\system32\cmd.exe /c "start cleanmgr /sagerun:64541

:COMPLETE

echo ===
echo ========== ������ ����� ==========
echo ===

echo ������ ������ '����� ���������� Windows'
timeout 2
net start wuauserv



echo ===
echo ���������� ������...
echo itsCleanable Version: %Version%
echo �����: ������� ���� ����������.
echo ����� ������ github.com/itsmyfox � ������� 'itsCleanable'
echo ���� ���� �� ������ ���������� � ������� 'pull requests'

echo ===
echo ������� ���������� ������� �����...
timeout 7

exit 