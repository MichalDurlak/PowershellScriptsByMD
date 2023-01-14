#Path to servers in csv (1 column = "Name")
$servers = Import-csv "E:\Windows_Update_Automations_MD\Install_PSWindowsUpdate\servers.csv"

foreach ($server in $servers){

Write-Host "Uruchamiam serwer -> " + $server.Name


$s = New-PSSession -computername $server.Name
    Invoke-Command -session $s -scriptblock {
    #Install Module PSWindows for script
    Install-Module -Name PSWindowsUpdate -Force
    #Create remote task for windows update
    Register-ScheduledJob -Name GetUpdatesWindowsMDAutomations -ScriptBlock { Get-WindowsUpdate -AcceptAll -Install -AutoReboot }
    #Start task - Windows update
    Get-ScheduledTask -TaskPath "\Microsoft\Windows\PowerShell\ScheduledJobs\" | Start-ScheduledTask
    #Get current state of task
    (Get-ScheduledTask -TaskPath "\Microsoft\Windows\PowerShell\ScheduledJobs\" -TaskName "GetUpdatesWindowsMDAutomations").State
    }
Remove-PSSession $s

#Sleep 2sec
Timeout /NoBreak 2
} 
