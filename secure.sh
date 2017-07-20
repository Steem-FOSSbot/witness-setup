#!/bin/bash

# secure.sh - a script to install basic security for witness node

# colors
BOLD="$(tput bold)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
RESET="$(tput sgr0)"

echo $GREEN"secure, secure a witness node"

# running as root
if [ "$EUID" -ne 0 ]
	then echo $RED"Please run this script as root"
echo $RESET
	exit
fi

# update system
echo $CYAN"Installing dependencies..."$RESET
apt-get update
apt-get install -y ufw

echo $CYAN"Enabling firewall..."$RESET
ufw enable
ufw allow 22