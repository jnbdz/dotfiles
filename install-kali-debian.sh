#!/usr/bin/env bash

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bck
sudo echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
sudo gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
sudo apt update
