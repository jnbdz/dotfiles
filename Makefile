SHELL := BASH

.PHONY: all
all: rootdotfiles local config gnupg projects tutorials

.PHONY: basic
basic:
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y \
		wget \
		curl \
		git \
		vim \
		htop

.PHONY: kali
kali:
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bck
	echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
	gpg --import kali-pub.asc
	gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
	sudo apt update
	sudo apt install -y \
		kali-archive-keyring

.PHONY: pathpicker
pathpicker:
	git clone https://github.com/facebook/PathPicker.git	
	~/Downloads/PathPicker/debian/package.sh
	dpkg -i ~/Downloads/PathPicker/PathPicker/fpp_0.7.2_noarch.deb
	rm -rf ~/Downloads/PathPicker

.PHONY: uninstall-pathpicker
uninstall-pathpicker:
	sudo apt-get remove fpp

.PHONY: dev
dev:
	sudo apt install -y \
		podman
	mkdir -p $(HOME)/Projects/Personal/Quickstarts
	mkdir -p $(HOME)/Projects/Other

.PHONY: all-ide
all-ide: android-studio idea pycharms rstudio code

.PHONY: uninstall-all-ide
uninstall-all-ide: uninstall-android-studio uninstall-idea uninstall-pycharm uninstall-rstudio uninstall-code

.PHONY: android-studio
android-studio:
	sudo apt install -y \
		libc6:i386 \
		libncurses5:i386 \
		libstdc++6:i386 \
		lib32z1 \
		libbz2-1.0:i386
	wget -c https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${androidStudioVersion}/android-studio-${androidStudioVersion}-linux.tar.gz -P ~/Downloads/
	tar -xvf ~/Downloads/android-studio-${androidStudioVersion}-linux.tar.gz -C ~/.local/lib/
	mkdir -p ~/.local/share/applications/
	cp ./.local/share/applications/android-studio.desktop ~/.local/share/applications/
	rm ~/Downloads/android-studio-${androidStudioVersion}-linux.tar.gz

.PHONY: uninstall-android-studio
uninstall-android-studio:
	rm -rf ~/.local/lib/android-studio-${androidStudioVersion}-linux
	rm  ~/.local/share/applications/android-studio.desktop

.PHONY: idea
idea:
	wget -c https://download.jetbrains.com/idea/ideaIC-${ideaVersion}.tar.gz -P ~/Downloads/
	tar -xvf ~/Downloads/ideaIC-${ideaVersion}.tar.gz -C ~/.local/lib/
	mkdir -p ~/.local/share/applications/
	cp ./.local/share/applications/idea.desktop ~/.local/share/applications/
	rm ~/Downloads/ideaIC-${ideaVersion}.tar.gz

.PHONY: uninstall-idea
uninstall-idea:
	rm -rf ~/.local/lib/ideaIC-${ideaVersion}
	rm  ~/.local/share/applications/idea.desktop

.PHONY: pycharm
pycharm:
	wget -c https://download.jetbrains.com/python/pycharm-community-${pycharmVersion}.tar.gz -P ~/Downloads/
	tar -xvf ~/Downloads/pycharm-community-${pycharmVersion}.tar.gz -C ~/.local/lib/
	mkdir -p ~/.local/share/applications/
	cp ./.local/share/applications/pycharm.desktop ~/.local/share/applications/
	rm ~/Downloads/pycharm-community-${pycharmVersion}.tar.gz

.PHONY: uninstall-pycharm
uninstall-pycharm:
	rm -rf ~/.local/lib/pycharm-community-${pycharmVersion}
	rm  ~/.local/share/applications/pycharm.desktop

.PHONY: rstudio
rstudio:
	wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-${rStudioVersion}-amd64.deb -P ~/Downloads/
	dpkg -i ~/Downloads/rstudio-${rStudioVersion}_amd64.deb
	rm ~/Downloads/rstudio-${rStudioVersion}_amd64.deb

.PHONY: uninstall-rstudio
uninstall-rstudio:
	sudo apt-get remove rstudio

.PHONY: code
code:
	wget -c https://az764295.vo.msecnd.net/stable/92d25e35d9bf1a6b16f7d0758f25d48ace11e5b9/code_${vsCodeVersion}_amd64.deb -P ~/Downloads/
	dpkg -i ~/Downloads/code_${vsCodeVersion}_amd64.deb
	rm ~/Downloads/code_${vsCodeVersion}_amd64.deb

.PHONY: uninstall-code
uninstall-code:
	sudo apt-get remove code

.PHONY: postman
postman:
	wget -c https://dl.pstmn.io/download/latest/linux64 -P ~/Downloads
	tar -xvf ~/Download/linux64 -C ~/.local/lib/
	rm ~/Downloads/linux64

.PHONY: uninstall-postman
uninstall-postman:
	~/.local/lib/Postman

.PHONY: sre
sre:
	sudo apt install -y \
		kali-tools-reverse-engineering \
		ghidra \
		ghidra-data \
		ghidra-dbgsym

.PHONY: rootdotfiles
rootdotfiles:
	ln -snf $(CURDIR)/.zshrc $(HOME)/.zshrc;
	ln -snf $(CURDIR)/.vimrc $(HOME)/.vimrc;

.PHONY: ssh
ssh:
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh

.PHONY: local
local:
	mkdir -p $(HOME)/.local
	mkdir -p $(HOME)/.local/share;

.PHONY: config
config:
	mkdir -p $(HOME)/.config

.PHONY: gnupg
gnupg:
	mkdir -p $(HOME)/.gnupg

.PHONY: tutorials
tutorials:
	mkdir -p $(HOME)/Tutorials

.PHONY: iphone
iphone:
	sudo apt install -y \
		ifuse \
		usbmuxd \
		libimobiledevice6 \
		libimobiledevice-utils

.PHONY: uninstall-iphone
uninstall-iphone:
	sudo apt remove -y \
		ifuse \
		usbmuxd \
		libimobiledevice6 \
		libimobiledevice-utils

.PHONY: office
office:
	sudo apt-get install -y libreoffice

.PHONY: uninstall-office
uninstall-office:
	sudo apt purge -y libreoffice

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
