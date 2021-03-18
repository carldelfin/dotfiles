## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are hidden files often used to configure applications and various system settings. This repo contains my own dotfiles, currently based around [Debian Testing](https://wiki.debian.org/DebianTesting), as well as scripts for automatically getting my machines up and running after a clean OS install. For a general introduction to dotfiles, check out [GitHub does dotfiles](https://dotfiles.github.io/). Note that my dotfiles are the result of years of constant tweaking and tinkering. They work for me, but may not work for you. Thus, review the code and remove things you don’t want or need. [Do not fork](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) my dotfiles or run `build.sh` unless you know what your are doing.

## Table of Contents

* [Install](#install)
* [System at a glance](#system_at_a_glance)
* [Overview](#overview)
    * [System essentials](#system_essentials)
    * [Day-to-day applications](#day_to_day_applications)
    * [Virtual machines](#virtual_machines)
    * [Containers](#containers)
    * [Sound](#sound)
    * [Appearance](#appearance)

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

I like to keep my system to a bare minimum, or at least having some degree of control over which package gets installed and why. Although some may prefer to use [Arch Linux](https://archlinux.org/) (btw) to achieve this, I have used Debian and its derivatives for many, many years now and grown quite fond of them. Thus, I usually opt for a [Debian minimal install](https://www.debian.org/CD/netinst/). Given the obvious barebones nature of a minimal install, quite a few things are required in order to get the system up and running. The following is a list of (relatively) essential packages, in the order they are installed using `build/system_setup.sh`:

* [xorg](https://www.x.org/wiki/) - Provides the fundamental visual display capabilities of the system.
* [bspwm](https://github.com/baskerville/bspwm) - Highly configurable [tiling](https://en.wikipedia.org/wiki/Tiling_window_manager) window manager.
* [picom](https://github.com/yshui/picom) - Stand-alone compositor for X.org that enables transparency and shadows.
* [kitty](https://sw.kovidgoyal.net/kitty/) - Flexible, keyboard oriented, and fast terminal emulator.
* [polybar](https://github.com/polybar/polybar) - Easy to use and configurable status bar.
* [suckless-tools](https://tools.suckless.org/) - Provides [dmenu](https://tools.suckless.org/dmenu/), which is required for [passmenu](https://git.zx2c4.com/password-store/tree/contrib/dmenu/passmenu).
* [rofi](https://github.com/davatorium/rofi) - Application launcher and replacement for dmenu.
* [pass](https://www.passwordstore.org/) - Lightweight, fast and super easy password managment. 
* [rofi-pass](https://github.com/carnager/rofi-pass) - Front-end to pass using rofi.
* [ufw](https://wiki.ubuntu.com/UncomplicatedFirewall) - Easy to use front-end to [iptables](https://linux.die.net/man/8/iptables).
* [rsync](https://linux.die.net/man/1/rsync) - Fast and flexible file synchronizer.
* [unzip](https://linux.die.net/man/1/unzip) - You guessed it; it unzips archives.
* [curl](https://curl.se/) - Command-line tool for transferring data.
* [make](https://www.gnu.org/software/make/) - Required to build and install packages using [makefiles](https://www.gnu.org/software/make/manual/make.html#Introduction).
* [gcc](https://gcc.gnu.org/) - Provides front-ends and compilers for several languages, including C, C++ and Fortran.
* [feh](https://feh.finalrewind.org/) - Lightweight image viewer, used to set the wallpaper.
* [arandr](https://christian.amsuess.com/tools/arandr/) - Front-end to [XRandR](https://www.x.org/wiki/Projects/XRandR/), used to configure monitors and screen resolution.
* [ranger](https://github.com/ranger/ranger) - Minimalistic command-line file manager.
* [jq](https://stedolan.github.io/jq/) - Lightweight command-line [JSON](https://en.wikipedia.org/wiki/JSON) processor, used by `scripts/sync.sh`.
* [Mullvad](https://mullvad.net/sv/) - [VPN](https://en.wikipedia.org/wiki/Virtual_private_network) that tunnels traffic between my machine and the internet.
* [Syncthing](https://syncthing.net/) - Secure and easy to use continuous file synchronization program.
* [apt-listbugs](https://manpages.debian.org/testing/apt-listbugs/apt-listbugs.1.en.html) - Retrieves bug reports from the Debian Bug Tracking System, invoked when installing using [APT](https://en.wikipedia.org/wiki/APT_(software)) in order to check whether the installation/upgrade is safe. 

### Day-to-day applications <a name = "day_to_day_applications"></a>

My day-to-day applications are also installed using `build/system_setup.sh`. These are programs I use on a regular basis, but that may be exchanged or removed based on personal preference.

* [Neovim](https://neovim.io/) - My primary editor, a continuation and extension of [Vim](https://www.vim.org/). I also install [vim-plug](https://github.com/junegunn/vim-plug) by default. 
* [Inkscape](https://inkscape.org/) - Powerful vector graphics software
* [Okular](https://okular.kde.org/) - Universal document viewer, primarily used for viewing PDFs.
* [qpdf](https://github.com/qpdf/qpdf) - Command-line program for structural PDF transformation, such as cutting pages.
* [htop](https://htop.dev/) - Interactive process viewer and system monitor.
* [Firefox](https://www.mozilla.org/en-US/) - Web browser.

### Virtual machines <a name = "virtual_machines"></a>

I use QEMU/KVM to create virtual machines for testing things, including these dotfiles. The nomeclature is [a bit of a mess](https://serverfault.com/a/391932), but as far as I've understood things, [KVM](https://www.linux-kvm.org/page/Main_Page) or Kernel Virtual Machine is the virtualization technology in the Linux kernel, wheras [QEMU](https://www.qemu.org/) is a machine emulator and virtualizer that may use KVM. When used together, [KVM handles CPU and memory access while QEMU emulates other hardware resources](https://serverfault.com/a/208694). The following packages are installed:

* [qemu-system](https://packages.debian.org/bullseye/qemu-system) - Provides binaries for full system emulation.
* [libvirt-daemon-system](https://wiki.debian.org/libvirt) - Provides the libvirtd service.
* [libvirt-clients](https://wiki.debian.org/libvirt) - Command-line tools to manage virtual machines.
* [virt-manager](https://wiki.debian.org/libvirt) - GUI tool to manage virtual machines.
* [bridge-utils](https://wiki.debian.org/BridgeNetworkConnections) - Enables network sharing between host and virtual machine.

### Containers <a name = "containers"></a>

For compute-intensive research, or projects that involve a lot of data preprocessing and manipulation, I like ensure reproducibility by using containers. I previously used [Docker](https://www.docker.com/), but now prefer [Singularity](https://sylabs.io/singularity/). Since I only use Singularity on my workstation, this install is optional and performed by `build/install_singularity.sh`.

### Sound <a name = "sound"></a>

A minimal install comes without sound, so these packages are required:

* [alsa-utils](https://github.com/alsa-project/alsa-utils) - Command-line utilities for the [Advanced Linux Sound Architecture (ALSA) project](https://www.alsa-project.org/wiki/Main_Page).
* [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/) - Interface engine between pplications and ALSA.
* [libavcodec-extra](https://packages.debian.org/buster/libavcodec-extra) - Additional codec support.

### Appearance <a name = "appearance"></a>

I rarely install a full [desktop environment](https://en.wikipedia.org/wiki/Desktop_environment), which means that I must customize the appearance of applications myself.

* [lxappearance](https://wiki.lxde.org/sv/LXAppearance) - Used to change themes, icons, and cursors.
* [materia-gtk-theme](https://github.com/nana-4/materia-theme) - Material Design theme for GNOME/GTK based applications.
* [papirus-icon-theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) - Free and open source SVG icon theme.
* [qt5-style-plugins](https://packages.debian.org/bullseye/qt5-style-plugins) - Required for Okular to follow the system theme.
* [neofetch](https://github.com/dylanaraps/neofetch) - What would a Linux system be without some command-line system information tool?
* [Fira Code](https://github.com/tonsky/FiraCode) - Terminal emulator font with ligature support.
* [Font Awesome](https://fontawesome.com/) - Icons used in Polybar.
* [Fira Sans](https://github.com/pop-os/fonts) - Nice looking font, the semi-bold version of which is used in Polybar.
