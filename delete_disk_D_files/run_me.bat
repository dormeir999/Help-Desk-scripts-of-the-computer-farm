
@echo off
TITLE Delete disk D files - created by Dor Meir
SET /P password=Please enter advice password:
psexec -u CC\advice -p %password%  -c -s @PC_list.txt rmdir.bat
echo all the files in disk D: of the computers in PC_list were deleted!
pause
  