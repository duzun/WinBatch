@ECHO off

set _mk=HKCU\Software\Microsoft\Office\
set _mo=10 11 12 13
set _mp=Word Excel Access PowerPoint Outlook

for %%i in (%_mo%) do ( reg query %_mk%%%i.0>nul
  if not errorlevel 1 for %%j in (%_mp%) do ( reg query %_mk%%%i.0\%%j >nul 
     if not errorlevel 1 ( 
         reg add %_mk%%%i.0\%%j\Options /v NoReReg /t REG_DWORD /d 1 /f > nul
     )
  )
)

set _mk=
set _mo=
set _mp=