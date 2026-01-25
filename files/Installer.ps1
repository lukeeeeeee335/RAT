#build resources for RAT
# Created by : Luke O'Sullivan

#Random string for directorys
function random_text{
    
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})

}



#cd $env:temp
#$directory_name = random_text
#mkdir $directory_name

## Variables
$wd = random_text
$path = "$env:temp/$wd"
echo $path

#goto temp and make working directory

mkdir $path
cd $path
echo "" > poc.txt
cd: C:\Users\lukee\Documents\GitHub\RAT\files
pause
