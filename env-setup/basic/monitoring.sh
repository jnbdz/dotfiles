#!/usr/bin/env bash

installBasic() {
    sudo apt-get install -y htop
}

uninstallBasic() {
    sudo apt purge -y htop
}
