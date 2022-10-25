$softs = Get-WmiObject -Class Win32_Product
if ($softs.Name -eq "XXX" ){ Write-Host "Soft is already installed"} 
else {Start-Process 'C:\XXXInstall.bat'}
