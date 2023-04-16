# :robot: What are dotfiles?

Me: 

> Explain what so-called dotfiles are

ChatGPT: 

> Dotfiles are files that are typically hidden on Unix-like operating systems, denoted by a leading dot (e.g., ".bashrc", ".vimrc", etc.), hence the name "dotfiles". These files store configuration settings and customization options for various command-line tools, text editors, and other software applications. Dotfiles are usually written in plain text and contain settings such as aliases, environment variables, color schemes, keybindings, and other preferences that personalize the behavior of software on a user's system.

Me:

> :thumbsup:

## :desktop_computer: Overview

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian 12](https://wiki.debian.org/DebianBookworm)|
| Window manager      | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [polybar](https://github.com/polybar/polybar)|
| Cursor theme        | [phinger-cursors](https://github.com/phisch/phinger-cursors)|
| Shell               | [bash](https://www.gnu.org/software/bash/)|
| Terminal emulator   | [WezTerm](https://wezfurlong.org/wezterm/)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + [Nerd Font patch](https://www.nerdfonts.com/font-downloads)|
| Editor              | [Neovim](https://neovim.io/)|
| File manager        | [ranger](https://github.com/ranger/ranger)|
| Navigation          | [z.lua](https://github.com/skywind3000/z.lua)|
| Fuzzy finder        | [fzf](https://github.com/junegunn/fzf)|

## 1. Pre-install

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

## 2. Install

Boot the USB and follow the on-screen instructions, they're fairly straightforward. If you need help, check out the [Debian installation guide](https://www.debian.org/releases/stable/amd64/), in particular [chapter 6](https://www.debian.org/releases/stable/amd64/ch06.en.html). I always do a clean install (i.e., everything is wiped) and set up [encrypted LVM](https://wiki.debian.org/LVM#Encrypted_LVM) for my entire drive. If you only need [bspwm](https://github.com/baskerville/bspwm) as your window manager (and why wouldn't you? :shrug:), make sure to deselect `Debian desktop environment` and `GNOME` at the software selection step. I also select `SSH server`.

## 3. Post-install

### 3.1 Install git

Now the fun begins! When logged into your clean system, all you'll have is a terminal prompt. To get started, install [git](https://git-scm.com/) and clone this repo:

```bash
sudo apt install -y git
git clone https://github.com/carldelfin/dotfiles.git
```
### 3.2 Run `build.sh`

Run `build.sh` (e.g. `bash dotfiles/build.sh`) and select what to install from the menu. You'll need to at least run `System setup` in order to get a working system. The separate `Development setup` installs and configures [neovim](https://neovim.io/), [ranger](https://github.com/ranger/ranger), [fzf](https://github.com/junegunn/fzf), [z.lua](https://github.com/skywind3000/z.lua), with the caveat that they are all **downloaded as standalone executables and placed in `$HOME/.local/bin`**. Using standalone executables makes it possible to replicate my development setup on systems where I do not have `sudo` rights.

```bash
cd dotfiles && bash build.sh
```
### 3.2 Sensitive files

I don't like to keep sensitive files and directories (e.g. `.ssh`, `.gnupg`, and so on) here in my dotfiles repo. Instead, the relevant folders are regularly backed up to various external drives, which makes them easy to copy back after a clean install. 

```bash
# remove any existing directories
cd
rm -rf .gnupg .ssh .password-store 

# cd into backup folder and copy
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

### 3.3 Syncthing status

I've made a small R script, [syncthing-status](https://github.com/carldelfin/syncthing-status) that, well, checks [Syncthing](https://syncthing.net/) status. It's intended for use with [polybar](https://github.com/polybar/polybar). Note that it will not work out of the box for anyone but me (it's also written in R, just because :shrug:), but you can easily change the relevant parts of the code (related to Syncthing IDs) according to your own needs. Or just rewrite it in something more convenient.

```bash
git clone https://github.com/carldelfin/syncthing-status.git
cd syncthing-status && chmod +x syncthing_status.R
```

### 3.4 Mullvad VPN status

On the topic of Polybar, I've also made a small shell script, [mullvad-vpn-status](https://github.com/carldelfin/mullvad-vpn-status), that --- you guessed it --- checks Mullvad VPN connection status. It also warns the user when the account has less than a week left until expiry.

```bash
git clone https://github.com/carldelfin/mullvad-vpn-status.git
cd mullvad-vpn-status && chmod +x mullvad_vpn_status.sh
```

Note that you'll need to manually configure Mullvad via the CLI:

```bash
# enter account number when prompted
mullvad account login

# block specific content via dns
mullvad dns set default --block-ads --block-malware --block-trackers --block-gambling --block-adult-content

# allow local lan connections
mullvad lan set allow

# make sure we auto connect
mullvad auto-connect set on

# connect
mullvad connect
```

Finally, it doesn't hurt to do a connection check over at [https://mullvad.net/en/check](https://mullvad.net/en/check).

### 3.4 Local SSH connections

If you run `System setup` then [ufw](https://launchpad.net/ufw) is configured to allow all outgoing traffic and deny all incoming traffic. If you use Syncthing, you'll need to make an exception:

```bash
sudo ufw allow syncthing
```

I also like to allow local SSH connections (adapt accordingly):

```bash
sudo ufw allow from 192.168.20.0/24 to any port 22
```

### 3.4 Aleph setup

There is an option to select `Aleph setup` in the `build.sh` menu. Aleph is my "central server", you could say, named in equal parts after [The Aleph](https://en.wikipedia.org/wiki/The_Aleph_(short_story)) and Bobby's fancy harddrive in [Mona Lisa Overdrive](https://en.wikipedia.org/wiki/Mona_Lisa_Overdrive). It does backups, mostly. This script is not likely something you'd run, but it's included here because these are, after all, my own dotfiles.

One thing is necessary to do after running the scrupt, and that is enabling Firefox to use the [Wayland](https://wayland.freedesktop.org/) only. Add the following to `/etc/environment`:

```bash
MOZ_ENABLE_WAYLAND
```

### 3.5 Remaining options

The remaining options in `build.sh` include setting up [R](https://www.r-project.org/) and installing some of my most used packages, as well as setting up [QMK](https://qmk.fm/) for that sweet, sweet [ErgoMechKeyboard](https://www.reddit.com/r/ErgoMechKeyboards/) goodness. Make sure you look into them **before** you run them to make sure you understand what they do!
