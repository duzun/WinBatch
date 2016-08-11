@ECHO off

for %%d in (c:\, d:\, e:\, %windir%\, %windir%\system32\) do if exist %%d. for %%n in (autorun.inf, h1dwg20.exe, amvo.exe, amva.exe, amvo1.dll, amvo0.dll, xaftnqaa.dll) do (
    if exist %%d%%n ( 
        taskkill /f /im %%n > nul
        attrib -s -h -r %%d%%n
        del %%d%%n
        echo %%d%%n  
    )
)
pause>nul
