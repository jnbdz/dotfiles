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
	sudo apt-get install -y \
		libreoffice \
		asciidoc \
		asciidoc-base \
		zathura \
		atril \
		atril-common \
		pandoc

.PHONY: uninstall-office
uninstall-office:
	sudo apt purge -y \
		libreoffice \
		asciidoc \
		asciidoc-base \
		zathura \
		atril \
		atril-common \
		pandoc

.PHONY: graphics
graphics:
	sudo apt install -y \
		gimp \
		inkscape \
		imagemagick

.PHONY: uninstall-graphics
uninstall-graphics:
	sudo apt remove -y \
		gimp \
		inkscape \
		imagemagick

.PHONY: multimedia
multimedia: gstreamer gpac vlc mpv parole handbrake ffmpeg youtube-dl

.PHONY: gstreamer
gstreamer:
	sudo apt install -y \
		libgstreamer1.0-dev \
		libgstreamer-plugins-base1.0-dev \
		libgstreamer-plugins-bad1.0-dev \
		gstreamer1.0-plugins-base \
		gstreamer1.0-plugins-good \
		gstreamer1.0-plugins-bad \
		gstreamer1.0-plugins-ugly \
		gstreamer1.0-libav \
		gstreamer1.0-tools \
		gstreamer1.0-x \
		gstreamer1.0-alsa \
		gstreamer1.0-gl \
		gstreamer1.0-gtk3 \
		gstreamer1.0-qt5 \
		gstreamer1.0-pulseaudio

.PHONY: uninstall-gstreamer 
uninstall-gstreamer:
	sudo apt remove -y \
		libgstreamer1.0-dev \
		libgstreamer-plugins-base1.0-dev \
		libgstreamer-plugins-bad1.0-dev \
		gstreamer1.0-plugins-base \
		gstreamer1.0-plugins-good \
		gstreamer1.0-plugins-bad \
		gstreamer1.0-plugins-ugly \
		gstreamer1.0-libav \
		gstreamer1.0-tools \
		gstreamer1.0-x \
		gstreamer1.0-alsa \
		gstreamer1.0-gl \
		gstreamer1.0-gtk3 \
		gstreamer1.0-qt5 \
		gstreamer1.0-pulseaudio

.PHONY: gpac
gpac:
	sudo apt install -y gpac

.PHONY: unintall-gpac
uninstall-gpac:
	sudo apt remove -y gpac

.PHONY: vlc
vlc:
	sudo apt install -y \
		vlc \
		xine \
		mplayer \
		libdvdread3

.PHONY: uninstall-vlc
uninstall-vlc:
	sudo apt remove -y \
		vlc \
		xine \
		mplayer \
		libdvdread3

.PHONY: mpv
mpv:
	sudo apt install -y \
		mpv

.PHONY: uninstall-mpv
uninstall-mpv:
	sudo apt remove -y \
		mpv

.PHONY: parole
parole:
	sudo apt install -y \
		parole

.PHONY: uninstall-parole
uninstall-parole:
	sudo apt remove -y \
		parole

.PHONY: handbrake
handbrake:
	sudo apt install -y \
		handbrake \
		handbrake-cli

.PHONY: uninstall-handbrake
uninstall-handbrake:
	sudo apt remove -y \
		handbrake \
		handbrake-cli

.PHONY: ffmpeg
ffmpeg:
	sudo apt install -y \
		ffmpeg

.PHONY: uninstall-ffmpeg
uninstall-ffmpeg:
	sudo apt remove -y \
		ffmpeg

.PHONY: youtube-dl
youtube-dl:
	sudo apt install -y \
		youtube-dl

.PHONY: uninstall-youtube-dl
uninstall-youtube-dl:
	sudo apt remove -y \
		youtube-dl

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
