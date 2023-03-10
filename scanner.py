#####################################################
# Author: 	Mario Ortega                            #
#                                                   #
# Description: 	Script to scan a whole network or   #
#		a single IP address for open/closed ports   #
#		and services running on them.               #
#                                                   #
#####################################################

import nmap
import sys
import os
import signal
import time
from termcolor import colored, cprint



#Custom banner for the script
def CustomColouredBanner():
    clearConsole()
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

# Function to exit when Ctrl+C is pressed
def handler(signal_received, frame):
    clearConsole()
    print("Ctrl+C pressed")
    print("Hope it was useful! :)")
    print("Killing all processes... (this may take a while)")
    # Kill all nmap processes
    killed = os.system("killall nmap > /dev/null 2>&1")
    print("Exiting...")
    time.sleep(1)
    sys.exit(0)

# Function to clear the console
def clearConsole():
    os.system('clear')

def mainMenu():
    print("\nMenu:")
    print("1. Scan a single IP address")
    print("2. Scan a whole network")
    print("3. Exit")
    option = input("Select an option: ")

    if option == "1":
        SingleIPScan()
    elif option == "2":
        print("Network scan")
    elif option == "3":
        clearConsole()
        print("Hope it was useful! :)")
        print("Exiting...")
        time.sleep(1)
        sys.exit()

# Function to scan a whole network
def NetworkScan():
    clearConsole()
    print("Network scan")

# Function to scan a single IP address
def SingleIPScan():
    clearConsole()
    print("Single IP scan")

    nm = nmap.PortScanner()

    ip = input("Enter the IP address: ")
    ports = input("Do you want to scan all ports? (y/n): ")

    if ports == "y":
        nm.scan(ip, '1-65535')
        for host in nm.all_hosts():
            print('Host : %s (%s)' % (host, nm[host].hostname()))
            print('State : %s' % nm[host].state())
            for proto in nm[host].all_protocols():
                print('----------')
                print('Protocol : %s' % proto)

                lport = nm[host][proto].keys()
                #lport.sort()
                for port in lport:
                    print ('port : %s\tstate : %s' % (port, nm[host][proto][port]['state']))
    elif ports == "n":
        ports = input("Enter the ports to scan separated by commas: ")
    
    mainMenu()



# Main function
def main():
    signal.signal(signal.SIGINT, handler)

    CustomColouredBanner()

    mainMenu()


# Execute main function
if __name__ == "__main__":
    main()
