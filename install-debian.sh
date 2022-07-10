#!/usr/bin/env bash

#cd ~

#mkdir -p .tmp

cd /tmp

sudo apt update
sudo apt upgrade
sudo apt install -y \
	git

# Install Facebook PathPicker `fpp`
# Not tested yet (for the install)
git clone https://github.com/facebook/PathPicker.git
cd /PathPicker/debian
./package.sh
cd ../
sudo dpkg -i ./PathPicker/fpp_0.7.2_noarch.deb
cd ~/.tmp
rm -rf ./PathPicker

# Install iPhone utils
sudo apt install ifuse usbmuxd libimobiledevice6 libimobiledevice-utils

# Next step...
