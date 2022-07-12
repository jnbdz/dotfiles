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
	echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | sudo tee /etc/apt/sources.list
	gpg --import kali-pub.asc
	gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
	sudo apt update

.PHONY: dev
dev:
	sudo apt install -y \
		podman
	mkdir -p $(HOME)/Projects/Personal/Quickstarts
	mkdir -p $(HOME)/Projects/Other

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

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
