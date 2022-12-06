Внимание, кодировка по стандарту для нормальной работы скриптов 866. По этому на gitHub может отображаться не корректно!

# Запускаем itsCleanable START.bat от имени Администратора.
Обязательно должны лежать рядом itsCleanable.bat и itsDiagnostic.bat

# ===itsCleanable.bat + itsDiagnostic.bat | Версия 1.1.12 :===
1. %SystemDrive% заменил на диск C:

# ===itsCleanable.bat + itsDiagnostic.bat | Версия 1.1.11 :===
20.05.2021
1.1 Добавлен сценарий. Диагностика теперь работает опционально. Спрашивает, нужно ли проводить диагностику перед запуском скрипта.
1.2 Если соглашаешься, с начало производиться очистка диска, затем диагностика.
1.3 Если отказываешься, то производиться только очистка диска.

# ===itsCleanable.bat + itsDiagnostic.bat | Версия 1.0.10 :===
18.05.2021
1. Удаление Кеша в Касперском по директории %SystemDrive%\ProgramData\Kaspersky Lab\KES\Cache
2. Удаление временных файлов СекретНета patch.exe по директории %SystemDrive%\ProgramData\Security Code\Secret Net Studio\localcache\patch.exe
3. Удаление дампов и логов %SystemDrive%\ProgramData\VMware\VDM\logs и %SystemDrive%\ProgramData\VMware\VDM\Dumps
4. Удаление временных файлов по директории %SystemDrive%\ProgramData\Veeam\Setup\Temp\*
5. Удаление кеша и логов по директориям:
5.1. %WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache
5.2. %WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Logs
6. Удаление временных файлов в %WINDIR%\Installer\$PatchCache$
7. Удаление временных файлов драйверов Рутокена по директории %SystemDrive%\ProgramData\Aktiv Co\
8. Удаление временных файлов %SystemDrive%\ProgramData\Crypto Pro\Installer Cache
9. Удаление временных файлов %SystemDrive%\\ProgramData\USOShared\Logs
10. Удаление установочных файлов по директории:
10.1. del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\browser.7z" /s /f /q
10.2. del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\brand-package.cab" /s /f /q
10.3. del "%USERPROFILE%\AppData\Local\Yandex\YandexBrowser\Application\setup.exe" /s /f /q

11. Удаление Кеша поиска Windows:

12. Остановка службы Windows Search
12.1. net stop "Windows Search"
12.2. REG ADD "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
12.3. del %PROGRAMDATA%\Microsoft\Search\Data\Applications\Windows\Windows.edb
12.4. net start "Windows Search"

13. Остановка не нужных служб
13.1. echo XBOX
13.2. net stop "Xbox Accessory Management Service"
13.3. echo Телефония 
13.4. net stop "net stop "TapiSrv""
13.5. echo Биометрическая служба Windows
13.6. net stop "WbioSrvc"
13.7. echo Диспетчер проверки подлинности Xbox Live
13.8. net stop "XblAuthManager"
13.9. echo Родительский контроль
13.10. net stop "WpcMonSvc"
13.11. echo Сетевая служба Xbox Live
13.12. net stop "XboxNetApiSvc"
13.13. echo Служба Windows License Manager
13.14. net stop "LicenseManager"
13.15. echo Windows Mobile Hotspot
13.16. net stop "icssvc"
13.17. echo Служба демонстрации магазина
13.18. net stop "RetailDemo"
13.19. echo Служба управления радио
13.20. net stop "RmSvc"
13.21. echo Факс
13.22. net stop "Fax"

# ===itsCleanable.bat + itsDiagnostic.bat | Версия 1.0.9 :===
1. Добавлен текст перед запуском программы.
2. Теперь когда скрипт запускается, он считывает директорию и копирует скрипты в корень диска. По окончанию он их удаляет.
3. Добавлены цветные текста в основном скрипте START.bat
4. Все логи теперь храняться в LogsCache.
5. Все логи теперь имеют дату и время в формате: %date:~0,2%-%date:~3,2%-%date:~8,2%_%mytime%
6. Скрипт itsCleanable.bat выдает особые права (Повышенные права) на папки и файлы, которые собирается удалять.
7. Удаление папки по директории: 'C:\Windows10Upgrade'
8. Удаление папки по директории: 'C:\$WINDOWS.~BT'



# ===itsCleanable.bat + itsDiagnostic.bat | Версия 1.0.7:===
1. Добавлена новая команда на очистку директории:
2. del "C:\logs\" /s /f /q

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

1. В результате тестов на тестовом образе обнаружены следующие временные папки:
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
12. Чистой системе Windows

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
