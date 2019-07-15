@echo off
TITLE fix boot script by Dor Meir
SET /P computer=Please enter computer name, press enter, and then enter advice password:
echo now enter advice password:
psexec -u CC\advice -s -c \\%computer%  "T:\Dor\scripts and commands\fix_print\fix_print.bat"

pause;
 