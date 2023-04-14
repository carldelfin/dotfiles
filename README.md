# Dotfiles

This repo contains all my configuration files along with instructions for setting up my system after a clean install. If you want to use any parts, make sure to **closely examine the code** and make sure you understand what it does before executing anything. I take no responsibility for messed up installs.  

## :robot: What are dotfiles?

Me: 

> Explain what so-called dotfiles are

ChatGPT: 

> Dotfiles are files that are typically hidden on Unix-like operating systems, denoted by a leading dot (e.g., ".bashrc", ".vimrc", etc.), hence the name "dotfiles". These files store configuration settings and customization options for various command-line tools, text editors, and other software applications. Dotfiles are usually written in plain text and contain settings such as aliases, environment variables, color schemes, keybindings, and other preferences that personalize the behavior of software on a user's system.

## :desktop_computer: Overview

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian 12](https://wiki.debian.org/DebianBookworm)|
| Window manager      | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [polybar](https://github.com/polybar/polybar)|
| Cursor theme        | [phinger-cursors](https://github.com/phisch/phinger-cursors)|
| Shell               | [bash](https://www.gnu.org/software/bash/)|
| Terminal emulator   | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + [Nerd Font patch](https://www.nerdfonts.com/font-downloads)|
| Editor              | [Neovim](https://neovim.io/)|
| File manager        | [ranger](https://github.com/ranger/ranger)|
| File navigation     | [z.lua](https://github.com/skywind3000/z.lua)|
| Fuzzy finder        | [fzf](https://github.com/junegunn/fzf)|

## :spiral_notepad: Pre-install

These instructions assume that you're already on a Linux system. Download the latest Debian 12 ISO (note that Debian 12 is currently in `testing`):

```bash
wget https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso
```

Plug in a USB stick and make it bootable:

```bash
# check usb device
lsblk

# unmount
sudo umount /dev/sdX

# flash (note that this will delete everything on the USB drive)
sudo dd if=debian-testing-amd64-netinst.iso of=/dev/sdX bs=4M && sync
```

## :link: Install

Boot the USB and follow the on-screen instructions, they're fairly straightforward. If you need help, check out the [Debian installation guide](https://www.debian.org/releases/stable/amd64/), in particular [chapter 6](https://www.debian.org/releases/stable/amd64/ch06.en.html). I always do a clean install (i.e., everything is wiped) and set up [encrypted LVM](https://wiki.debian.org/LVM#Encrypted_LVM) for my entire drive. If you only need [bspwm](https://github.com/baskerville/bspwm) as your window manager (and why wouldn't you? :shrug:), make sure to deselect `Debian desktop environment` and `GNOME` at the software selection step. I also select `SSH server`.

## :heavy_check_mark: Post-install

When logged into your clean system, all you have is a terminal prompt. To get started, install [git](https://git-scm.com/) and clone this repo:

```bash
sudo apt install -y git
git clone https://github.com/carldelfin/dotfiles.git
```

Then, run `build.sh` and select what to install. You'll need to at least run `System setup` in order to get a working system. The separate `Development setup` installs and configures [neovim](https://neovim.io/), [ranger](https://github.com/ranger/ranger), [fzf](https://github.com/junegunn/fzf), [z.lua](https://github.com/skywind3000/z.lua), with the caveat that they are all downloaded as standalone executables and placed in `$HOME/.local/bin`. Using standalone executables makes it possible to replicate my development setup on systems where I do not have `sudo` rights.

```bash
cd dotfiles && bash build.sh
```

## 
### :key: Sensitive files

For understandable reasons, I don't keep sensitive files here in my dotfiles repo. Instead, they are regularly backed up to various external places. 

```bash
cd
rm -rf .gnupg .ssh .password-store 
cd /media/cmd/backup_1/latest
cp -r .ssh .gnupg .password-store ~/
cd
```

Make sure `~/.gnupg` has the right permissions:

```bash
chown -R $(whoami) ~/.gnupg/
chmod 600 ~/.gnupg/*
chmod 700 ~/.gnupg
```
