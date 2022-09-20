$AllServers = Import-Csv -Path "C:\wsad.csv" -Encoding UTF8

$table = @()

foreach ($server in $AllServers) {
$Admins = Invoke-Command -ComputerName $server.name -ScriptBlock{Get-LocalGroupMember -Name 'Administrators'}
$RemoteDesktopUsers = Invoke-Command -ComputerName $server.name -ScriptBlock{Get-LocalGroupMember -Name 'Remote Desktop Users'}
$PowerUsers = Invoke-Command -ComputerName $server.name -ScriptBlock{Get-LocalGroupMember -Name 'Power Users'}

$table += $Admins | Select-Object PSComputerName,RunspaceId,Name,SID,PrincipalSource,ObjectClass, @{l="ComputerName";e={"Administrators"}}
$table += $RemoteDesktopUsers | Select-Object PSComputerName,RunspaceId,Name,SID,PrincipalSource,ObjectClass, @{l="ComputerName";e={"RemoteDesktopUsers"}}
$table += $PowerUsers | Select-Object PSComputerName,RunspaceId,Name,SID,PrincipalSource,ObjectClass, @{l="ComputerName";e={"PowerUsers"}}
}

$table |  Export-Csv -Path "C:\Result.csv" -NoTypeInformation
