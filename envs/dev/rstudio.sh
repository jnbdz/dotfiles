#!/usr/bin/env bash

declare rStudioVersion="2022.07.0-548"

installRStudio() {
    wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-${rStudioVersion}-amd64.deb -P ~/Downloads/
    dpkg -i ~/Downloads/rstudio-${rStudioVersion}_amd64.deb
    removeRStudiodeb
}

removeRStudiodeb() {
    rm ~/Downloads/rstudio-${rStudioVersion}_amd64.deb
}

uninstallRStudio() {
    sudo apt-get remove rstudio
}
