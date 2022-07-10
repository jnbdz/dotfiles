# dotfiles
My dotfiles. At your own risk 🥴

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

## Inspired by
- https://github.com/LukeSmithxyz/voidrice
- https://github.com/LukeSmithxyz/LARBS
- https://github.com/jessfraz/dotfiles

## TODO
- Added: https://github.com/zsh-users/zsh-autosuggestions (for systems that don't have it (Kali has it))
