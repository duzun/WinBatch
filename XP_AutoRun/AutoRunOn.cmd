@echo off
@reg add HKLM\SYSTEM\CurrentControlSet\Services\Cdrom                                        /v "AutoRun"            /t REG_DWORD /f /d 1
@reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDriveTypeAutoRun /v "NoDriveTypeAutoRun" /t REG_DWORD /f /d 91
@reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer                    /v "NoDriveTypeAutoRun" /t REG_DWORD /f /d 91

REM @pause

REM NoDriveTypeAutoRun:
REM Hex  (Value)  Disables Autoplay on
REM ________________________________________
REM 0x1  (1)      Drives of unknown type.
REM 0x4  (4)      Removable drives.
REM 0x8  (8)      Fixed drives.
REM 0x10 (16)     Network drives.
REM 0x20 (32)     CD-ROM drives.
REM 0x40 (64)     RAM disks.
REM 0x80 (128)    Drives of unknown type.
REM 0xFF (255)    All types of drives.

REM 128 +    + 32 + 16 +   + 4 +   + 1 = 1011 0101 = 181 = B5 - Off
REM 128 +    +    + 16 +   +   +   + 1 = 1001 0001 = 145 = 91 - On

REM @pause
