#!/usr/bin/env bash

declare ideaVersion="2022.1.3"

installIdea() {
    echo " > Download & install of IntelliJ IDEA version "${ideaVersion}
    wget -c https://download.jetbrains.com/idea/ideaIC-${ideaVersion}.tar.gz -P ~/Downloads/
    tar -xvf ~/Downloads/ideaIC-${ideaVersion}.tar.gz -C ~/.local/lib/
}

removeIdeaTar() {
    echo " > Removed IntelliJ IDEA tar.gz file"
    rm ~/Downloads/ideaIC-${ideaVersion}.tar.gz
}

uninstallIdea() {
    echo " > Uninstall IntelliJ IDEA"
    rm -rf ~/.local/lib/ideaIC-${ideaVersion}
}
