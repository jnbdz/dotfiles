.DEFAULT_GOAL := help

.PHONY: all
all: basic utils ## Install everything in the Makefile

.PHONY: utils
utils: path-picker csvquote ## Install the utils

.PHONY: basic
basic: ## Install the basic applications and daemons
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get install -y \
		build-essential
	ln -snf $(CURDIR)/.zshrc $(HOME)/.zshrc;
	ln -snf $(CURDIR)/.vimrc $(HOME)/.vimrc;
	mkdir -p $(HOME)/.local/bin
	mkdir -p $(HOME)/.local/lib
	mkdir -p $(HOME)/.local/share
	mkdir -p $(HOME)/.local/share/applications/
	mkdir -p $(HOME)/.config
	ln -snf $(CURDIR)/.config/containers $(HOME)/.config/containers
	ln -snf $(CURDIR)/.config/shell $(HOME)/.config/shell
	ln -snf $(CURDIR)/.config/zsh $(HOME)/.config/zsh
	ln -snf $(CURDIR)/.local/bin/untar $(HOME)/.local/bin/untar
	ln -snf $(CURDIR)/.local/share/emoji $(HOME)/.local/share/emoji
	ln -snf $(CURDIR)/.local/share/helpdocs/ $(HOME)/.local/share/helpdocs
	ln -snf $(CURDIR)/.local/bin/statusbar/ $(HOME)/.local/bin/statusbar
	echo "\n# ZSH terminal" >> $(HOME)/.bashrc
	echo "zsh" >> $(HOME)/.bashrc
	echo "export PATH=$$PATH:$(HOME)/.local/bin/" >> $(HOME)/.bashrc
	echo ". $(HOME)/.config/shell/aliasrc" >> $(HOME)/.bashrc

.PHONY: path-picker
path-picker: ## Install the Facebook path picker util
	sudo -i && exit
	git clone git@$(GITHUB_HOST):facebook/PathPicker.git
	if [ -d "/opt/PathPicker" ]; \
	then \
		sudo rm -rf /opt/PathPicker; \
		sudo rm $(HOME)/.local/bin/fpp; \
	fi; \
	sudo mv $(CURDIR)/PathPicker /opt/PathPicker
	sudo chown -R user /opt/PathPicker
	sudo chgrp -R user /opt/PathPicker
	sudo chmod +x /opt/PathPicker/fpp
	ln -snf /opt/PathPicker/fpp $(HOME)/.local/bin/fpp

.PHONY: csvquote
csvquote: ## Install csvquote util
	sudo -i && exit
	git clone git@$(GITHUB_HOST):dbro/csvquote.git
	cd csvquote
	make
	sudo make install
	cd $(CURDIR)
	rm -rf $(CURDIR)/csvquote

.PHONY: suckless
suckless: ## Install all the packages that are needed to compile the Suckless projects
	sudo apt-get update
	sudo apt-get install -y \
		libx11-dev \
		pkg-config \
		libharfbuzz-dev \
		libfontconfig-dev \
		libxft-dev

.PHONY: dwm-setup
dwm-setup: dwm-build ## Setup dwm
	sudo apt-get install -y dwm
	git clone git@$(GITHUB_HOST):$(GITHUB_USER)/dwm.git
	sudo mv dwm /opt	

.PHONY: dwm-build
dwm-build: ## Build dwm
	sudo cd /opt/dwm && sudo make clean install

.PHONY: dmenu-setup
dmenu: ## Setup dmenu

.PHONY: reverse-engineering
reverse-engineering: ## Install reverse engineering tools
	sudo apt-get update
	sudo apt-get install -y \
		kali-tools-reverse-engineering \
		ghidra \
		ghidra-data \
		ghidra-dbgsym \
		quark-engine \
		rz-ghidra \
		rz-ghidra-dbgsym

.PHONY: dev
dev: idea pycharm goland clion rstudio android-studio ## Dev tools install
	sudo apt-get update
	sudo apt-get install -y \
		vim \
		git-flow \
		podman \
		podman-compose \
		qemu

.PHONY: rstudio
rstudio: ## Install RStudio (uninstalling can be done by using `apt remove r-base` command)
	sudo apt-get update
	sudo apt-get install -y r-base
	wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-$(rStudioVersion)-amd64.deb -P $(HOME)/Downloads/
	sudo dpkg -i $(HOME)/Downloads/rstudio-$(rStudioVersion)-amd64.deb
	rm $(HOME)/Downloads/rstudio-$(rStudioVersion)-amd64.deb

.PHONY: iphone
iphone: ## Install the tools to be able to access your IPhone data via Linux
	sudo apt-get update
	sudo apt-get install -y \
		ifuse \
		usbmuxd \
		libimobiledevice6 \
		libimobiledevice-utils

.PHONY: uninstall-iphone
uninstall-iphone: ## Uninstall IPhone tools
	sudo apt-get remove -y \
		ifuse \
		usbmuxd \
		libimobiledevice6 \
		libimobiledevice-utils

.PHONY: office
office: ## Setup the office environment (it commes with applications to access and modify documents)
	sudo apt-get update
	sudo apt-get install -y \
		libreoffice \
		asciidoc \
		asciidoc-base \
		zathura \
		atril \
		atril-common \
		pandoc

.PHONY: uninstall-office
uninstall-office: ## Uninstall the applications for the office enviroment
	sudo apt-get purge -y \
		libreoffice \
		asciidoc \
		asciidoc-base \
		zathura \
		atril \
		atril-common \
		pandoc

.PHONY: graphics
graphics: ## Setup the Graphics environment
	sudo apt-get update
	sudo apt-get install -y \
		gimp \
		inkscape \
		imagemagick

.PHONY: uninstall-graphics
uninstall-graphics: ## Uninstall the Graphics environment
	sudo apt-get remove -y \
		gimp \
		inkscape \
		imagemagick

.PHONY: gstreamer
gstreamer: ## Install gstreamer
	sudo apt-get update
	sudo apt-get install -y \
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

.PHONY: multimedia
multimedia: ## Setup the multimedia environment
	sudo apt-get update
	sudo apt-get install -y \
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
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/Makefile://' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
