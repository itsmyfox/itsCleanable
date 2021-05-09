Внимание, кодировка по стандарту для нормальной работы скриптов 866. По этому на gitHub может отображаться не корректно!

# ===itsCleanable.bat + itsDiagnostic.bat | Версия 1.0.6:===

09.05.2021 Update
1. Логи очистки, Логи диагностики выводятся в отдельные файлы и одновременно транслируются в консоль. 
2. Скрипт очистки и Скрипт Диагностики теперь отдельные скрипты, которые взаимосвязаны между собой.
3. Отдельный скрипт START их запускает. В начале он показывает размер свободного пространства на диске и записывает в лог фаил. А в конце стоит задержка 30 минут. Либо в ручную останавливать скрипт любой клавишей, либо он автоматически завершиться через 30 минут.
4. После этого он только тогда показывает свободное пространство на диске. Сколько освободилось после очистки.
5. Пришлось пожертвовать цветными текстами в консоле.
6. Ну и сократить код почти в 2 раза, так как большое кол-во кода было из за цветных символов.
7. Добавил ожидание отработки отдельных процессов. Пока не завершатся, сам скрипт не завершит свой процесс.
8. Удалил задержку на 30 минут в связи с тем, что есть отработка отдельных процессов.

# ===itsCleanable.bat | Версия 1.0.5:===

1. Удалено сжатие файлов, т.к ухудшается производительность.
2. Удалена очистка корзины, т.к могут возникать проблемы с корзиной.
3. Удалена возможность удалять %WINDIR%\WinSxS\Temp\* - не стоит трогать эту папку.
4. Добавлена возможность запуска отключенной службы в конце скрипта


# ===itsCleanable.bat | Версия 1.0.4:===

06.05.2021 Update

1. В результате тестов на тестовом образе Минек обнаружены следующие временные папки:
2. C:\AMD
3. C:\$Recycle.Bin
4. C:\ProgramData\LANDesk\Temp
5. C:\Users\User\AppData\Local\Temp
6. C:\Users\Администратор\AppData\Local\Temp
7. C:\Intel
8. Данные папки будут удаляться при выполнения скрипта.
9. Удалены лишние команды.
10. Исправлены незначительные ошибки.
11. Произведены тесты на образах:
12. Чистый образ Минек - Результат: Очистка 2.1 GB временных файлов на чистом образе.
13. Чистого образа Минпромторг
14. Чистой системе Windows
15. Ноутбуке Ростелеком

# ===itsCleanable.bat | Версия 1.0.3:===

1. Добавлено отключение службы обновления Windows.
2. Удалено очистка папки Installer
3. del "%WINDIR%\Installer\*" /s /f /q


# ===itsCleanable.bat | Версия 1.0.2:===

1. Удалена возможность удалять теневые копии.
2. %windir%\system32\cmd.exe /c "start VSSADMIN Delete Shadows /All /Quiet"

3. Добавлено очистка диска по следуюшим директориям:
4. del "%WINDIR%\WinSxS\Temp\*" /s /f /q
5. del "%WINDIR%\Installer\*" /s /f /q
6. del "%SystemDrive%\%ProgramData%\Kaspersky Lab\KES\Temp\*" /s /f /q
7. del "%SystemDrive%\%ProgramData%\KasperskyLab\adminkit\1103\$FTCITmp\*" /s /f /q
8. del "%SystemDrive%\%ProgramData%\Intel\Logs\*" /s /f /q
9. del "%SystemDrive%\%ProgramData%\Intel\Package Cache\*" /s /f /q
10. del "%SystemDrive%\%ProgramData%\Crypto Pro\Installer Cache\*" /s /f /q
11. del "%SystemDrive%\%ProgramData%\Package Cache\*" /s /f /q
12. del "%SystemDrive%\%ProgramData%\Oracle\Java\installcache_x64\*" /s /f /q
13. del "%SystemDrive%\%ProgramData%\LANDesk\Log\*" /s /f /q
14. del "%SystemDrive%\SWSetup\*" /s /f /q
15. del "%SystemDrive%\MSOCache\All Users\*" /s /f /q

16. Результат: Очистка 3.3 GB на ноутбуке.

# ===itsCleanable.bat | Версия 1.0.1:===

01. Добавлена цветная консоль
1. Спрашивает, запускать то или иное действие (Настраиваемо).
2. Добавлена очистка диска по следующим директориям:
3. del "C:\Windows\Logs\*" /s /f /q
4. del "%WINDIR%\Temp\*" /s /f /q
5. del "%USERPROFILE%\AppData\Local\Temp\*" /s /f /q
6. del "C:\Windows\SoftwareDistribution\Download\*" /s /f /q
7. del "C:\ProgramData\Microsoft\Diagnosis\*" /s /f /q
8. %windir%\system32\cmd.exe /c "start VSSADMIN Delete Shadows /All /Quiet"
9. del "%SystemDrive%\Program Files (x86)\LANDesk\LDClient\sdmcache\*" /s /f /q

02. Добавлена стандартная очистка диска в отдельной консоли
1. %windir%\system32\cmd.exe /c "start cleanmgr /sageset:64539
2. %windir%\system32\cmd.exe /c "start cleanmgr /sagerun:64539
3. cleanmgr.exe /SETUP

03. Добавлена диагностика и сканирование системы, обновление политиков:
1. %windir%\system32\cmd.exe /c "start DISM /Online /Cleanup-Image /RestoreHealth
2. %windir%\system32\cmd.exe /c "start sfc /scannow
3. %windir%\system32\cmd.exe /c "start gpupdate /force

04. Добавлено сжатие файлов:
1. Compact /c /s "C:\"
2. Compact /c /s "C:\Users"