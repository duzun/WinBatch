@echo off
cls
Title Renew network connections . . .
color 1F 
Echo -----------------------------------
ipconfig /release
Echo -----------------------------------
ipconfig /flushdns
Echo -----------------------------------
ipconfig /renew
Echo -----------------------------------

wait 15
exit
