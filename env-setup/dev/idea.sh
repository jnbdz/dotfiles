#!/usr/bin/env bash

declare ideaVersion="2022.1.3"

installIdea() {
    wget -c https://download.jetbrains.com/idea/ideaIC-${ideaVersion}.tar.gz -P ~/Downloads/
    tar -xvf ~/Downloads/ideaIC-${ideaVersion}.tar.gz -C ~/.local/lib/
}

removeIdeaTar() {
    rm ~/Downloads/ideaIC-${ideaVersion}.tar.gz
}

uninstallIdea() {
    rm -rf ~/.local/lib/ideaIC-${ideaVersion}
}
