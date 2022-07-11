#!/usr/bin/env bash

declare pycharmVersion="2022.1.3"

installPycharm() {
    wget -c https://download.jetbrains.com/python/pycharm-community-${pycharmVersion}.tar.gz -P ~/Downloads/
    tar -xvf ~/Downloads/pycharm-community-${pycharmVersion}.tar.gz -C ~/.local/lib/
}

removePycharmTar() {
    rm ~/Downloads/pycharm-community-${pycharmVersion}.tar.gz
}

uninstallPycharm() {
    rm -rf ~/.local/lib/pycharm-community-${pycharmVersion}
}
