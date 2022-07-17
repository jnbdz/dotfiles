#!/usr/bin/env bash

echo " > Create Kali template"
#qvm-create --class TemplateVM --template debian-11 --property label=purple kali-debian-11
qvm-create --class StandaloneVM --template debian-11 --property label=orange Dev
qvm-volume extend Dev:root 15
qvm-volume extend Dev:private 100

qvm-create --class StandaloneVM --template debian-11 --property label=red SRE
qvm-volume extend SRE:private 10

qvm-create --class StandaloneVM --template debian-11 --property label=orange eBooks
qvm-volume extend eBooks:private 10

qvm-create --class StandaloneVM --template debian-11 --property label=yellow Graphics
qvm-volume extend Graphics:private 10

qvm-create --class StandaloneVM --template debian-11 --property label=yellow Multimedia
qvm-volume extend Multimedia:private 10
