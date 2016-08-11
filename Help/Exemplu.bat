@@rem Toate comentariile vor fi scrise sub declaratie!

@Echo off
@rem Se seteaza regimul de afisare a comenzilor pe ecran la "off", iar simbolul "@" face ca nici aceasta comanda sa nu se afiseze.
Echo
@rem Se afiseaza starea curenta a regimului ECHO
Echo.
@rem Se afiseaza un rand gol
pause
@rem Se asteapta ca utilizatorul sa apese o tasta inainte de a continua
Echo Hello people!
@rem Se va afisa mesajul "Hello people!" pe ecran
Pause>nul
@rem De data aceasta nu se mai afiseaza mesajul explicativ al comenzii
Echo Hello people! > Hello.txt
@rem Se creaza un fisier cu numele "Hello.txt" si continutul "Hello people!" in directoria curenta
CD
@rem Se afiseaza directoria curenta
MD Dimon nomiD
@rem Se creaza doua directorii cu numele "Dimon" si "nomiD"
CD Dimon
@rem Se schimba directoria la "Dimon", pe discul curent
Pause>nul
CD
copy ..\Hello.txt
@rem Se copie fisierul "Hello.txt" din directoriul parinte al celui curent in cel curent
del Hello.txt
@rem Se sterge fisierul "Hello.txt" din directoriul curent
pause>nul
copy ..\Hello.txt .\olleH.txt>nul
@rem Se copie "..\Hello.txt" in directoriul curent cu numele nou "olleH.txt", dar nu se afiseaza mesajul informativ al comenzii
dir
@rem Se afiseaza continutul directoriei curente
copy . ..\nomiD
@rem Se copie continutul directoriei curente in directoria "..\nomiD"
pause>nul
cd ..\nomiD
dir *.txt
@rem Se afiseaza doar fisierele cu extensia "txt"
cd ..
del nomiD
@rem Se sterg toate fisierele din directoria "nomiD"
cd Dimon
RD ..\nomiD
@rem Se sterge directoria nomiD care se afla in directoria ce o contine pe cea curenta
del *.txt>nul
@rem Se sterg fisierele cu extensia "txt" din directoria curenta
cd..
rd Dimon
del Hello.txt>nul
pause>nul
if not exist Dimon\nul echo Dimon o plecat
if exist nomiD\nul Echo nomiD nu vrea sa plece
If '%windir%'=='' Echo Eu nu sunt in Windows
@rem Dupa "if" urmeaza conditia, apoi imediat comanda care se executa daca conditia e true
@rem Pentru conditia "exist", in cazul directoriilor, dupa nume se scrie sau "\nul", sau "\.", pentru a indica ca se cere verificarea existentei unei directorii, nu fisier.
echo.
Echo Numele cu care a fost chemat fisierul curent din prompter este %0
@rem %0-%9... sunt parametrii pasati de la prompter
@rem Parametrii si comanda "Shift" vor fi explicate in alt BAT.
Echo.
echo Aici se incheie executia acestui fisier
Pause

