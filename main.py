#!/usr/bin/python
#python console for RAT 
# Created by : Luke O'Sullivan

#imports
import os
import sys
from modules import *


#variable help menu
banner = """
                                                                                                     
      _____   _____      _____      _____                    _____         _____   _________________ 
 ____|\    \ |\    \    /    /| ___|\    \               ___|\    \    ___|\    \ /                 \
|    | \    \| \    \  /    / ||    |\    \             |    |\    \  /    /\    \\______     ______/
|    |______/|  \____\/    /  /|    | |    |            |    | |    ||    |  |    |  \( /    /  )/   
|    |----'\  \ |    /    /  / |    |/____/|            |    |/____/ |    |__|    |   ' |   |   '    
|    |_____/   \|___/    /  /  |    ||    ||            |    |\    \ |    .--.    |     |   |        
|    |             /    /  /   |    ||____|/            |    | |    ||    |  |    |    /   //        
|____|            /____/  /    |____|                   |____| |____||____|  |____|   /___//         
|    |           |`    | /     |    |                   |    | |    ||    |  |    |  |`   |          
|____|           |_____|/      |____|                   |____| |____||____|  |____|  |____|          
  )/                )/           \(                       \(     )/    \(      )/      \(            
  '                 '             '                        '     '      '      '        '            
                                                                                                     
"""

help_menu = """

"""
#gets arguments
def parser():
    pass

#Command Line interface
def cli(arguments):
    #DISPLAY BANNER
    print(banner)

    #if arguments exsist
    if arguments:
        pass

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
if __name__ =='__main__':
    main()