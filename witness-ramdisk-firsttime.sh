#!/bin/bash

# witness-ramdisk-firsttime.sh - start steem witness using RAM disk for shared memory, first time run (with blockchain replay)

usage="Usage: (as root) witness-ramdisk-firsttime.sh [data-location] [ram-disk-size-in-MB]"

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

echo $GREEN"witness-ramdisk-firsttime, start steem witness using RAM disk for shared memory, first time run (with blockchain replay)"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo $RED"Please run this script as root"$RESET
	echo $YELLOW$usage$RESET
	exit
fi
# check parameters exist
if [ $# -ne 2 ]
then
	echo $YELLOW$usage$RESET
	exit
fi

echo $CYAN"Create and mount RAM disk..."$RESET
mkdir -p /media/ramdisk
mount -t tmpfs -o size=$2M tmpfs /media/ramdisk/
echo $CYAN"Starting steemd using RAM disk for shared memory..."$RESET
echo $YELLOW"Note: press Ctrl+C at any time to attempt clean exit"$RESET
echo $CYAN"[in replay mode]"$RESET
steemd -d $1 --shared-file-dir /media/ramdisk --replay-blockchain
echo $RED"steemd stopped"$RESET

echo $CYAN"Unmount and free RAM disk..."$RESET
umount /media/ramdisk

echo
echo $GREEN"witness-ramdisk-firsttime finished"$RESET