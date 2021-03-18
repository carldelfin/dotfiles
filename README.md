## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are hidden files often used to configure applications and various system settings. This repo contains my own dotfiles, currently based around [Debian Testing](https://wiki.debian.org/DebianTesting), as well as scripts for automatically getting my machines up and running after a clean OS install. For a general introduction to dotfiles, check out [GitHub does dotfiles](https://dotfiles.github.io/). Note that my dotfiles are the result of years of constant tweaking and tinkering. They work for me, but may not work for you. Thus, review the code and remove things you don’t want or need. [Do not fork](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) my dotfiles or run `build.sh` unless you know what your are doing.

## Table of Contents

* [Install](#install)
* [System at a glance](#system_at_a_glance)
* [Overview](#overview)
    * [System essentials](#system_essentials)
    * [Day-to-day applications](#day_to_day_applications)

## Install <a name = "install"></a>

With the abvove in mind, the easiest way to get started *is* to clone this repo and running `build.sh`:

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

## System at a glance <a name = "system_at_a_glance"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian Testing](https://wiki.debian.org/DebianTesting)|
| WM                  | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [Polybar](https://github.com/polybar/polybar)|
| Theme               | [Materia Dark](https://github.com/nana-4/materia-theme)|
| Icons               | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)|
| Terminal            | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [Fira Code](https://github.com/tonsky/FiraCode)|

## Overview <a name = "overview"></a>

### System essentials <a name = "system_essentials"></a>

I like to keep my system to a bare minimum, or at least having control over what is installed and not. Although some may prefer to use [Arch](https://archlinux.org/) btw, I have used Debian and its derivatives for many, many years now and grown quite fond of them. Thus, I opt for a [Debian minimal install](https://www.debian.org/CD/netinst/). Given the obvious barebones nature of a minimal install, quite a few things are required in order to get the system up and running. The following is a list of the essential programs I use on my machines. Everything on this list is installed using `build/system_setup.sh`:

* [xorg](https://www.x.org/wiki/) - Provides the fundamental visual display capabilities of the system.
* [bspwm](https://github.com/baskerville/bspwm) - The Binary Space Partitioning Window Manager, bspwm, is a slim and highly configurable [tiling](https://en.wikipedia.org/wiki/Tiling_window_manager) window manager.
* [picom](https://github.com/yshui/picom) - A stand-alone compositor for X.org that enables transparency and shadows.
* [kitty](https://sw.kovidgoyal.net/kitty/) - My terminal of choice; flexible, keyboard oriented, and fast.
* [polybar](https://github.com/polybar/polybar) - An easy to use and configurable status bar.
* [suckless-tools](https://tools.suckless.org/) - Provides [dmenu](https://tools.suckless.org/dmenu/), which is required for [passmenu](https://git.zx2c4.com/password-store/tree/contrib/dmenu/passmenu).
* [rofi](https://github.com/davatorium/rofi) - Application launcher and replacement for dmenu.
* [pass](https://www.passwordstore.org/) - Lightweight, fast and super easy password managment. 
* [rofi-pass](https://github.com/carnager/rofi-pass) - Front-end to pass using rofi.
* [ufw](https://wiki.ubuntu.com/UncomplicatedFirewall) - Easy to use frontend to [iptables](https://linux.die.net/man/8/iptables).
* [rsync](https://linux.die.net/man/1/rsync) - Fast and flexible file synchronizer.
* [unzip](https://linux.die.net/man/1/unzip) - You guessed it; it unzips archives.
* [curl](https://curl.se/) - Command line tool for transferring data.
* [make](https://www.gnu.org/software/make/) - GNU Make is required to build and install packages using [makefiles](https://www.gnu.org/software/make/manual/make.html#Introduction).
* [gcc](https://gcc.gnu.org/) - GCC, or the GNU Compiler Collection, provides frontends and compilers for several languages, including C, C++ and Fortran.
* [feh](https://feh.finalrewind.org/) - Lightweight image viewer, used to set the wallpaper.
* [arandr](https://christian.amsuess.com/tools/arandr/) - ARandR, or Another XRandR GUI, is a frontend to [XRandR](https://www.x.org/wiki/Projects/XRandR/), used to configure monitors and screen resolution.
* [ranger](https://github.com/ranger/ranger) - Minimalistic command line file manager.
* [jq](https://stedolan.github.io/jq/) - Lightweight command line [JSON](https://en.wikipedia.org/wiki/JSON) processor, used by `scripts/sync.sh`.
* [Mullvad](https://mullvad.net/sv/) - [VPN](https://en.wikipedia.org/wiki/Virtual_private_network) that tunnels traffic between my machine and the internet.
* [Syncthing](https://syncthing.net/) - Secure and easy to use continuous file synchronization program used to keep relevant files synced between my machines.

### Day-to-day applications <a name = "day_to_day_applications"></a>

My day-to-day applications are also installed using `build/system_setup.sh`. These are programs I use on a regular basis, but that may be exchanged or removed based on personal preference.

* [Neovim](https://neovim.io/) - 
* [Inkscape](https://inkscape.org/) -

#### 
