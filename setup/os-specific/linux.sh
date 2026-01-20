#!/usr/bin/env bash

printf "\nExecuting Linux-specific setups\n"
echo "- build-essential"
sudo apt $APT_FLAGS install build-essential &>"$OUTPUT"
echo "- fontconfig"
sudo apt $APT_FLAGS install fontconfig &>"$OUTPUT"
echo "- git"
sudo apt $APT_FLAGS install git &>"$OUTPUT"
echo "- curl"
sudo apt $APT_FLAGS install curl &>"$OUTPUT"
echo "- unzip"
sudo apt $APT_FLAGS install unzip &>"$OUTPUT"
