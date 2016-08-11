@ECHO off

set _rise=RESTORE\S-1-5-21-1482476501-1644491937-682003330-1013\rise.exe 

call reg delete "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{28ABC5C0-4FCB-11CF-AAX5-21CX1C642131}" /v StubPath /f >nul

for %%d in (c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%d:\nul (
  if exist "%%d:\%_rise%" (
    set found_rise=%%d:\%_rise%
    echo.-------------------------------------
    echo %%d:\%_rise%
    taskkill /f /im rise.exe >nul 
    del /F "%%d:\%_rise%"
  )  
)

%0

:end
set _rise=
pause>nul
