#!/usr/bin/env bash

installLibreOffice() {
    echo " > Install LibreOffice"
    sudo apt-get install -y libreoffice
}

uninstallLibreOffice() {
    echo " > Uninstall LibreOffice"
    sudo apt purge -y libreoffice
}
