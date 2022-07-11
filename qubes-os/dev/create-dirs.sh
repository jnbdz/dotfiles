#!/usr/bin/env bash

echo " > Add the .ssh/ directory"
qvm-run-vm Dev mkdir -p ~/.ssh
qvm-run-vm Dev chmod 700 ~/.ssh

echo " > Add Projects dir with the sub-dir"
qvm-run-vm Dev mkdir -p ~/Projects/Personal/Quickstarts
qvm-run-vm Dev mkdir -p ~/Projects/Other
