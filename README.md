# dotfiles
My dotfiles.

## Changing `/etc/apt/sources.list` in Debian to use Kali pkg source
Error: 
```bash
W: GPG error: http://kali.download/kali kali-rolling InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY ED444FF07D8D0BF6
E: The repository 'http://http.kali.org/kali kali-rolling InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```
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



## Inspired by
- https://github.com/LukeSmithxyz/voidrice
- https://github.com/LukeSmithxyz/LARBS
- https://github.com/jessfraz/dotfiles
