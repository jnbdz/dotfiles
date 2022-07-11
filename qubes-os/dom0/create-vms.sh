#!/usr/bin/env bash

echo " > Create Kali template"
qvm-create --class TemplateVM --template debian-11 --property label=purple kali-debian-11
qvm-create --class StandaloneVM --template debian-11 --property label=orange Dev
