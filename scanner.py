#####################################################
# Author: 	Mario Ortega
#
# Description: 	Script to scan a whole network or 
#		a single IP address for open/closed ports
#		and services running on them.
#
#####################################################

import nmap
import sys
import os
import time
from termcolor import colored, cprint



#Custom banner for the script
def CustomColouredBanner():
    inicial = colored("|        Port Scanner by Mario Ortega           |", 'red', attrs=['bold', 'blink'])
    barra = colored("+------------------------------------------------+", 'blue', attrs=['bold'])
    vertical = colored("|                                               |", 'blue', attrs=['bold'])
   
    print(barra)
    print(vertical)
    print(vertical)
    print(inicial)
    print(vertical)
    print(vertical)
    print(barra)





# Main function
def main():
    CustomColouredBanner()

    print("What do you want to do?")
    print("1. Scan a single IP address")
    print("2. Scan a whole network")
    print("3. Exit")
    option = input("Select an option: ")


# Execute main function
if __name__ == "__main__":
    main()
