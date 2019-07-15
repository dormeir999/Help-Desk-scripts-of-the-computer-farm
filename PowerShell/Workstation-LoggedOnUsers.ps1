##########################################################################
$comments = @'
Author			Kevin Higgins
Date			3192009; 242014
FileName 		Workstation-LoggedOnUsers.ps1
Purpose		Import list of ComputerNames or IP addresses from txt file and get log on information from the imported list.				
Note			This script is a subsection of WorkstationInfo.ps1, a 573 line script which gets hardware and other useful info from computers.
Prerequisite	Workstation-LoggedOnUsers.txt
	Example1	ComputerName1
				ComputerName2
				EOF
					
	Example2	10.200.31.90
				10.200.31.135
				EOF
'@
##########################################################################
function CheckForWMI {
	#The line below checks for WMI, if no WMI then the command failed, which makes $ = false. The out-null kills any screen output.
	trap {; Continue}; $ScriptWin32_ComputerSystem = GWMI Win32_ComputerSystem -ea SilentlyContinue -computer $computername
	if ($ -eq $False) {$ScriptHasWMI = $FALSE} else {$ScriptHasWMI = $TRUE}
}
##########################################################################
function Get-ComputerLoggedOnCurrently {
	$ScriptComputerLoggedOnCurrently = $Win32_ComputerSystem.UserName;
	if ($ComputerLoggedOnCurrently -eq "") {$ComputerLoggedOnCurrently = ---}
}
##########################################################################
function TwoHalfLines {1..2  % {for ($i=0;$i -lt $width2; $i++) {Write-host -f cyan - -nonewline;};write-host ;} }
##########################################################################
function Get-IPorComputerNameFromDNS {
	param($computer)
	if ($computer -match ^d ) {
		$Scriptip = $computer
		trap {; continue}; $ScriptDnsResult = [System.Net.Dns]GetHostByAddress($Computer) 
		trap {; continue}; $ScriptComputerName = $DnsResult.HostName.split(.)[0]	
	} else {
		$ScriptComputerName = $computer
		trap {; continue}; $ScriptDnsResult = [System.Net.Dns]GetHostByName($Computer)
		trap {; continue}; $Scriptip = $DnsResult.AddressList[0].IpAddressToString
	}
}
##########################################################################
function ProcessListOfComputers {
	$ComputerName = $null;
	$ScriptComputerNameList = $(get-content $ComputerListLocation)
	$ScriptComputerNameListCount = $ComputerNameList.Length
	$ScriptComputerListNumber = 0;
	$ComputerName = $ComputerNameList[$ComputerListNumber]
	if ($ComputerName -eq ) {
		do {
			$ScriptComputerListNumber++
			$ScriptComputerName = $ComputerNameList[$ComputerListNumber]
		} until ($ComputerName -ne $null -or $ComputerName -eq EOF)
	}
	if ($ComputerName -eq EOF) {QuitScript No computers listed in the imported file. red white}
	Get-IPorComputerNameFromDNS $ComputerName
}
##########################################################################
function NextIP {	
	$ScriptComputerListNumber++
	$ScriptComputerName = $ComputerNameList[$ComputerListNumber]
	if ($ComputerListNumber -eq $ComputerNameListCount -or $ComputerName -eq EOF) {$Scriptstop = $TRUE}
	Get-IPorComputerNameFromDNS $ComputerName
}
##########################################################################
##########################################################################
Clear-Host
$ComputerListLocation = T:\Dor\Databases\Central_farm_list.txt
if ((Test-Path $ComputerListLocation) -eq $FALSE) {Add-Content -Path $ComputerListLocation -value `nEOF}
$ping = New-Object System.Net.NetworkInformation.Ping
$width = $Host.UI.RawUI.BufferSize.width
clear-host
TwoHalfLines
ProcessListOfComputers
do {
	$ScriptComputerLoggedOnCurrently = $null; 
	Write-Host -f yellow IP address`t`t`t`t -nonewline; Write-Host -f green $ip;
	$Processed_IP = $ip
	Write-Host -f yellow Reading information on computer`t -nonewline; write-host -f green $ComputerName;
	$ProcessedComputerName = $computername
	$PingReply = $ping.Send($ip)
	if ($PingReply.status -eq Success) {
		CheckForWMI; start-sleep -m 300
		if ($HasWMI -eq $TRUE) {
			Get-ComputerLoggedOnCurrently
			Write-Host -f yellow Logged On Currently`t`t -nonewline; Write-host -f green `t$ComputerLoggedOnCurrently`n
			$computername = $null			
			NextIP
		} else {write-host -f red `tUnable to access WMI. Computer may not have WMI, or`n`tscript was unable to get a computername from DNS.; $ComputerLoggedOnCurrently = NA - WMI not accessible.; NextIP }
	} else {Write-host -f red `tCan not ping $ComputerName-$ip.; $ComputerLoggedOnCurrently = NA - Computer not pingable.; NextIP }
	
	if ($Results -eq $null) {$Results = ,($Processed_IP,$ProcessedComputerName,$ComputerLoggedOnCurrently)} `
		else {$Results += ,($Processed_IP,$ProcessedComputerName,$ComputerLoggedOnCurrently)}
} until ($stop -eq $TRUE)
TwoHalfLines
1..4  % {write-host `n}
write-host -f green Computer Name`t`tIP Address`t`tLogged on
foreach ($line in $Results) {
	write-host -f yellow $($line[1])`t`t`t$($line[0])`t`t$($line[2])	
}
1..5  % {write-host `n}