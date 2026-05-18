@echo off
set Version=1.1.12
set Dates=21.05.2021
title „Ё Ј­®бвЁЄ  Ё ў®ббв ­®ў«Ґ­ЁҐ бЁбвҐ¬­ле д ©«®ў "itsDiagnostic | Version: %Version% | Update %Dates%

echo —ҐаҐ§ 7 бҐЄг­¤ § ЇгбвЁвмбп бЄаЁЇв 'itsDiagnostic.bat / Version %Version% / ЋЎ­®ў«Ґ­ЁҐ ®в %Dates%' …б«Ё ­Ґ е®вЁвҐ нв®Ј® ¤Ґ« вм, ­ ¦¬ЁвҐ Є®¬ЎЁ­ жЁо 'ctrl + c'

echo ===
echo ========================= ‘Є ­Ёа®ў ­ЁҐ бЁбвҐ¬л =========================

echo ===
echo ЋЎ­®ў«Ґ­ЁҐ Ї®«ЁвЁЄ®ў.
timeout 2
gpupdate /force

msg * /TIME:10 "Ќ зЁ­ о Їа®Ё§ў®¤Ёвм ¤Ё Ј­®бвЁЄг Ё ў®ббв ­®ў«Ґ­ЁҐ бЁбвҐ¬­ле д ©«®ў Windows. Џ®¦ «г©бв , Ї®¤®¦¤ЁвҐ..."

echo ===
echo —в®Ўл ЁбЇа ўЁвм ®иЁЎЄЁ,  ўв®¬ вЁзҐбЄЁ бЄ з вм Ё § ¬Ґ­Ёвм д ©«л Ї®ўаҐ¦¤с­­ле Ё«Ё ®вбгвбвўгойЁе Є®¬Ї®­Ґ­в®ў нв «®­­л¬Ё ўҐабЁп¬Ё д ©«®ў Ё§ жҐ­ва  ®Ў­®ў«Ґ­Ё© Windows.
timeout 2
DISM /Online /Cleanup-Image /RestoreHealth

echo ===
echo ‘Є ­Ёа®ў ­ЁҐ бЁбвҐ¬л ­  ®иЁЎЄЁ.
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a-%%b)
timeout 2
%windir%\system32\cmd.exe /c "start sfc /scannow

echo ===
echo ‡ ўҐаиҐ­Ёп а Ў®вл...
echo itsCleanable 'Version: %Version% / ЋЎ­®ў«Ґ­ЁҐ ®в: %Dates%'
echo Ђўв®а: ‡ е а®ў €«мп Ђ«ҐЄбҐҐўЁз.
echo Ќ®ў п ўҐабЁп github.com/itsmyfox ў а §¤Ґ«Ґ 'itsCleanable'
echo ‘ў®Ё Ё¤ҐЁ ‚л ¬®¦ҐвҐ ЇаҐ¤«®¦Ёвм ў а §¤Ґ«Ґ 'pull requests'
echo ===
echo ‘ЄаЁЇв  ўв®¬ вЁзҐбЄЁ § ўҐаиЁвмбп зҐаҐ§ 10 бҐЄг­¤ Ё § ЇЁиҐв аҐ§г«мв вл ў «®Ј д Ё«.
echo …б«Ё ­Ґ е®вЁвҐ ¦¤ вм, ­ ¦¬ЁвҐ «оЎго Є« ўЁиг.
echo ===

timeout 10
