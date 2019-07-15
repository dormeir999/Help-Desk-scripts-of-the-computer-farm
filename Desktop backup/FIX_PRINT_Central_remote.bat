@echo off

TITLE fix boot script by Dor Meir
SET /P password=Please enter advice password and press Enter: 
SET /P computer=Please enter computer name and press Enter: 
echo[
echo Disabling Chrome PDF Viewer
REG ADD \\%computer%\HKLM\Software\Policies\Google\Chrome\DisabledPlugins /v 1 /d "Chrome PDF Viewer"
echo[
echo Updating Group Policy (will take a few secondes)
"T:\Dor\scripts and commands\PSTools\PsExec.exe" -u CC\advice -p %password% -s \\%computer% gpupdate /force
echo[
echo Adding Central_farm Printer
rundll32 printui.dll,PrintUIEntry /ga /c\\%computer% /n\\msprint\Central_farm
echo[
echo[
echo[
echo we're finished! 
echo Please tell the user to:
echo 1) Download the PDF again 
echo 2) Choose Central_farm printer when printing
echo[
echo[
echo[
pause






 
