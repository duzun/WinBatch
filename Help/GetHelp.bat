@ECHO off

set hlp=help.txt
if exist %hlp% del %hlp%>nul

if '%1.'=='.' %0 md cd rd dir copy ren type del if for rem set shift echo break prompt

:loop
if '%1.'=='.' goto end

Echo *******************************************************************************************>>%hlp%
Echo Comanda: %1 >>%hlp%
Echo. >>%hlp%
%1 /? >>%hlp%

shift
goto loop


:end
set hlp=