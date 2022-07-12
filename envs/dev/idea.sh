#!/usr/bin/env bash

declare ideaVersion="2022.1.3"

installIdea() {
    echo " > Download & install of IntelliJ IDEA version "${ideaVersion}
    wget -c https://download.jetbrains.com/idea/ideaIC-${ideaVersion}.tar.gz -P ~/Downloads/
    tar -xvf ~/Downloads/ideaIC-${ideaVersion}.tar.gz -C ~/.local/lib/
    mkdir -p ~/.local/share/applications/
    cp ./.local/share/applications/idea.desktop ~/.local/share/applications/
}

removeIdeaTar() {
    echo " > Removed IntelliJ IDEA tar.gz file"
    rm ~/Downloads/ideaIC-${ideaVersion}.tar.gz
}

uninstallIdea() {
    echo " > Uninstall IntelliJ IDEA"
    rm -rf ~/.local/lib/ideaIC-${ideaVersion}
    rm  ~/.local/share/applications/idea.desktop
}
