Set-ExecutionPolicy -ExecutionPolicy unrestricted -Scope Localmachine -f
Set-ExecutionPolicy bypass -f
Dism /online /Enable-Feature /FeatureName:RemoteServerAdministrationTools-Roles-AD-Powershell
Import-Module ActiveDirectory
.\streams.exe -s -d .\