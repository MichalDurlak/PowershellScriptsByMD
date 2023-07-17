$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer()
$groups = $wsus.GetComputerTargetGroups().Name
 
foreach ($group in $groups){
$filename = "C:\WSUS_Servers\"+$group+".csv"
 
$servers = Get-WsusComputer -ComputerTargetGroups $group
$servers | Select-Object "FullDomainName" | Export-Csv $filename -NoTypeInformation
 
}
