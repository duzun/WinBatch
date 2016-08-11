@echo off

if "%1"=="/func" goto %2 || goto e
set cd="%~dp0"
set me="%~dpnx0"
if "%1"=="/meup" goto meup
if "%1"=="/cllog" goto cllog
set ftp_func=call %0 /func
%ftp_func% clear

set ftp_cmd=put
if "%1"=="/del" goto del
if "%1"=="/get" goto get
if "%1"=="/put" goto put
if "%1"=="/fls" goto fls
goto l0

:del
shift
set ftp_cmd=delete
goto l0

:put
shift
set ftp_cmd=put
goto l0

:get
shift
set ftp_cmd=get
goto l0

:fls
shift
set ftp_slf=1
goto l0
:fls1
attrib -s -h %cd%\srv_fls.cmd>nul
echo set ftp_files=%ftp_params%> %cd%\srv_fls.cmd
attrib +h +s %cd%\srv_fls.cmd>nul
set ftp_slf=
goto clear

:meup
if not "%2."=="." set cd=%2
attrib -h ftp_log.txt>nul
echo ~ MeUp ~ >ftp_log.txt
for /R %cd% %%i in (%~nx0) do if exist "%%i" if not '%~dpnx0'=='%%i' ( echo %%i>>ftp_log.txt && copy %0 "%%i">>ftp_log.txt )
attrib +h ftp_log.txt>nul
goto clear

:cllog
if not "%2."=="." set cd=%2
echo ~ MeUp ~ >ftp_log.txt
for /R %cd% %%i in (ftp_log.txt) do (
  attrib -s -h "%%i">nul 
  if exist "%%i" ( echo %%i && del /f /q "%%i")
)
goto clear

:l0
set ftp_params=
:params
if '%1.'=='.' goto l1
set ftp_params=%ftp_params% %1
shift
goto params

:l1
if not "%ftp_slf%."=="." goto fls1
%ftp_func% cfg %cd%.
if exist %cd%\srv_fls.cmd call %cd%\srv_fls.cmd
%ftp_func% prep
echo Commands: /fls {wildcards} ; /meup [dir] ; /cllog [dir] && echo.
%ftp_func% show_vars
if "%ftp_log%."=="." goto l3
if "%ftp_params%."=="." goto l2
%ftp_func% mk_tmp
%ftp_func% call_ftp
goto clear

:l2
Echo.
Echo No params
pause>nul
goto e

:l3
goto e

:mk_tmp
echo user %ftp_log% > %ftp_tmp%
echo bin >> %ftp_tmp%
echo mkdir %ftp_dir% >> %ftp_tmp%
echo cd %ftp_dir% >> %ftp_tmp%
for %%i in (%ftp_params%) do echo %ftp_cmd% %%i >> %ftp_tmp%
echo put %me% >> %ftp_tmp%
echo quit >> %ftp_tmp%
goto e

:find_tmp
if %3.==. goto e
shift
set ftp_tmp=%ftp_tmp_name%%2.tmp
if exist %ftp_tmp% goto find_tmp
goto e

:prep
if "%ftp_log%."=="." goto error_cfg
if "%ftp_uri%."=="." goto error_cfg
if "%ftp_tmp_name%."=="." set ftp_tmp_name=tmp%\ftp_tmp
call %0 %1 find_tmp 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
set ftp_dir=%_srv_root%/%ftp_dir%
if "%ftp_params%."=="." set ftp_params=%ftp_files%
goto e

:cfg
REM srv_cfg.cmd:
REM set _srv_root=
REM set ftp_tmp_name=%tmp%\ftp_tmp
REM set ftp_uri=ftp.address
REM set ftp_log=username password
if exist %~dpnx3\srv_cfg.cmd call %~dpnx3\srv_cfg.cmd
if not "%ftp_log%."=="." if not "%ftp_uri%."=="." goto e
set ftp_dir=%~nx3/%ftp_dir%
if not '%~p3'=='\' call %0 %1 %2 %~dp3. 
goto e

:show_vars
echo ftp_params   = %ftp_params%   && echo.
echo ftp_files    = %ftp_files%    && echo.
echo ftp_cmd      = %ftp_cmd%      && echo.
REM echo _srv_root    = %_srv_root%    && echo.
REM echo ftp_uri      = %ftp_uri%      && echo.
REM echo ftp_log      = %ftp_log%      && echo.
REM echo ftp_tmp_name = %ftp_tmp_name% && echo.
echo ftp_tmp      = %ftp_tmp%      && echo.
echo ftp_dir      = %ftp_dir%      && echo.
goto e

:error_cfg
Echo Error in config:
%ftp_func% show_vars
pause>nul
goto clear

:call_ftp
attrib -h ftp_log.txt>nul
ftp -n -s:%ftp_tmp% %ftp_uri%>ftp_log.txt
attrib +h ftp_log.txt>nul
del %ftp_tmp%
goto e

:clear
set ftp_params=
set ftp_files=
set ftp_cmd=
set _srv_root=
set ftp_uri=
set ftp_log=
set ftp_dir=
set ftp_tmp=
set ftp_tmp_name=
goto e

:e
