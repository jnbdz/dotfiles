#!/usr/bin/env bash

declare androidStudioVersion="2021.2.1.15"

installAndroidStudio() {
    echo " > Download & install of Android Studio version "${androidStudioVersion}
    sudo apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
    wget -c https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${androidStudioVersion}/android-studio-${androidStudioVersion}-linux.tar.gz -P ~/Downloads/
    tar -xvf ~/Downloads/android-studio-${androidStudioVersion}-linux.tar.gz -C ~/.local/lib/
    mkdir -p ~/.local/share/applications/
    cp ./.local/share/applications/android-studio.desktop ~/.local/share/applications/
    removeAndroidStudiodeb
}

removeAndroidStudiodeb() {
    echo " > Removed Android Studio tar.gz file"
    rm ~/Downloads/android-studio-${androidStudioVersion}-linux.tar.gz
}

uninstallAndroidStudio() {
    echo " > Uninstall Android Studio"
    rm -rf ~/.local/lib/android-studio-${androidStudioVersion}-linux
    rm  ~/.local/share/applications/android-studio.desktop
}
