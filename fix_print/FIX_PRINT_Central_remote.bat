@echo off

TITLE fix boot script by Dor Meir
SET /P password=Please enter advice password and press Enter: 
SET /P user=Please enter the user name with the problem and press Enter: 
echo looking for the user's computer -
SET Logged_user=1
SET PC_user=1
SET computer_IP=1
SET computer_name=1
for /f "tokens=*" %%a in (T:\Dor\Databases\Central_farm_list.txt) do (
	REM SET PC_user=
        wmic /FAILFAST:ON /node:%%a netlogin get name | findstr CC 
REM %user% REM > users.txt | echo %%a
	IF %PC_user%==%user% (
		SET computer_IP=%%a
		SET computer_name=nbtstat -A %%a | findstr UNIQUE
		echo the user's computer is:
		echo %computer_name%
		) ELSE (SET /P computer_name=the script didn't find the user's computer, enter the user's computer:)
)
pause
REM"T:\Dor\scripts and commands\PSTools\PsLoggedon.exe" -l %user% | findstr locally
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
echo 3) Adding Central_farm Printer
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






 
