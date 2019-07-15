@echo off
for /f "tokens=*" %%a in (list_of_PCs.txt) do (
  echo %%a
  wmic /Node:%%a diskdrive list brief /format:list | findstr Model
)
pause
