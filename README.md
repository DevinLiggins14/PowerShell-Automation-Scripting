<table>
  <tr>
    <td><h1> PowerShell Automation Scripting </h1></td>
    <td>
      <p align="right">
        <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/windows8/windows8-original.svg" alt="Windows" width="60" height="60"/> 
      </p>
    </td>
  </tr>
</table>

## Description

This project automates software installation, file cleanup, and system optimization on a Windows VM using PowerShell. The goal is to save time and reduce manual interventions by implementing an automation script that performs routine maintenance tasks.




## Project Overview

The script will:
- Check for administrator privileges.
- Log all actions taken for troubleshooting and audit purposes.
- Install necessary software using `winget`.
- Clean up temporary files to free up disk space.
- Uninstall pre-installed or unwanted applications.
- Modify system settings to optimize performance.
- Schedule itself to run automatically at a set time each day.

## Project Architecture

<img src="https://github.com/user-attachments/assets/windows-automation-architecture.png" />

The automation script runs as a scheduled task, ensuring that software is kept up-to-date, unnecessary files are removed, and system optimizations are maintained without manual intervention.

## Services and Tools Used

| **Tool/Service**       | **Description**                                                                 |
|-------------------------|-------------------------------------------------------------------------------|
| **PowerShell**         | Used to write and execute the automation script.                              |
| **winget**             | Windows Package Manager for installing software automatically.                |
| **Task Scheduler**     | Runs the automation script at a scheduled interval.                           |
| **Registry Editor**    | Modifies system settings to improve performance.                              |
| **Windows Logging**    | Logs actions performed by the script for troubleshooting and monitoring.      |

## Prerequisites

- Windows VM running Windows 10 or Windows Server
- PowerShell 5.1 or later
- Administrator privileges

## Step 1: Clone the Repository and Run the Script

To get started, clone the repository and execute the script:

```powershell
# Clone the repository
git clone https://github.com/your-repo/windows-vm-automation.git

# Navigate to the script directory
cd windows-vm-automation

# Run the script
powershell.exe -ExecutionPolicy Bypass -File automate.ps1
```

## Step 2: Verify Software Installation

The script installs required software like Chrome, Git, and 7-Zip. You can verify installation by running:

```powershell
winget list
```

## Step 3: Cleanup Temporary Files

The script removes temporary files from system directories. You can manually verify cleanup by checking:

```powershell
Get-ChildItem "C:\Windows\Temp\*" -Recurse
```

## Step 4: Uninstall Unwanted Applications

The script removes bloatware like Xbox and Skype. To check uninstalled apps, run:

```powershell
Get-AppxPackage | Select-Object Name, PackageFullName
```

## Step 5: Schedule the Script to Run Daily

The script schedules itself to run automatically at 3 AM each day. To verify the scheduled task:

```powershell
Get-ScheduledTask | Where-Object { $_.TaskName -eq "WindowsVM_Automation" }
```

## Conclusion

By implementing this PowerShell automation, you can save time, improve system performance, and eliminate the need for manual maintenance on a Windows VM. This project is ideal for IT administrators and DevOps engineers looking to automate Windows management tasks efficiently.
