@echo off

TITLE fix boot script by Dor Meir
SET /P password=Please enter advice password and press Enter: 
SET /P user=Please enter the user name with the problem and press Enter: 
echo looking for the user's computer -
"T:\Dor\scripts and commands\PSTools\PsLoggedon.exe" -l %user% | findstr locally
echo[
SET /P computer=Please enter the computer and press Enter: 
echo[
echo Fixing %computer%
echo[
echo 1) Disabling Chrome PDF Viewer
echo[
REG ADD \\%computer%\HKLM\Software\Policies\Google\Chrome\DisabledPlugins /v 1 /d "Chrome PDF Viewer"
echo[
echo 2) Updating Group Policy (will take a few secondes)
echo[
"T:\Dor\scripts and commands\PSTools\PsExec.exe" -u CC\advice -p %password% -s \\%computer% gpupdate /force
echo[
echo 3) Adding Social_farm Printer
rundll32 printui.dll,PrintUIEntry /ga /c\\%computer% /n\\msprint\social_Farm
echo[
echo[
echo[
echo we're finished! 
echo Please tell the user to:
echo 1) Download the PDF again 
echo 2) Choose Social_farm printer when printing
echo[
echo[
echo[
pause






 
