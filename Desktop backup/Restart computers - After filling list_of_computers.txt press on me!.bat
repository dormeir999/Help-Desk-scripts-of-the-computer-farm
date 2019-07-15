@echo off
TITLE Restart a list of computers
echo 
echo Please fill in a list of computers in list_of_computers.txt, 
echo One computer in each line, and then press enter to restart them.
pause
echo Restarting the list of computers in list_of_computers.txt:
psshutdown  -r -f -t 00 @list_of_computers.txt
pause