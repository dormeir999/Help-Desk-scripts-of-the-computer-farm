@echo off
TITLE fix boot script by Dor

echo add Social_farm Printer
rundll32 printui.dll,PrintUIEntry /in /n\\msprint\social_Farm
	
echo Disable Chrome PDF Viewer
REG ADD HKLM\Software\Policies\Google\Chrome\DisabledPlugins /v 1 /d "Chrome PDF Viewer"

echo Update chrome policy, this will take 8 secondes
gpupdate /force

echo make social_farm the default printer
rundll32 printui.dll,PrintUIEntry /y /n\\msprint\social_Farm

echo we're finished!
pause;


