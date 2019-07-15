
@echo off
TITLE Hostname IPV4 and MAC of PC list - created by Dor Meir
SET /P password=Please enter advice password:
copy nul>raw_data.txt
psexec -u CC\advice -p %password% -s @PC_list.txt ipconfig /all >> raw_data.txt
findstr "Host IPv4 Physical" raw_data.txt > Hostname_IPv4_MAC.txt
type Hostname_IPv4_MAC.txt
Hostname_IPv4_MAC.txt
pause
  