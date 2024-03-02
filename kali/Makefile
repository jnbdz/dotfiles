.DEFAULT_GOAL := help

.PHONY: all
all: basic utils ## Install everything in the Makefile

.PHONY: basic
basic: ## Install the basic applications and daemons
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get install -y \
		build-essential
	mkdir -p $(HOME)/.backup
	mv $(HOME)/.zshrc $(HOME)/.backup
	mv $(HOME)/.vimrc $(HOME)/.backup
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

.PHONY: utils
utils: path-picker csvquote ## Install the utils
	sudo apt-get update
	sudo apt-get install -y \
		kazam \
		flameshot \
		fzf

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
suckless: dwm-setup dmenu-setup st ## Install all the packages that are needed to compile the Suckless projects
	sudo apt-get update
	sudo apt-get install -y \
		libx11-dev \
		pkg-config \
		libharfbuzz-dev \
		libfontconfig-dev \
		libxft-dev

.PHONY: dwm-setup
dwm-setup: dwm-build ## Setup dwm
	sudo apt-get update
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
dev: idea pycharm goland clion webstorm rstudio ## Dev tools install
	sudo -i && exit
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text
	sudo apt-get update
	sudo apt-get install -y \
		vim \
		git-flow \
		podman \
		podman-compose

.PHONY: idea
idea: ## Install IntelliJ for Java & Kotlin dev
	wget -c https://download.jetbrains.com/idea/ideaIU-$(ideaVersion).tar.gz


.PHONY: uninstall-idea
uninstall-pycharm: ## Uninstall Idea
	sudo rm -rf /opt/idea
	rm $(HOME)/.local/share/applications/idea.desktop

.PHONY: pycharm
idea: ## Install PyCharm for Python dev
	wget -c https://download.jetbrains.com/pycharm/pycharm-$(pycharmVersion).tar.gz


.PHONY: uninstall-pycharm
uninstall-pycharm: ## Uninstall PyCharm
	sudo rm -rf /opt/pycharm
	rm $(HOME)/.local/share/applications/pycharm.desktop

.PHONY: goland
idea: ## Install GoLand for Go lang dev
	wget -c https://download.jetbrains.com/go/goland-$(pycharmVersion).tar.gz


.PHONY: uninstall-goland
uninstall-pycharm: ## Uninstall GoLand
	sudo rm -rf /opt/goland
	rm $(HOME)/.local/share/applications/goland.desktop

.PHONY: webstorm
idea: ## Install GoLand for Go lang dev
	wget -c https://download.jetbrains.com/go/goland-$(pycharmVersion).tar.gz


.PHONY: uninstall-webstorm
uninstall-pycharm: ## Uninstall WebStorm
	sudo rm -rf /opt/webstorm
	rm $(HOME)/.local/share/applications/webstorm.desktop

.PHONY: clion
clion: ## Install CLion for C/C++ dev
	wget -c https://download-cdn.jetbrains.com/cpp/CLion-$(clionVersion).tar.gz
	if [ -d "/opt/clion" ]; \
	then \
		sudo rm -rf /opt/clion; \
	fi; \
	sudo tar -xvf $(CURDIR)/CLion-$(pycharmVersion).tar.gz -C /opt/
	if [ ! -d "/opt/clion" ]; \
	then \
		sudo mv /opt/clion* /opt/clion; \
	fi; \
	sudo chown -R user /opt/clion
	sudo chgrp -R user /opt/clion
	mkdir -p $(HOME)/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/clion.desktop $(HOME)/.local/share/applications/
	rm $(HOME)/Downloads/CLion-$(pycharmVersion).tar.gz

.PHONY: uninstall-clion
uninstall-pycharm: ## Uninstall CLion
	sudo rm -rf /opt/clion
	rm $(HOME)/.local/share/applications/clion.desktop

.PHONY: rstudio
rstudio: ## Install RStudio (uninstalling can be done by using `apt remove r-base` command)
	sudo apt-get update
	sudo apt-get install -y r-base
	wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-$(rStudioVersion)-amd64.deb -P $(HOME)/Downloads/
	sudo dpkg -i $(HOME)/Downloads/rstudio-$(rStudioVersion)-amd64.deb
	rm $(HOME)/Downloads/rstudio-$(rStudioVersion)-amd64.deb

.PHONY: android-studio
android-studio: ## Install Android Studio
	sudo apt install -y \
		libc6 \
		libncurses5 \
		libstdc++6 \
		lib32z1 \
		libbz2-1.0 \
		libclang-dev
	wget -c https://redirector.gvt1.com/edgedl/android/studio/ide-zips/$(androidStudioVersion)/android-studio-$(androidStudioVersion)-linux.tar.gz -P $(HOME)/Downloads/
	if [ -d "/opt/android-studio" ]; \
	then \
		sudo rm -rf /opt/android-studio; \
	fi; \
	sudo tar -xvf $(HOME)/Downloads/android-studio-$(androidStudioVersion)-linux.tar.gz -C /opt/
	if [ ! -d "/opt/android-studio" ]; \
	then \
		sudo mv /opt/android-studio* /opt/android-studio; \
	fi; \
	sudo chown -R user /opt/android-studio
	sudo chgrp -R user /opt/android-studio
	mkdir -p $(HOME)/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/android-studio.desktop $(HOME)/.local/share/applications/
	rm $(HOME)/Downloads/android-studio-$(androidStudioVersion)-linux.tar.gz

.PHONY: uninstall-android-studio
uninstall-android-studio: ## Uninstall Android Studio
	sudo rm -rf /opt/android-studio
	rm  $(HOME)/.local/share/applications/android-studio.desktop

.PHONY: vm-qemu
vm: ## Install VMs
	sudo apt-get install -y \
		qemu \
		vagrant

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
		libdvdread3 \
		mpv \
		parole \
		handbrake \
		handbrake-cli \
		ffmpeg \
		yt-dlp \
		audacity \
		audacity-data \
		kdenlive \
		openshot-qt

# To note mplayer doesn't play well with VLC. If you install mplayer it won't let you install VLC and openshot-qt.
# You might need to install kdenlive with flatpak. For some reason it keeps crashign if it is installed with apt-get.
#flatpak \
#sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo \
#sudo flatpak install flathub org.kde.kdenlive

#sudo flatpak install flathub com.obsproject.Studio

# export XDG_DATA_DIRS="${XDG_DATA_DIRS}:/var/lib/flatpak/exports/share:/home/jn/.local/share/flatpak/exports/share"

.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed 's/Makefile://' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
