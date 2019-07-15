@echo off
echo kaki>T:\Dor\Databases\users.txt
SET /P user=Please enter the user name with the problem and press Enter: 
SET computer=The computer was not found
for /f "tokens=*" %%a in (T:\Dor\Databases\Central_farm_list.txt) do (
  wmic /APPEND:T:\Dor\Databases\users.txt /FAILFAST:on /Node:%%a  netlogin get name 2> nul| "C:\Program Files (x86)\GnuWin32\bin\grep.exe" %user%
  echo %%a>>T:\Dor\Databases\users.txt
)
echo The user's computer is:
"C:\Program Files (x86)\GnuWin32\bin\grep.exe"  -A 6 %user% T:\Dor\Databases\users.txt | "C:\Program Files (x86)\GnuWin32\bin\grep.exe" 132 > tmp.txt
SET /p computer=<tmp.txt
echo %computer%
pause


