#!/bin/bash

# get-blockchain.sh - downloads compressed blockchain from @gandalf(the Gray)/@gtg, and decompresses to target directory

usage="Usage: get-blockchain.sh [blockchain-target-location]"

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

echo $GREEN"get-blockchain, downloads compressed blockchain from @gtg and decompress to target directory"

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

echo $CYAN"Install decompression tools..."$RESET
apt-get update
apt-get install -y pixz

echo $CYAN"Download blockchain..."$RESET
pushd $1 >/dev/null
wget https://gtg.steem.house/get/blockchain.xz/block_log.xz

echo $CYAN"Decompress blockchain..."$RESET
pixz -d block_log.xz

popd >/dev/null

echo
echo $GREEN"get-blockchain finished"$RESET
