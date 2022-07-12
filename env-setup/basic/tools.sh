#!/usr/bin/env bash

installBasic() {
    sudo apt-get install -y vim curl
}

uninstallBasic() {
    sudo apt purge -y vim curl
}
