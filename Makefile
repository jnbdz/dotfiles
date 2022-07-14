SHELL := BASH

# Dev
androidStudioVersion = 2021.2.1.15
ideaVersion = 2022.1.3
pycharmVersion = 2022.1.3
rStudioVersion = 2022.07.0-548
vsCodeVersion = 1.69.0-1657183742

.PHONY: all
all: basic dev multimedia office

.PHONY: basic
basic:
	sudo apt update
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bck
	echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | sudo tee /etc/apt/sources.list
	gpg --import kali-pub.asc
	gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y \
		wget \
		curl \
		git \
		vim \
		htop \
		zsh \
		xclip \
		x11-apps \
		kali-archive-keyring
	ln -snf $(CURDIR)/.zshrc $(HOME)/.zshrc;
	ln -snf $(CURDIR)/.vimrc $(HOME)/.vimrc;
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	mkdir -p $(HOME)/.local/bin
	mkdir -p $(HOME)/.local/share
	mkdir -p $(HOME)/.config
	ln -snf $(CURDIR)/.config/containers $(HOME)/.config/containers
	ln -snf $(CURDIR)/.config/shell $(HOME)/.config/shell
	ln -snf $(CURDIR)/.config/zsh $(HOME)/.config/zsh
	mkdir -p $(HOME)/.gnupg
	ln -snf $(CURDIR)/.local/bin/untar $(HOME)/.local/bin/untar
	ln -snf $(CURDIR)/.local/share/emoji $(HOME)/.local/share/emoji
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $(CURDIR)/.local/share/helpdocs/$$file $(HOME)/.local/share/helpdocs/$$f; \
	done; \
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $(CURDIR)/.local/bin/statusbar/$$file $(HOME)/.local/bin/statusbar/$$f; \
	done; \
	git clone https://github.com/facebook/PathPicker.git	
	~/Downloads/PathPicker/debian/package.sh
	dpkg -i ~/Downloads/PathPicker/PathPicker/fpp_0.7.2_noarch.deb
	rm -rf ~/Downloads/PathPicker

.PHONY: dev
dev:
	sudo apt install -y \
		podman \
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
		gstreamer1.0-pulseaudio \
		selinux-basics \
		selinux-policy-default \
		auditd
	wget -c https://az764295.vo.msecnd.net/stable/92d25e35d9bf1a6b16f7d0758f25d48ace11e5b9/code_$(vsCodeVersion)_amd64.deb -P ~/Downloads/
	dpkg -i ~/Downloads/code_$(vsCodeVersion)_amd64.deb
	rm ~/Downloads/code_$(vsCodeVersion)_amd64.deb
	wget -c https://dl.pstmn.io/download/latest/linux64 -P ~/Downloads
	tar -xvf ~/Download/linux64 -C ~/.local/lib/
	rm ~/Downloads/linux64
	for file in $(shell find $(CURDIR)/.local/bin/ -name ".*" -not -name ".gitignore" -not -name ".*.swp" -not -name "statusbar" -not -name "untar"); do \
		f=$$(basename $$file); \
		ln -sfn $(CURDIR)/.local/bin/$$file $(HOME)/.local/bin/$$f; \
	done; \
	mkdir -p $(HOME)/Projects/Personal/Quickstarts
	mkdir -p $(HOME)/Projects/Other
	mkdir -p $(HOME)/Tutorials

.PHONY: all-ide
all-ide: android-studio idea pycharms rstudio

.PHONY: uninstall-all-ide
uninstall-all-ide: uninstall-android-studio uninstall-idea uninstall-pycharm

.PHONY: android-studio
android-studio:
	sudo apt install -y \
		libc6:i386 \
		libncurses5:i386 \
		libstdc++6:i386 \
		lib32z1 \
		libbz2-1.0:i386
	wget -c https://redirector.gvt1.com/edgedl/android/studio/ide-zips/$(androidStudioVersion)/android-studio-$(androidStudioVersion)-linux.tar.gz -P ~/Downloads/
	tar -xvf ~/Downloads/android-studio-$(androidStudioVersion)-linux.tar.gz -C ~/.local/lib/
	mkdir -p ~/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/android-studio.desktop ~/.local/share/applications/
	rm ~/Downloads/android-studio-$(androidStudioVersion)-linux.tar.gz

.PHONY: uninstall-android-studio
uninstall-android-studio:
	rm -rf ~/.local/lib/android-studio-$(androidStudioVersion)-linux
	rm  ~/.local/share/applications/android-studio.desktop

.PHONY: idea
idea:
	wget -c https://download.jetbrains.com/idea/ideaIC-$(ideaVersion).tar.gz -P ~/Downloads/
	tar -xvf ~/Downloads/ideaIC-$(ideaVersion).tar.gz -C ~/.local/lib/
	mkdir -p ~/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/idea.desktop ~/.local/share/applications/
	rm ~/Downloads/ideaIC-$(ideaVersion).tar.gz

.PHONY: uninstall-idea
uninstall-idea:
	rm -rf ~/.local/lib/ideaIC-$(ideaVersion)
	rm  ~/.local/share/applications/idea.desktop

.PHONY: pycharm
pycharm:
	wget -c https://download.jetbrains.com/python/pycharm-community-$(pycharmVersion).tar.gz -P ~/Downloads/
	tar -xvf ~/Downloads/pycharm-community-$(pycharmVersion).tar.gz -C ~/.local/lib/
	mkdir -p ~/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/pycharm.desktop ~/.local/share/applications/
	rm ~/Downloads/pycharm-community-$(pycharmVersion).tar.gz

.PHONY: uninstall-pycharm
uninstall-pycharm:
	rm -rf ~/.local/lib/pycharm-community-$(pycharmVersion)
	rm  ~/.local/share/applications/pycharm.desktop

.PHONY: rstudio
rstudio:
	wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-$(rStudioVersion)-amd64.deb -P ~/Downloads/
	dpkg -i ~/Downloads/rstudio-$(rStudioVersion)_amd64.deb
	rm ~/Downloads/rstudio-$(rStudioVersion)_amd64.deb

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
multimedia:
	sudo apt install -y \	
		gpac \
		vlc \
		xine \
		mplayer \
		libdvdread3 \
		mpv \
		parole \
		handbrake \
		handbrake-cli \
		ffmpeg \
		youtube-dl

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
