@echo off
chcp 866
set Version=1.0.9
set Dates=17.05.2021
title ���⪠ ��᪠ "itsCleanable | Version: %Version% | Update %Dates%

echo ����஢���� �ਯ⮢ � ��� C.
set drive=%~dp0
timeout 2
copy "%drive%\itsCleanable.bat" "C:\"
copy "%drive%\itsDiagnostic.bat" "C:\"
timeout 2

msg * /TIME:60 "����� �ணࠬ�� itsCleanable 'Version: %Version% | Update %Dates%'. ���⪠ �������� �� ���㦭�� �६����� 䠩��� ����� ������ �� 2 �� 15 �����. � 室� �믮������ �ணࠬ�� ��� ����室��� ���⠢��� ����窨. ��������, ��������..."

mkdir C:\LogsCache\
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
echo ===
call :color5 "����� itsCleanable.bat" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsCleanable.bat | Add-Content C:\LogsCache\log_itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "������ ��� 䠨� � ������ ��� �� ��४�ਨ 'C:\LogsCache\'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

chcp 1251
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-end-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

del "C:\itsCleanable.bat" /f /q

echo ===
call :color5 "����� 'itsDiagnostic.bat'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsDiagnostic.bat | Add-Content C:\LogsCache\log_itsDiagnostic_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

echo ===
call :color5 "��ਯ� ��ࠡ�⠭. ��� �����襭�� ������ ���� �������." Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1


del "C:\itsDiagnostic.bat" /f /q
msg * /TIME:60 "�ணࠬ�� �ᯥ譮 �����襭�. �������� ���⪨ ��᪠ ����� ���� �� ᫥���饬� ���: 'C:\LogsCache'"
start C:\LogsCache

pause
exit

