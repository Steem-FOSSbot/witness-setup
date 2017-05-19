#!/bin/bash

# steemd-ramdisk.sh - a script to build steemd and cli_wallet. Aimed at Ubuntu Server 16.04 LTS

usage="Usage: steemd-ramdisk.sh [data-location] [ramdisk-size-in-MB]"

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

echo $GREEN"steemd-ramdisk, run steemd on ramdisk"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo $RED"Please run this script as root"$RESET
	exit
fi
# check parameters exist
if [ $# -eq 0 ]
then
	echo $YELLOW$usage$RESET
	exit
fi

echo $CYAN"Create and mount RAM disk..."$RESET
mkdir -p /media/ramdisk
mount -t tmpfs -o size=$2M tmpfs /media/ramdisk/
echo $CYAN"Starting steemd using RAM disk for shared memory..."$RESET
steemd -d $1 --shared-file-dir /media/ramdisk --replay-blockchain
echo $YELLOW"** steemd stopped"$RESET

echo $CYAN"Unmount and free RAM disk..."$RESET
umount /media/ramdisk

echo
echo $GREEN"steemd-ramdisk finished"$RESET
