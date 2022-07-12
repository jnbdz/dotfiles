SHELL := BASH

.PHONY: all
all: rootdotfiles local config gnupg projects tutorials

.PHONY: basic
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y \
		git \
		vim \
		htop

.PHONY: kali
	echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" | sudo tee /etc/apt/sources.list
	gpg --import kali-pub.asc
	gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -


.PHONY: rootdotfiles
rootdotfiles:
	ln -snf $(CURDIR)/.zshrc $(HOME)/.zshrc;
	ln -snf $(CURDIR)/.vimrc $(HOME)/.vimrc;

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

.PHONY: projects
projects:
	mkdir -p $(HOME)/Projects/Personal
	mkdir -p $(HOME)/Projects/Other;

.PHONY: tutorials
tutorials:
	mkdir -p $(HOME)/Tutorials

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
