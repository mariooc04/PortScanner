#!/bin/bash

############################################################################################################
# Author:   Mario Ortega
#
# Description: This script installs the dependencies for the project and launches the scanner. Only for Linux.
#   It is compulsory to be run as root.
#
# Usage: ./launch.sh
#
############################################################################################################

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
apt install python3 python3-pip -y >/dev/null 2>&1

# Install nmap
apt install nmap -y >/dev/null 2>&1

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