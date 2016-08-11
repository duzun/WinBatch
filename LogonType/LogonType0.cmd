rem Classic 2000 Logon Type
@reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v LogonType /d 0 /f
