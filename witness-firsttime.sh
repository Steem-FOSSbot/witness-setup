#!/bin/bash

# witness-firsttime.sh - start steem witness, first time run (with blockchain replay)

usage="Usage: (as root) witness-firsttime.sh [data-location]"

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

echo $GREEN"witness-firsttime, start witness, first time run (with blockchain replay)"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo $RED"Please run this script as root"$RESET
	echo $YELLOW$usage$RESET
	exit
fi
# check parameters exist
if [ $# -ne 1 ]
then
	echo $YELLOW$usage$RESET
	exit
fi

echo $CYAN"Starting steemd..."$RESET
echo $YELLOW"Note: press Ctrl+C at any time to attempt clean exit"$RESET
steemd -d $1 --replay-blockchain
echo $RED"steemd stopped"$RESET

echo
echo $GREEN"witness-firsttime finished"$RESET
