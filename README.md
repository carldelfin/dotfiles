## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are hidden files often used to configure applications and various system settings. This repo contains my own dotfiles, currently based around [Debian Testing](https://wiki.debian.org/DebianTesting), as well as scripts for automatically getting my machines up and running after a clean OS install. For a general introduction to dotfiles, check out [GitHub does dotfiles](https://dotfiles.github.io/). Note that my dotfiles are the result of years of constant tweaking and tinkering. They work for me, but may not work for you. Thus, review the code and remove things you don’t want or need. [Do not fork](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) my dotfiles or run `build.sh` unless you know what your are doing.

## Table of Contents

* [Install](#install)
* [Overview](#overview)
* [Details](#details)
    * [Applications](#applications)

## Install <a name = "install"></a>

With the abvove in mind, the easiest way to get started *is* to clone this repo and running `build.sh`:

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

## Overview <a name = "overview"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian Testing](https://wiki.debian.org/DebianTesting)|
| WM                  | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [Polybar](https://github.com/polybar/polybar)|
| Theme               | [Materia Dark](https://github.com/nana-4/materia-theme)|
| Icons               | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)|
| Terminal            | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [Fira Code](https://github.com/tonsky/FiraCode)|

## Details <a name = "details"></a>

### System essentials <a name = "system_essentials"></a>

I like to keep my system to a bare minimum, or at least having control over what is installed and not. Although some may prefer to use [Arch](https://archlinux.org/) btw, I have used Debian and its derivatives for many, many years now and grown quite fond of them. Thus, I opt for a [Debian minimal install](https://www.debian.org/CD/netinst/). Given the obvious barebones nature of a minimal install, quite a few things are required in order to get the system up and running. This is what I use on my machines:

* [xorg](https://www.x.org/wiki/) - X.Org Server provides the fundamental visual display capabilities of the system.
* [bspwm](https://github.com/baskerville/bspwm) - bspwm, or the Binary Space Partitioning Window Manager, is a slim and highly configurable [tiling](https://en.wikipedia.org/wiki/Tiling_window_manager) window manager.

### Applications <a name = "applications"></a>

#### 
