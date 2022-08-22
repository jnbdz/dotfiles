include config.mk

.DEFAULT_GOAL := help

.PHONY: all
all: basic dev all-ide multimedia office sre iphone ## Install all types of environment

.PHONY: basic
basic: ## Setup the basic environment
	sudo apt-get update
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bck
	echo "deb https://deb.debian.org/debian bullseye main contrib non-free\ndeb https://deb.debian.org/debian-security bullseye-security main contrib non-free\ndeb http://http.kali.org/kali kali-rolling main contrib non-free" | sudo tee /etc/apt/sources.list
	gpg --import kali-pub.asc
	gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
	export DEBIAN_FRONTEND=noninteractive
	sudo apt-get update --fix-missing
	sudo apt-get install -y \
		libwacom-common \
		libsemanage-common \
		libegl-mesa0 \
		wget \
		curl \
		git \
		vim \
		htop \
		zsh \
		xclip \
		x11-apps \
		ca-certificates \
		kali-archive-keyring \
		ttf-ancient-fonts \
		xfonts-unifont \
		ttf-unifont \
		unifont \
		fonts-noto-cjk \
		fonts-noto-cjk-extra \
		fonts-noto-core \
		fonts-noto-extra \
		fonts-noto-ui-core \
		fonts-noto-ui-extra \
		fonts-noto-unhinted
	sudo apt-get upgrade -y
	sudo apt-get update --fix-missing
	sudo apt-get upgrade -y
	ln -snf $(CURDIR)/.zshrc $(HOME)/.zshrc;
	ln -snf $(CURDIR)/.vimrc $(HOME)/.vimrc;
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
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
	git clone https://github.com/facebook/PathPicker.git
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
	echo "\n# ZSH terminal" >> $(HOME)/.bashrc
	echo "zsh" >> $(HOME)/.bashrc
	echo "export PATH=$$PATH:$(HOME)/.local/bin/" >> $(HOME)/.bashrc
	echo ". $(HOME)/.config/shell/aliasrc" >> $(HOME)/.bashrc

.PHONY: suckless
suckless: ## Install all the packages that are needed to compile the Suckless projects
	sudo apt-get update
	sudo apt-get install -y \
		libx11-dev \
		pkg-config \
		libharfbuzz-dev \
		libfontconfig-dev \
		libxft-dev \
		build-essential

.PHONY: dwm
dwm: ## Install dwm (should already be compiled)
	curl -L https://github.com/$(DWM_GITHUB_USER)/dwm/releases/download/v$(DWM_VERSION)/dwm-v$(DWM_VERSION).tar.gz > dwm-v$(DWM_VERSION).tar.gz
	tar -xvf dwm-v$(DWM_VERSION).tar.gz
	sudo mkdir -p /usr/local/bin
	sudo cp -f dwm /usr/local/bin
	sudo chmod 755 /usr/local/bin/dwm
	sudo mkdir -p /usr/local/share/man1
	sed "s/VERSION/$(DWM_VERSION)/g" < dwm.1 | sudo tee /usr/local/share/man1/dwm.1
	sudo chmod 644 /usr/local/share/man1/dwm.1
	sudo mkdir -p /usr/local/share/dwm
	sudo cp -f larbs.mom /usr/local/share/dwm
	sudo chmod 644 /usr/local/share/dwm/larbs.mom
	rm dwm-v$(DWM_VERSION).tar.gz

.PHONY: uninstall-dwm
uninstall-dwm: ## Uninstall dwm
	sudo rm -f /usr/local/bin/dwm\
		/usr/local/share/dwm/larbs.mom\
		/usr/local/share/man1/dwm.1

.PHONY: st
st: ## Install st terminal (should already be compiled)
	curl -L https://github.com/$(ST_GITHUB_USER)/st/releases/download/v$(ST_VERSION)/st-v$(ST_VERSION).tar.gz > st-v$(ST_VERSION).tar.gz
	tar -xvf st-v$(ST_VERSION).tar.gz
	sudo cp -f $(CURDIR)/st-$(ST_VERSION)/st /usr/local/bin
	sudo cp -f $(CURDIR)/st-$(ST_VERSION)/st-copyout /usr/local/bin
	sudo cp -f $(CURDIR)/st-$(ST_VERSION)/st-urlhandler /usr/local/bin
	sudo chmod 755 /usr/local/bin/st
	sudo chmod 755 /usr/local/bin/st-copyout
	sudo chmod 755 /usr/local/bin/st-urlhandler
	sudo mkdir -p /usr/local/share/man/man1
	sed "s/VERSION/$(VERSION)/g" < $(CURDIR)/st-$(ST_VERSION)/st.1 | sudo tee /usr/local/share/man/man1/st.1
	sudo chmod 644 /usr/local/share/man/man1/st.1
	tic -sx $(CURDIR)/st-$(ST_VERSION)/st.info
	cp $(CURDIR)/.local/share/applications/st.desktop $(HOME)/.local/share/applications/
	rm -rf $(CURDIR)/st-$(ST_VERSION)
	rm st-v$(ST_VERSION).tar.gz
	@echo Please see the README file regarding the terminfo entry of st.

.PHONY: uninstall-st
uninstall-st: ## Uninstall the st terminal
	rm -f /usr/local/bin/st
	rm -f /usr/local/bin/st-copyout
	rm -f /usr/local/bin/st-urlhandler
	rm -f /usr/local/share/man/man1/st.1

.PHONY: dev
dev: ## Setup the dev environment
	export DEBIAN_FRONTEND=noninteractive
	sudo apt-get update
	sudo apt-get install -y \
		git-flow \
		build-essential \
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
		gstreamer1.0-pulseaudio
	sudo python3 get-pip.py --prefix=/usr/local/
	sudo python3 -m pip install --upgrade pip setuptools wheel
	echo "\n[registries.search]\nregistries = ['docker.io', 'quay.io', 'registry.fedoraproject.org', 'registry.access.redhat.com']" | sudo tee -a /etc/containers/registries.conf
	mkdir -p $(HOME)/.local/share/applications/
	wget -c https://az764295.vo.msecnd.net/stable/92d25e35d9bf1a6b16f7d0758f25d48ace11e5b9/code_$(vsCodeVersion)_amd64.deb -P ~/Downloads/
	sudo dpkg -i $(HOME)/Downloads/code_$(vsCodeVersion)_amd64.deb
	rm $(HOME)/Downloads/code_$(vsCodeVersion)_amd64.deb
	wget -c https://dl.pstmn.io/download/latest/linux64 -P $(HOME)/Downloads
	if [ -d "/opt/Postman" ]; \
	then \
		sudo rm -rf /opt/Postman; \
	fi; \
	sudo tar -xvf $(HOME)/Downloads/linux64 -C /opt/
	if [ ! -d "/opt/Postman" ]; \
	then \
		sudo mv /opt/Postman* /opt/Postman; \
	fi; \
	sudo chown -R user /opt/Postman
	sudo chgrp -R user /opt/Postman
	cp $(CURDIR)/.local/share/applications/postman.desktop $(HOME)/.local/share/applications/
	rm $(HOME)/Downloads/linux64
	for file in $(shell find $(CURDIR)/.local/bin/ -name ".*" -not -name ".gitignore" -not -name ".*.swp" -not -name "statusbar" -not -name "untar"); do \
		f=$$(basename $$file); \
		ln -sfn $(CURDIR)/.local/bin/$$file $(HOME)/.local/bin/$$f; \
	done; \
	mkdir -p $(HOME)/Projects/Personal/Quickstarts
	mkdir -p $(HOME)/Projects/Other
	mkdir -p $(HOME)/Tutorials

.PHONY: selinux
selinux: ## Install SELinux
	sudo apt-get install -y \
		selinux-basics \
		selinux-policy-default \
		auditd

.PHONY: all-ide
all-ide: android-studio idea pycharm rstudio ## Install all the IDEs (Android Studio, IntelliJ (idea), PyCharm, RStudio)

.PHONY: uninstall-all-ide
uninstall-all-ide: uninstall-android-studio uninstall-idea uninstall-pycharm ## Uninstall all the IDEs (Android Studio, IntelliJ (idea), PyCharm, RStudio)

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

.PHONY: idea
idea: ## Install idea IDE
	wget -c https://download.jetbrains.com/idea/ideaIC-$(ideaVersion).tar.gz -P $(HOME)/Downloads/
	if [ -d "/opt/idea" ]; \
	then \
		sudo rm -rf /opt/idea; \
	fi; \
	sudo tar -xvf $(HOME)/Downloads/ideaIC-$(ideaVersion).tar.gz -C /opt/
	if [ ! -d "/opt/idea" ]; \
	then \
		sudo mv /opt/idea* /opt/idea; \
	fi; \
	sudo chown -R user /opt/idea
	sudo chgrp -R user /opt/idea
	mkdir -p $(HOME)/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/idea.desktop $(HOME)/.local/share/applications/
	rm $(HOME)/Downloads/ideaIC-$(ideaVersion).tar.gz

.PHONY: uninstall-idea
uninstall-idea: ## Uninstall idea IDE
	sudo rm -rf /opt/idea
	rm  $(HOME)/.local/share/applications/idea.desktop

.PHONY: pycharm
pycharm: ## Install PyCharm
	wget -c https://download.jetbrains.com/python/pycharm-community-$(pycharmVersion).tar.gz -P $(HOME)/Downloads/
	if [ -d "/opt/pycharm" ]; \
	then \
		sudo rm -rf /opt/pycharm; \
	fi; \
	sudo tar -xvf $(HOME)/Downloads/pycharm-community-$(pycharmVersion).tar.gz -C /opt/
	if [ ! -d "/opt/pycharm" ]; \
	then \
		sudo mv /opt/pycharm* /opt/pycharm; \
	fi; \
	sudo chown -R user /opt/pycharm
	sudo chgrp -R user /opt/pycharm
	mkdir -p $(HOME)/.local/share/applications/
	cp $(CURDIR)/.local/share/applications/pycharm.desktop $(HOME)/.local/share/applications/
	rm $(HOME)/Downloads/pycharm-community-$(pycharmVersion).tar.gz

.PHONY: uninstall-pycharm
uninstall-pycharm: ## Uninstall PyCharm
	sudo rm -rf /opt/pycharm
	rm $(HOME)/.local/share/applications/pycharm.desktop

.PHONY: rstudio
rstudio: ## Install RStudio (uninstalling can be done by using `apt remove r-base` command)
	sudo apt-get update
	sudo apt-get install -y r-base
	wget -c https://download1.rstudio.org/desktop/bionic/amd64/rstudio-$(rStudioVersion)-amd64.deb -P $(HOME)/Downloads/
	sudo dpkg -i $(HOME)/Downloads/rstudio-$(rStudioVersion)-amd64.deb
	rm $(HOME)/Downloads/rstudio-$(rStudioVersion)-amd64.deb

.PHONY: uninstall-postman
uninstall-postman: ## Uninstall Postman (it is intalled using dev option)
	sudo rm -rf /opt/Postman
	sudo apt-get remove -y r-base

.PHONY: sre
sre: ## Setup the Software Reverse engineering environment
	sudo apt-get update
	sudo apt-get install -y \
		kali-tools-reverse-engineering \
		ghidra \
		ghidra-data \
		ghidra-dbgsym

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
