#!/usr/bin/env bash

cp /etc/apt/sources.list /etc/apt/sources.list.bck
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list
apt update
