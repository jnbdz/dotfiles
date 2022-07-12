#!/usr/bin/env bash

setupDev() {
    echo " > Add the .ssh/ directory"
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    echo " > Add Projects dir with the sub-dir"
    mkdir -p ~/Projects/Personal/Quickstarts
    mkdir -p ~/Projects/Other
}
setupDev
