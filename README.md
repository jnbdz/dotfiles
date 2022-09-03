# dotfiles
My dotfiles. At your own risk 🥴

## Install
### Basic install
With `curl`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic
```

With `git`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic
```

### Dev install
Install the `basic` and `dev`.

With `curl`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic dev
```

With `git`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic dev
```

Install all the IDEs (with `basic` and `dev`).

With `curl`:
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic dev all-ide
```

With `git`:
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic dev all-ide
```

#### Adding the SSH keys

After adding the SSH keys to the `~/.ssh/` directory you need to load ssh: 
```bash
eval "$(ssh-agent -s)"
```

### Multimedia install
With `curl`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic multimedia
```

With `git`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic multimedia
```

### Graphics install
With `curl`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic graphics
```

With `git`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic graphics
```

### Office install
With `curl`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic office
```

With `git`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic office
```

### SRE install
With `curl`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
curl -L https://github.com/jnbdz/dotfiles/archive/refs/heads/main.zip > main.zip && \
unzip main.zip && \
rm main.zip && \
mv dotfiles-main .dotfiles && \
cd .dotfiles && \
make basic sre
```

With `git`: 
```bash
cd ~ && \
sudo apt update && \
sudo apt install -y git make && \
git clone git@github.com:jnbdz/dotfiles.git .dotfiles && \
cd .dotfiles && \
make basic sre
```

## Changing `/etc/apt/sources.list` in Debian to use Kali pkg source
Enabling the **kali-rolling** branch is done with the command:
```
deb http://http.kali.org/kali kali-rolling main contrib non-free
```

Enabling the **kali-last-snapshot** branch is done with the command:
```
deb http://http.kali.org/kali kali-last-snapshot main contrib non-free
```
*Source: https://www.kali.org/docs/general-use/kali-linux-sources-list-repositories/*


Error: 
```bash
W: GPG error: http://kali.download/kali kali-rolling InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY ED444FF07D8D0BF6
E: The repository 'http://http.kali.org/kali kali-rolling InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

```bash
gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
sudo apt update
```
*Source: https://forums.kali.org/showthread.php?18079-Public-key-error*

You need to run: 
```bash
gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
sudo gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -
sudo apt update
```
OR you can use Ubuntu keys: 
```bash
gpg --keyserver keyserver.ubuntu.com --recv-key 7D8D0BF6
sudo gpg -a --export 7D8D0BF6 | apt-key add -
apt update
```

## Sources
- get-pip.py - https://bootstrap.pypa.io/get-pip.py and https://packaging.python.org/en/latest/tutorials/installing-packages/

## Activate the SSH
Verify that the `~/.ssh/` dir has the right permission level: 
```bash
stat -c %a ~/.ssh/
```
It should have the value: **700**

*Source: https://askubuntu.com/questions/144921/how-to-get-chmod-octal-permissions-of-the-folder-in-the-terminal*

Make sure your key access (permission): 
```bash
chmod 400 ~/.ssh/id_*
```
*Source: https://stackoverflow.com/questions/29933918/ssh-key-permissions-0644-for-id-rsa-pub-are-too-open-on-mac*

Start ssh: 
```bash
eval "$(ssh-agent -s)"
```
*Source: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent*

## DWM - New design
### Colors
- #2E3440 - very dark blue (background) top bar uses this color
- #94535d - rgba(148,83,93,255) - darker red
- #bf616a - rgba(191,97,106,255) - red
- #bf616a - rgba(191,97,106,255) - another red
- #a3be8c - rgba(163,190,140,255) - green
- #ebcb8b - rgba(235,203,139,255) - yellow
- #81a1c1 - rgba(129,161,193,255) - darker blue
- #b48ead - rgba(180,142,173,255) - purple
- #88c0d0 - rgba(136,192,208,255) - blue
- #7594C7 - - Blue gray
- #e5e9f0 - rgba(229,233,240,255) - whitish
- #C78C75 - - orange
- #F0801F - - orange
- #EC6630
- #B55B0D
- #C76c17
- #D06224 (orange), #AE431E (orange-red), #8A8635 (green), #E9C891 (skin color (belge))
- #C36839 (orange (seems to be best))
- #EF5B0C - orange
- #D36B00 - orange
- #C29055 - nice orange
- #d2d6de - rgba(210,214,222,255) - gray
- #2e3440 - rgba(46,52,64,255) - black
- #3b4252 - border color

More interesting colors: 
- #8f5e15 - very dark orange
- #990000 - dark red or #8c4351
- #bfbfbf - dark gray use with white or - #e5e5e5 or #9699a3
- #485e30 - dark green
- #5a4a78 - dark purple
- #343b58 - very dark purple
- #34548a - dark blue
- #0f4b6e - dark green & blue

## Inspired by
- https://github.com/LukeSmithxyz/voidrice
- https://github.com/LukeSmithxyz/LARBS
- https://github.com/jessfraz/dotfiles

## TODO
- Added: https://github.com/zsh-users/zsh-autosuggestions (for systems that don't have it (Kali has it))
- Test Office, Multimedia or Graphics

## Resources
- [Gogh | GitHub](https://github.com/Gogh-Co/Gogh) - Color Scheme for your Terminal (helps with color selection) ([Gogh](https://gogh-co.github.io/Gogh/))
- [Color Hunt](https://colorhunt.co/palette/)
- [Good example with DWM and Vintage Retro](https://i.redd.it/c1c51k21y4c31.png)
