#!/bin/bash

##################################################################################################################
# Author:   Mario Ortega                                                                                         #
#                                                                                                                #
# Description: This script installs the dependencies for the project and launches the scanner. Only for Linux.   #
#   It is compulsory to be run as root.                                                                          #
#                                                                                                                #
# Usage: ./launch.sh                                                                                             #
#                                                                                                                #
##################################################################################################################

# Constants for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'

# Check if the script is being run as root
if [ "$(id -u)" != "0" ]; then
    # If not, print an error message and exit
    printf "${RED}This script must be run as root\n" 1>&2
    exit 1
fi

# Banner for updating and installing dependencies
banner() {
    # Blinking banner using parameter and colors
    printf "${BLUE}###############################################\n"
    printf "${BLUE}# ${GREEN}$1\n"
    printf "${BLUE}# ${GREEN}$2\n"
    printf "${BLUE}###############################################\n"
}

clean() {
    # Clean the terminal
    clear
}

# Install dependencies
banner "Updating the system" "This may take a while..."
apt update >/dev/null 2>&1 && apt upgrade -y >/dev/null 2>&1

clean

banner "Installing dependencies and necessary tools" "This may take a while..."
# Python 3 and pip
# Check if python3 is installed
if ! command -v python3 &> /dev/null
then
    # If not, install it
    banner "Python 3 is not installed and it is necessary for the scanner" "Installing Python 3..."
    apt install python3 -y >/dev/null 2>&1
fi
# Check if pip3 is installed
if ! command -v pip3 &> /dev/null
then
    # If not, install it
    banner "pip3 is not installed and it is necessary for the scanner" "Installing pip3..."
    apt install python3-pip -y >/dev/null 2>&1
fi

# Install nmap
# Check if nmap is installed
if ! command -v nmap &> /dev/null
then
    # If not, install it
    banner "nmap is not installed and it is necessary for the scanner" "Installing nmap..."
    apt install nmap -y >/dev/null 2>&1
fi

# Install python dependencies for nmap
pip3 install python-nmap >/dev/null 2>&1

# if it doesn't work, try this
if [ $? -ne 0 ]; then
    pip install python-nmap --user >/dev/null 2>&1
fi

# Termcolor
python3 -m pip install --upgrade termcolor >/dev/null 2>&1

clean

# Run the scanner
python3 scanner.py