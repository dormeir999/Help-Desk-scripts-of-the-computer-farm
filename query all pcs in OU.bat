@echo off
dsquery computer ou=SP,ou=Farms,ou=MS,ou=Workstations,dc=hustaff,dc=huji,dc=local | sort > input.txt
(for /f "tokens=0,* delims="=" %%a in (input.txt) do echo %%b) > output.txt
(for /f "tokens=0,* delims="," %%a in (output.txt) do echo %%b) > output2.txt
