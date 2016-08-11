@ECHO off
set vir_files=amvo0.dll, autorun.inf, xyw9tmdj.com
set vir_dirs=%windir%, %windir%\system32, c:, d:, e:, h:, i:, j:, k:, l:, m:, n:, o:, p:, q:, r:, s:, t:, u:, v:, w:, x:, y:, z:
  
REM for %%n in (%vir_files%) do start /wait taskkill /f /im %%n 

for %%d in (%vir_dirs%) do if exist %%d\. (
REM   Echo  - %%d
  for %%n in (%vir_files%) do (
    if exist "%%d%\%n" ( 
        echo %%d\%%n  
REM         start /wait taskkill /f /im %%n 
        attrib -s -h -r +a "%%d\%%n" > nul
        del /F /Q "%%d\%%n"
    )
  )  
)

set vir_dirs=
set vir_files=
REM pause
