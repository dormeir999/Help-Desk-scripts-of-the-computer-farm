@echo off
for /f "tokens=*" %%a in (T:\Dor\Databases\Central_farm_list.txt) do (
  echo %%a
  wmic /Node:%%a /FAILFAST:on netlogin get name | findstr dormei
)
pause
