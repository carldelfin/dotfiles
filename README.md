## System at a glance <a name = "system_at_a_glance"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian 12](https://wiki.debian.org/DebianBookworm)|
| Window manager      | [river](https://github.com/riverwm/river)|
| Bar                 | [yambar](https://codeberg.org/dnkl/yambar)|
| Cursor theme        | [phinger-cursors](https://github.com/phisch/phinger-cursors)|
| Shell               | [bash](https://www.gnu.org/software/bash/)|
| Terminal emulator   | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal theme      | [nordfox](https://github.com/EdenEast/nightfox.nvim/blob/main/extra/nordfox/nightfox_kitty.conf)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + [Nerd Font patch](https://www.nerdfonts.com/font-downloads)|
| Editor              | [Neovim](https://neovim.io/)|
| File manager        | [lf](https://github.com/gokcehan/lf)|
| Fuzzy finder        | [fzf](https://github.com/junegunn/fzf)|

## Pre-install

Download the Debian 12 ISO (note that Debian 12 is currently in `testing`):

```bash
cd /tmp
wget https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso-cd
```

Create bootable USB:

```bash
# check usb device
lsblk

# unmount
sudo umount /dev/sdX

# flash
sudo dd if=/tmp/debian-testing-amd64-netinst.iso of=/dev/sdX bs=4M && sync
```

## Install

```bash
sudo apt install -y git
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

## Post-install

### Sensitive files

For understandable reasons, I don't keep sensitive files in my dotfiles repo, but they are regularly backed up to external harddrives. 

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

### Environment variables

To enable pure Wayland for Firefox, and to make sure the correct keyboard layout is set, add the following lines to `etc/environment` (e.g. using `sudo nano /etc/environment`):

```bash
MOZ_ENABLE_WAYLAND=1
XKB_DEFAULT_LAYOUT='se'
```




