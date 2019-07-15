
@echo off
TITLE find User full details - created by Dor Meir

SET /P uname=Please enter User Login:

net user %uname% /DOMAIN | findstr active
dsquery user domainroot -samid %uname% | dsmod user -disabled no
net user %uname% /DOMAIN | findstr active
echo[
echo[
echo %uname% is now unlocked!
echo[
echo[
pause