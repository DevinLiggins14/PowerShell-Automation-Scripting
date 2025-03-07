# PowerShell Script for Windows Automation

# Ensure script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as Administrator!" -ForegroundColor Red
    exit
}

# Enable logging
$logFile = "C:\Windows\Temp\automation_log.txt"
function Log {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logFile
}

Log "Starting Windows VM automation script."

# Install necessary software
$softwareList = @("Google.Chrome", "Git.Git", "7zip.7zip")
foreach ($software in $softwareList) {
    Log "Installing $software..."
    winget install --id=$software -e --accept-source-agreements --accept-package-agreements
}

# Clean temporary files
Log "Cleaning temporary files..."
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Uninstall unnecessary applications
$appList = @("Microsoft.XboxApp", "Microsoft.SkypeApp")
foreach ($app in $appList) {
    Log "Uninstalling $app..."
    Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# Modify system settings (e.g., disable Windows telemetry)
Log "Disabling Windows telemetry..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWORD -Force

# Schedule the script to run daily
$taskName = "WindowsVM_Automation"
$taskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File $PSCommandPath"
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 3am
$taskPrincipal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Principal $taskPrincipal -Settings $taskSettings -Force

Log "Powershell automation script execution completed."
