@echo off
@reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Cdrom                    /v "AutoRun"            /t REG_DWORD /f /d 00
@reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v "NoDriveTypeAutoRun" /t REG_DWORD /f /d 255

REM @pause
