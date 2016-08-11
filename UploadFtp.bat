@echo off
echo user <Username> > ftp.tmp
echo <pass> >> ftp.tmp
echo bin >> ftp.tmp
echo cd <dir> >> ftp.tmp
echo put|get <filename>  >> ftp.tmp
echo quit >> ftp.tmp
ftp -n -s:ftp.tmp <ftp://URI/>
del ftp.tmp
