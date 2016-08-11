@ECHO off
set vir_files=ckvo0.dll, ckvo.exe, ev60a2.cmd, amvo0.dll, autorun.inf, xyw9tmdj.com, 0hct8ybw.bat, 188qsm.bat, 3wcxx91.cmd, b.com, d6fagcs8.cmd, ekugb3.bat, ino6.com, mvxm.cmd, oufddh.exe, rthrw.com, v.cmd, x.com, xo8wr9.exe, y82td3td.com, yo2mq6.exe
set vir_dirs=%windir%, %windir%\system32, c:, d:, e:, h:, i:, j:, k:, l:, m:, n:, o:, p:, q:, r:, s:, t:, u:, v:, w:, x:, y:, z:, %0, %1 
  
REM for %%n in (%vir_files%) do start /wait taskkill /f /im %%n 

for %%d in (%vir_dirs%) do if exist %%d\. (
  Echo  - %%d
  for %%n in (%vir_files%) do (
    
        echo %%d\%%n  
        rem start attrib -s -h -r +a "%%d\%%n" > nul
        del /F /Q "%%d\%%n"
  )  
)

set vir_dirs=
set vir_files=
pause

