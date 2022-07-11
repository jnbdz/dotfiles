#!/usr/bin/env bash

echo " > Copy scripts and other files to the dom0"
for fileName in ./dom0/*.sh
do
    qvm-run --pass-io <src-vm> 'cat /path/to/file_in_src_domain' > ~/Downloads/
    qvm-run --pass-io <src-vm> 'cat /path/to/file_in_src_domain' > ~/Downloads/
done
