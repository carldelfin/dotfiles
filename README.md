System setup
============

- [1. System overview](#0-system-overview)
- [2. Pre-install](#1-pre-install)
- [3. Install Debian](#2-install-debian)
- [4. Post-install](#3-post-install)
    - [4.1 Install git](#31-install-git)
    - [4.2 Run build.sh](#32-run-buildsh)
    - [4.3 Sensitive files](#33-sensitive-files)
    - [4.4 Local SSH connections](#36-local-ssh-connections)

## 1. System overview

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian 12](https://wiki.debian.org/DebianBookworm)|
| Window manager      | [Sway](https://swaywm.org/)|
| Shell               | [Zsh](https://www.zsh.org/)|
| Terminal emulator   | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono)|
| Editor              | [Neovim](https://neovim.io/)|
| File manager        | [ranger](https://github.com/ranger/ranger)|
| Navigation          | [zoxide](https://github.com/ajeetdsouza/zoxide)|
| Fuzzy finder        | [fzf](https://github.com/junegunn/fzf)|

## 2. Pre-install

These instructions assume that you're already on a Linux system. Download the latest Debian 12 ISO:

```bash
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.6.0-amd64-netinst.iso
```

Plug in a USB stick and make it bootable:

```bash
# check usb device
lsblk

# unmount
sudo umount /dev/sdX

# flash (note that this will delete everything on the USB drive)
sudo dd if=debian-12.6.0-amd64-netinst.iso of=/dev/sdX bs=4M && sync
```

## 3. Install Debian

Boot the USB and follow the on-screen instructions, they're fairly straightforward. If you need help, check out the [Debian installation guide](https://www.debian.org/releases/stable/amd64/), in particular [chapter 6](https://www.debian.org/releases/stable/amd64/ch06.en.html). I always do a clean install (i.e., everything is wiped) and set up [encrypted LVM](https://wiki.debian.org/LVM#Encrypted_LVM) for my entire drive. For a minimal install, **deselect** `Debian desktop environment` and `GNOME` at the software selection step. I also **select** `SSH server`.

## 4. Post-install

### 4.1 Install git

Now the fun begins! When logged into your clean system, all you'll have is a terminal prompt. To get started, install [git](https://git-scm.com/) and clone this repo:

```bash
sudo apt install -y git
git clone https://github.com/carldelfin/dotfiles.git
```
### 4.2 Run build.sh

Run `build.sh` and select what to install from the menu:

```bash
cd dotfiles && bash build.sh
```

You'll need to at least run `System setup` in order to get a working system. The separate `Development setup` installs and configures [neovim](https://neovim.io/), [ranger](https://github.com/ranger/ranger), [fzf](https://github.com/junegunn/fzf), [z.lua](https://github.com/skywind3000/z.lua), with the caveat that they are all **downloaded as standalone executables and placed in `$HOME/.local/bin`**. Using standalone executables makes it possible to replicate my development setup on systems where I do not have `sudo` rights.

### 4.3 Sensitive files

I don't keep sensitive files and directories (e.g. `.ssh`, `.gnupg`, `.password-store`) here in my dotfiles repo. They are regularly backed up to various external drives, which makes them easy to copy back over after a clean install. 

```bash
# remove any existing directories
cd
rm -rf .gnupg .ssh .password-store 

# cd into backup directory and copy
cd /path/to/backup/
cp -r .ssh .gnupg .password-store ~/
cd
```

Make sure `~/.gnupg` has the right permissions:

```bash
chown -R $(whoami) ~/.gnupg/
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg
```

### 4.4 Local SSH connections

If you run `System setup` then [ufw](https://launchpad.net/ufw) is configured to allow all outgoing traffic and deny all incoming traffic. If you use Syncthing, you'll need to make an exception:

```bash
sudo ufw allow syncthing
```

I also like to allow local SSH connections (adapt accordingly):

```bash
sudo ufw allow from 192.168.XXX.0/24 to any port 22
```
