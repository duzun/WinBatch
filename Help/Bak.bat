@ECHO off
rem --------------------------------------------------------------------------
rem Ver 5
rem Date: 07.10.2008, 21:00
rem --------------------------------------------------------------------------
if     '%1'=='/goto' goto %2
if not '%1'=='/goto' goto smain
goto end
rem --------------------------------------------------------------------------
:defaults
rem Defaults   

if "%bak_ext%."    =="." set bak_ext=ppr, prj, pas, c, h, cpp, php, inc, js, bat, cmd, ini, inf, csv, xls, doc, htm, html, exe, dpr, dfm
if "%bak_upx%."    =="." set bak_upx=exe, com, dll, w?x, bpl  
if "%bak_clean%."  =="." set bak_clean=ex~, ~???, tmp, dcu, ddp, dof, tds, qst, fpd, sym, ilc, ild, tds, obj, o, ppu
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
    Echo.
    Echo B: BackUp
    Echo P: Pack (Rar)
    Echo X: Pack EXEs (Upx)
    Echo D: Double
    Echo C: Clean ~temp
    Echo A: ALL (BackUp and Double)
    Echo.
    Echo.
    Echo M: Make setting files
    Echo U: Copy %bak_main% to upper dirs
REM     Echo I: Init vars
REM     Echo S: Show vars
REM     Echo V: Cleanse vars
    Echo.
    Echo E: Exit
    choice /C:ecbdpxmusvia /T:e,%bak_timeout% /N 
    cls    
    set bak_timeout=3
    if not errorlevel 2  ( %bak_func% end        & exit )
    if not errorlevel 3  ( %bak_func% clean      & goto menu )
    if not errorlevel 4  ( %bak_func% bak        & goto menu )
    if not errorlevel 5  ( %bak_func% dbl        & goto menu )
    if not errorlevel 6  ( %bak_func% pak        & goto menu )
    if not errorlevel 7  ( %bak_func% upx        & goto menu )
    if not errorlevel 8  ( %bak_func% mkfiles    & goto menu )
    if not errorlevel 9  ( %bak_func% meup       & goto menu )
    if not errorlevel 10 ( %bak_func% show       & goto menu )
    if not errorlevel 11 ( %bak_func% del_vars   & goto menu )
    if not errorlevel 12 ( %bak_func% settings . & goto menu )
    if not errorlevel 13 ( %bak_func% all        & goto menu )  
goto e
rem --------------------------------------------------------------------------    
:main
    %bak_func% settings .
    if '%1'=='/dbl' %bak_func% dbl
    if '%1'=='/bak' %bak_func% bak
    if '%1'=='/pak' %bak_func% pak
    if '%1'=='/upx' %bak_func% upx
    if "%1."=="." %bak_func% menu
goto end
rem --------------------------------------------------------------------------
:smain
    set bak_main=%0
    if '%1'=='/meup' %bak_main% /goto meup . -
    set bak_func=call %bak_main% /goto
    set my_baks=bak_ext, bak_upx, bak_lng, bak_dir, bak_dsk, bak_dbl_dir, bak_dbl, bak_clean
    set bak_timeout=400
    set bak_log=bak_log.txt
        
    if '%1'=='/mkfiles' %bak_func% mkfiles
REM     If Exist Clearn.bat call Clearn.bat
goto main
rem --------------------------------------------------------------------------
:all
    %bak_func% show    
    %bak_func% pak
    %bak_func% dbl
goto e
rem --------------------------------------------------------------------------
:pak
  if not "%3."=="." (
    %bak_func% bak %3
    Echo. & Echo  ~ Packing files . . . ~
    Echo.
    start /wait /D.\Bak /MIN rar -m5 -s a %bak_dir%.rar %bak_dir%
    if exist .\Bak\%bak_dir%.rar rd /S /Q .\Bak\%bak_dir%
    goto e
  )
  %bak_func% pak .      
goto e
rem --------------------------------------------------------------------------
:upx
  if not "%3."=="." (
    Echo. & Echo  ~ UPX EXEs . . . ~
    Echo.
    for %%n in (%bak_upx%) do for %%m in (%3\*.%%n) do if exist "%%m" (
       start /wait /b /high upx -k -9 --best --compress-icons=0 "%%m"
    )
    goto e
  )
  %bak_func% upx .
goto e
rem --------------------------------------------------------------------------
:bak
  if not "%3."=="." (
    rem - Begining bak -----------------------------------------------------------
    if "%3" == "." (
      If not exist .\Bak\. %bak_func% mkfiles .
      if not exist ".\Bak\%bak_dir%\." md ".\Bak\%bak_dir%"
      if not exist ".\Bak\%bak_dir%\." %bak_func% error Unable to create dir: \n %cd%\Bak\%bak_dir%\.
    
          
      Echo. & Echo  ~ Backing Up Files . . . ~
      Echo.
      %bak_func% log_prep
    )
    rem - Current dir bak --------------------------------------------------------


    %bak_func% upx %3
    %bak_func% clean %3 

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
    %bak_func% del_vars
    if "%3."=="." %bak_func% settings .
    if exist ..\%3\Bak.bat call ..\%3\Bak.bat /goto settings ..\%3
    if not exist ..\%3\Bak.bat if exist ..\%3\Bak\. %bak_func% settings ..\%3
    
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
    type %bak_main% > %3\Bak.bat
    %bak_func% recur %3 updirs meup
goto e 
rem --------------------------------------------------------------------------
:log_prep
      echo ------------------------------------------------>>%bak_log%
      echo %date%, %time%>>%bak_log% 
      if exist %bak_log% attrib +h %bak_log%>nul
goto e
rem --------------------------------------------------------------------------
:mkfiles
  if not "%3."=="." (
    if not exist %3\Bak\. (
        md %3\Bak
        attrib +h %3\Bak
    )
    if not exist %3\Bak\. %bak_func% error Unable to create the "Bak" dir!   
    for %%n in (%my_baks%) do if not exist "%3\Bak\%%n.bat" echo set %%n=%%%%n%%> "%3\Bak\%%n.bat"
    if not exist "%3\Bak\bak_subdirs.bat" echo set bak_recur=> "%3\Bak\bak_subdirs.bat"
    if not exist "%3\Bak\bak_updirs.bat" echo set bak_recur=> "%3\Bak\bak_updirs.bat"
    goto e
  )
  %bak_func% mkfiles .
goto e 
rem --------------------------------------------------------------------------
:error
REM  Display error mesages!
REM  Use "\n" to print from a new line
Cls
Echo.
Echo ~   Error!!!   ~
Echo.
set bak_error_msg=
  :error_l
    if "%3"=="\n" (
       if "%bak_error_msg%."=="." set bak_error_msg=.
       Echo %bak_error_msg%
       set bak_error_msg=
    )   
    if not "%3"=="\n" set bak_error_msg=%bak_error_msg%%3 
    shift
  if not "%3."=="." goto error_l
  if "%bak_error_msg%."=="." Echo %bak_error_msg%
  set bak_error_msg=
  Echo.
  pause
  %bak_func% end
  exit
goto end 
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
:clean
    if not "%3."=="." (
      If not exist .\Bak\. %bak_func% mkfiles %3
      if not exist %3\Bak\tmp\. md %3\Bak\tmp  
      if not exist %3\Bak\tmp\. goto e 
       
      for %%n in (%bak_clean%) do for %%m in (%3\*.%%n) do if exist "%%m" (
         copy /Y "%%m" %3\Bak\tmp\ > nul
         if not errorlevel 1 (
            del "%%m"
            echo Del: %%m
         )  
      )
      goto e            
    )
    %bak_func% clean .
goto e            
rem --------------------------------------------------------------------------
:del_vars
    set bak_ext=
    set bak_upx=
    set bak_clean=
    set bak_dir=
    set bak_lng=
    set bak_dbl=
    set bak_dbl_dir=
    set bak_dsk=
    set bak_error_msg=
goto e
rem --------------------------------------------------------------------------
:end
    set my_baks=
    set bak_func=
    set bak_log=
    set bak_timeout=
    set bak_main=

rem pause>nul
goto del_vars
rem exit
rem --------------------------------------------------------------------------
:e
