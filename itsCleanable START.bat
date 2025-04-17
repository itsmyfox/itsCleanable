@echo off
chcp 866
set Version=1.1.12
set Dates=21.05.2021
title Žç¨áâª  ¤¨áª  "itsCleanable | Version: %Version% | Update %Dates%

echo Š®¯¨à®¢ ­¨¥ áªà¨¯â®¢ ¢ ¤¨áª C.
set drive=%~dp0
timeout 2
copy "%drive%\itsCleanable_optimized.bat" "C:\"
copy "%drive%\itsDiagnostic.bat" "C:\"
timeout 2

echo ===
echo ‚ë¯®«­ïâì ¤¨ £­®áâ¨ªã ¨ ¢®ááâ ­®¢«¥­¨ï á¨áâ¥¬­ëå ä ©«®¢? (Y/N)
choice /m "‚ë¯®«­ïâì ¤¨ £­®áâ¨ªã ¨ ¢®ááâ ­®¢«¥­¨ï á¨áâ¥¬­ëå ä ©«®¢?"

if errorlevel 2 goto N
if errorlevel 1 goto Y

:N
timeout 2
echo ‚ë ®âª § «¨áì ®â ¤¨ £­®áâ¨ª¨ ¨ ¢®ááâ ­®¢«¥­¨ï á¨áâ¥¬­ëå ä ©«®¢.
goto NODIAGNOSTIC

:Y

echo ===
msg * /TIME:60 "‡ ¯ãáª ¯à®£à ¬¬ë itsCleanable 'Version: %Version% | Update %Dates%'. Žç¨áâª  ª®¬¯ìîâ¥à  ®â ­¥­ã¦­ëå ¢à¥¬¥­­ëå ä ©«®¢ ¬®¦¥â § ­ïâì ®â 2 ¤® 15 ¬¨­ãâ. ‚ å®¤¥ ¢ë¯®«­¥­¨ï ¯à®£à ¬¬ë ‚ ¬ ­¥®¡å®¤¨¬® ¯à®áâ ¢¨âì £ «®çª¨. ®¦ «ã©áâ , ¯®¤®¦¤¨â¥..."

mkdir C:\LogsCache\
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
echo ===
call :color5 "‡ ¯ãáª itsCleanable_optimized.bat" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsCleanable_optimized.bat | Add-Content C:\LogsCache\log_itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "‘®§¤ î ‹®£ ä ¨« ¨ ¯®¬¥é î ¥£® ¯® ¤¨à¥ªâ®à¨¨ 'C:\LogsCache\'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

chcp 1251
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-end-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

del "C:\itsCleanable_optimized.bat" /f /q

echo ===
call :color5 "‡ ¯ãáª 'itsDiagnostic.bat'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsDiagnostic.bat | Add-Content C:\LogsCache\log_itsDiagnostic_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

del "C:\itsDiagnostic.bat" /f /q
msg * /TIME:60 "à®£à ¬¬  ãá¯¥è­® § ¢¥àè¥­ . ¥§ã«ìâ âë ®ç¨áâª¨ ¤¨áª  ¬®¦­® ­ ©â¨ ¯® á«¥¤ãîé¥¬ã ¯ãâ¨: 'C:\LogsCache'"
start C:\LogsCache

pause
exit

:NODIAGNOSTIC

echo ===
msg * /TIME:60 "‡ ¯ãáª ¯à®£à ¬¬ë itsCleanable 'Version: %Version% | Update %Dates%'. Žç¨áâª  ª®¬¯ìîâ¥à  ®â ­¥­ã¦­ëå ¢à¥¬¥­­ëå ä ©«®¢ ¬®¦¥â § ­ïâì ®â 2 ¤® 15 ¬¨­ãâ. ‚ å®¤¥ ¢ë¯®«­¥­¨ï ¯à®£à ¬¬ë ‚ ¬ ­¥®¡å®¤¨¬® ¯à®áâ ¢¨âì £ «®çª¨. ®¦ «ã©áâ , ¯®¤®¦¤¨â¥..."

mkdir C:\LogsCache\
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
echo ===
call :color5 "‡ ¯ãáª itsCleanable_optimized.bat" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1
powershell "C:\itsCleanable_optimized.bat | Add-Content C:\LogsCache\log_itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.log -PassThru"

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

echo ===
call :color5 "‘®§¤ î ‹®£ ä ¨« ¨ ¯®¬¥é î ¥£® ¯® ¤¨à¥ªâ®à¨¨ 'C:\LogsCache\'" Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

chcp 1251
fsutil volume diskfree C:\ > C:\LogsCache\log-volume-end-itsCleanable_%date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%.txt
chcp 866
fsutil volume diskfree C:\

For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)

del "C:\itsCleanable_optimized.bat" /f /q

echo ===
call :color5 "‘ªà¨¯â ®âà ¡®â ­. „«ï § ¢¥àè¥­¨ï ­ ¦¬¨â¥ «î¡ãî ª« ¢¨èã." Green
:color5
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor %2 %1

del "C:\itsDiagnostic.bat" /f /q
msg * /TIME:60 "à®£à ¬¬  ãá¯¥è­® § ¢¥àè¥­ . ¥§ã«ìâ âë ®ç¨áâª¨ ¤¨áª  ¬®¦­® ­ ©â¨ ¯® á«¥¤ãîé¥¬ã ¯ãâ¨: 'C:\LogsCache'"
start C:\LogsCache

pause
exit
