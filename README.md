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

Make sure you have a bootable USB drive:

```bash
# check usb device
lsblk

# unmount
sudo umount /dev/sdX

# flash
sudo dd if=/path/to/installer.iso of=/dev/sdX bs=4M && sync
```

## Install

```bash
sudo apt install -y git
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

## Post-install

To enable pure Wayland for Firefox, add the following to `etc/environment` (e.g. using `sudo nano /etc/environment`):

```bash
MOZ_ENABLE_WAYLAND=1
```
