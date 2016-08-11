@echo off
@reg add HKLM\SYSTEM\CurrentControlSet\Services\Cdrom                                        /v "AutoRun"            /t REG_DWORD /f /d 00
@reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDriveTypeAutoRun /v "NoDriveTypeAutoRun" /t REG_DWORD /f /d 181
@reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer                    /v "NoDriveTypeAutoRun" /t REG_DWORD /f /d 181

REM 128 +    + 32 + 16 +   + 4 +   + 1 = 1011 0101 = 181 = B5

REM @pause
