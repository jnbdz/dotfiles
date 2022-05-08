#!/usr/bin/env bash

sudo apt update
sudo apt upgrade
sudo apt install -y \
	git

# Install Facebook PathPicker `fpp`
# Not tested yet (for the install)
git clone https://github.com/facebook/PathPicker.git
./PathPicker/debian/package.sh
sudo dpkg -i ./PathPicker/fpp_0.7.2_noarch.deb
