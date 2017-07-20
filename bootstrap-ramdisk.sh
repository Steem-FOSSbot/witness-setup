#!/bin/bash

# bootstrap-ramdisk.sh - ties together all scripts to download, build, install and run witness for first time on RAM disk

usage="Usage: bootstrap-ramdisk.sh [ram-disk-size-in-MB]"

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

echo $GREEN"bootstrap-ramdisk.sh, ties together all scripts to download, build, install and run witness for first time on RAM disk"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo $RED"Please run this script as root"$RESET
	exit
fi
# check parameters exist
if [ $# -ne 1 ]
then
	echo $YELLOW$usage$RESET
	exit
fi

echo $MAGENTA"Securing server..."$RESET
./secure.sh
echo $MAGENTA"Running build-tools, will download, build and install steem witness tools..."$RESET
./build-tools.sh
echo $MAGENTA"Copy pre-configured config and data storage structure for steemd..."$RESET
cp data/. ~/data -a
mkdir ~/data/blockchain
echo $MAGENTA"Get compressed blockchain, decompress and add to data storage..."$RESET
./get-blockchain.sh ~/data/blockchain
echo $MAGENTA"Start witness for first time in replay mode on RAM disk..."$RESET
echo $YELLOW"This will take a long time. If you do not have enough RAM this process will exit with SEGINT or memory alloc error"$RESET
./witness-ramdisk-firsttime.sh ~/data $1

echo
echo $MAGENTA"Finished bootstrap-ramdisk, your system should now be set up."$RESET
echo
echo $YELLOW"What now?!"$RESET
echo $WHITE"You need to edit the "$CYAN"config.ini"$WHITE" file in "$CYAN"~/data/"$WHITE" and"
echo "add your witness account name and WIF."$RESET
echo
echo $WHITE"Then run one of the following:"$RESET
echo $GREEN"   witness.sh          : start witness"$RESET
echo $GREEN"   witness-ramdisk.sh  : start witness on RAM disk"$RESET