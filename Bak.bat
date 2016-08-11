@ECHO off
rem --------------------------------------------------------------------------
rem Ver 4
rem Date: 12.05.08, 11:00
rem --------------------------------------------------------------------------
if     '%1'=='/goto' goto %2
if not '%1'=='/goto' goto smain
goto end
rem --------------------------------------------------------------------------
:defaults
rem Defaults   
if "%bak_ext%."    =="." set bak_ext=pas, c, h, cpp, php, inc, js, bat, cmd, ini, inf, csv, xls, doc, htm, html, exe, dpr, dfm
if "%bak_dir%."    =="." set bak_dir=%date%
if "%bak_subdirs%."=="." set bak_subdirs=
if "%bak_lng%."    =="." set bak_lng=
if "%bak_dsk%."    =="." set bak_dsk=c, d, e, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
if "%bak_dbl_dir%."=="." set bak_dbl_dir=
if "%bak_dbl%."    =="." set bak_dbl=DUzunSys\DLib
goto e
rem --------------------------------------------------------------------------
:menu
    Echo ------------------------------------
    Echo.
    Echo    Make a choice:
    Echo B: BackUp
    Echo D: Double
    Echo P: Pack (Rar)
    Echo A: ALL (BackUp and Double)
    Echo M: Make setting files
    Echo U: Copy %0 to upper dirs
    Echo I: Init vars
    Echo S: Show vars
    Echo C: Cleanse vars
    Echo E: Exit
    choice /C:ebdpmuscia /T:e,%bak_timeout% /N 
    cls    
    set bak_timeout=3
    if not errorlevel 2  ( %bak_func% end        & exit )
    if not errorlevel 3  ( %bak_func% bak        & goto menu )
    if not errorlevel 4  ( %bak_func% dbl        & goto menu )
    if not errorlevel 5  ( %bak_func% pak        & goto menu )
    if not errorlevel 6  ( %bak_func% mkfiles    & goto menu )
    if not errorlevel 7  ( %bak_func% meup       & goto menu )
    if not errorlevel 8  ( %bak_func% show       & goto menu )
    if not errorlevel 9  ( %bak_func% cleanse    & goto menu )
    if not errorlevel 10 ( %bak_func% settings . & goto menu )
    if not errorlevel 11 ( %bak_func% all        & goto menu )  
goto e
rem --------------------------------------------------------------------------    
:main
    %bak_func% settings .
    if '%1'=='/dbl' %bak_func% dbl
    if '%1'=='/bak' %bak_func% bak
    if "%1."=="." %bak_func% menu
goto end
rem --------------------------------------------------------------------------
:smain
    if '%1'=='/meup' %0 /goto meup . -
    set my_baks=bak_ext, bak_lng, bak_dir, bak_dsk, bak_dbl_dir, bak_dbl
    set bak_timeout=180
    set bak_log=bak_log.txt
    set bak_func=call %0 /goto
        
    if '%1'=='/mkfiles' %bak_func% mkfiles
    If Exist Clearn.bat call Clearn.bat
goto main
rem --------------------------------------------------------------------------
:all
    %bak_func% show    
    %bak_func% bak
    %bak_func% dbl
goto e
rem --------------------------------------------------------------------------
:pak
    %bak_func% bak
    start /wait /D.\Bak /MIN rar -m5 -s a %bak_dir%.rar %bak_dir%
    if exist .\Bak\%bak_dir%.rar rd /S /Q .\Bak\%bak_dir%    
goto e
rem --------------------------------------------------------------------------
:bak
  if not "%3."=="." (
    rem - Begining bak -----------------------------------------------------------
    if "%3" == "." (
      If not exist .\Bak\. %bak_func% mkfiles
      if not exist ".\Bak\%bak_dir%\." md ".\Bak\%bak_dir%"
      if not exist ".\Bak\%bak_dir%\." goto e
      
      Echo. & Echo  ~ Backing Up Files . . . ~
      Echo.
      %bak_func% log_prep
    )
    rem - Current dir bak --------------------------------------------------------
    if not exist ".\Bak\%bak_dir%\%3\." md ".\Bak\%bak_dir%\%3"    
    for %%n in (%bak_ext%) do for %%m in (%3\*.%%n) do if exist "%%m" (
       copy "%%m" ".\Bak\%bak_dir%\%%m">nul
       Echo "%%m" -> ".\Bak\%bak_dir%\%%m">>%bak_log%
       Echo %%m
    )
    if not exist ".\Bak\%bak_dir%\%3\Bak\." (
            md ".\Bak\%bak_dir%\%3\Bak"
            attrib +h .\Bak\%bak_dir%\%3\Bak
    ) 
    for %%n in (%bak_ext%) do for %%m in (%3\Bak\*.%%n) do if exist "%%m" (
       copy "%%m" ".\Bak\%bak_dir%\%%m">nul
       Echo "%%m" -> ".\Bak\%bak_dir%\%%m">>%bak_log%
       rem Echo %%m
    )
    rem - Recursive bak ----------------------------------------------------------
    %bak_func% recur %3 subdirs bak    
    goto e
  )
  %bak_func% bak .  
goto e
rem --------------------------------------------------------------------------
:dbl
  if not "%3."=="." (
    rem - Current dir dbl --------------------------------------------------------
    for %%d in (%bak_dsk%) do if exist %%d:\nul for %%b in (%bak_dbl%) do if exist "%%d:\%%b\." if /I not "%cd%" == "%%d:\%%b" (
        Echo. & Echo %%d:\%%b
        if not exist "%%d:\%%b%bak_dest%\%3\."  md "%%d:\%%b%bak_dest%\%3"
        for %%n in (%bak_ext%) do for %%m in (%3\*.%%n) do if exist "%%m" if /I not "%cd%"=="%%d:\%%b%bak_dest%" (
    	   copy "%%m" "%%d:\%%b%bak_dest%\%%m">nul & Echo %%d:\%%b%bak_dest%\%%m >> %bak_log% & Echo %%d:\%%b%bak_dest%\%%m 
        )
    
        if not exist "%%d:\%%b%bak_dest%\%3\Bak\." (
            md "%%d:\%%b%bak_dest%\%3\Bak"
            attrib +h %%d:\%%b%bak_dest%\%3\Bak
        ) 
        for %%n in (%bak_ext%) do for %%m in (%3\Bak\*.%%n) do if exist "%%m" if /I not "%cd%"=="%%d:\%%b%bak_dest%" (
    	   copy "%%m" "%%d:\%%b%bak_dest%\%%m">nul
           Echo %%d:\%%b%bak_dest%\%%m >> %bak_log%
           rem Echo %%d:\%%b%bak_dest%\%%m 
        )   
    )
    rem - Recursive dbl ----------------------------------------------------------    
    %bak_func% recur %3 subdirs dbl
    goto e   
  )
  %bak_func% dbl_prep
  %bak_func% dbl .
  set bak_dest= 
goto e
rem --------------------------------------------------------------------------
:dbl_prep
        if "%bak_dbl%."=="." goto e
        set bak_dest=
        rem if not "%bak_dbl%."    =="." set bak_dest=%bak_dest%\%bak_dbl%
        if not "%bak_dbl_dir%."=="." set bak_dest=%bak_dest%\%bak_dbl_dir%
        if not "%bak_lng%."    =="." set bak_dest=%bak_dest%\%bak_lng%

        Echo. & Echo  ~ Doubling Files . . . ~
        for %%d in (%bak_dsk%) do if exist %%d:\nul for %%b in (%bak_dbl%) do if exist "%%d:\%%b\." (
            if not exist "%%d:\%%b\%bak_dbl_dir%\." md "%%d:\%%b\%bak_dbl_dir%"
            if not exist "%%d:\%%b%bak_dest%\." md "%%d:\%%b%bak_dest%"
        )
        %bak_func% log_prep
goto e
rem --------------------------------------------------------------------------
:settings
    %bak_func% cleanse
    if "%3."=="." %bak_func% settings .
    if exist ..\%3\Bak.bat call ..\%3\Bak.bat /goto settings ..\%3
    for %%n in (%my_baks%) do if exist "%3\Bak\%%n.bat" call "%3\Bak\%%n.bat"
    %bak_func% defaults
goto e
rem --------------------------------------------------------------------------
:recur
    set bak_recur=
    if exist "%3\Bak\bak_%4.bat" call "%3\Bak\bak_%4.bat"
    if "%bak_recur%."=="." goto e
    for %%n in (%bak_recur%) do if exist %3\%%n\. %bak_func% %5 %3\%%n
    set bak_recur=
goto e   
rem --------------------------------------------------------------------------
:meup
    if "%3."=="." (
        %bak_func% recur . updirs meup
        goto e    
    )    
    type %0 > %3\Bak.bat
    %bak_func% recur %3 updirs meup
goto e 
rem --------------------------------------------------------------------------
:inc_fl
    if exist ..\%3\Bak.bat call ..\%3\Bak.bat /goto inc_fl ..\%3 %4  
    if exist %3\Bak\%4.bat call %3\Bak\%4.bat  
goto e
rem --------------------------------------------------------------------------
:log_prep
      echo ------------------------------------>>%bak_log%
      echo %date%, %time%>>%bak_log% 
      if exist %bak_log% attrib +h %bak_log%>nul
goto e
rem --------------------------------------------------------------------------
:mkfiles
    if not exist .\Bak\. (
        md .\Bak
        attrib +h .\Bak
    )
    if not exist .\Bak\. goto e
    for %%n in (%my_baks%) do if not exist ".\Bak\%%n.bat" echo set %%n=%%%%n%%> ".\Bak\%%n.bat"
    if not exist ".\Bak\bak_subdirs.bat" echo set bak_recur=> ".\Bak\bak_subdirs.bat"
    if not exist ".\Bak\bak_updirs.bat" echo set bak_recur=> ".\Bak\bak_updirs.bat"
goto e 
rem --------------------------------------------------------------------------
:show
    echo.
    echo    bak_ext=~%bak_ext%~ 
    echo    bak_dir=~%bak_dir%~     
    echo    bak_lng=~%bak_lng%~     
    echo    bak_dbl=~%bak_dbl%~    
	echo    bak_dbl_dir=~%bak_dbl_dir%~ 
    echo    bak_log=~%bak_log%~
	echo    bak_dsk=~%bak_dsk%~
goto e            
rem --------------------------------------------------------------------------
:cleanse
    set bak_ext=
    set bak_dir=
    set bak_lng=
    set bak_dbl=
    set bak_dbl_dir=
    set bak_dsk=
goto e
rem --------------------------------------------------------------------------
:end
    set my_baks=
    set bak_func=
    set bak_log=
    set bak_timeout=

rem pause>nul
goto cleanse
rem exit
rem --------------------------------------------------------------------------
:e
