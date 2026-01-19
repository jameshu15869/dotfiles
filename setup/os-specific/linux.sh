#!/usr/bin/env bash

printf "\nExecuting Linux-specific setups\n"
echo "- expect"
sudo apt -qq install expect &>/dev/null
echo "- build-essential"
sudo apt -qq install build-essential &>/dev/null
echo "- fontconfig"
sudo apt -qq install fontconfig &>/dev/null
echo "- git"
sudo apt -qq install git-all &>/dev/null
echo "- curl"
sudo apt -qq install curl &>/dev/null
echo "- unzip"
sudo apt -qq install unzip &>/dev/null
