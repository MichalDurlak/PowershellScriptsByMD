$Adapters = Get-NetAdapter
foreach ($Adapter in $Adapters){

## if ($Adapter.Status -eq "Up"){
    
    Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ResetServerAddresses
    Write-Host ("Skasowane")
    ipconfig /flushdns
    Write-Host ("Flush Dns zrobione")

## }

}
