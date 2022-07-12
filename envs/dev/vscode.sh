#!/usr/bin/env bash

declare vsCodeVersion="1.69.0-1657183742"

installVSCode() {
    wget -c https://az764295.vo.msecnd.net/stable/92d25e35d9bf1a6b16f7d0758f25d48ace11e5b9/code_${vsCodeVersion}_amd64.deb -P ~/Downloads/
    dpkg -i ~/Downloads/code_${vsCodeVersion}_amd64.deb
    removeVSCodedeb
}

removeVSCodedeb() {
    rm ~/Downloads/code_${vsCodeVersion}_amd64.deb
}

uninstallVSCode() {
    sudo apt-get remove code
}
