## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are hidden files often used to configure applications and various system settings. This repo contains my own dotfiles, currently based around [Debian Testing](https://wiki.debian.org/DebianTesting), as well as scripts for automatically getting my machines up and running after a clean OS install. For a general introduction to dotfiles, check out [GitHub does dotfiles](https://dotfiles.github.io/). Note that my dotfiles are the result of years of constant tweaking and tinkering. They work for me, but may not work for you. Thus, review the code and remove things you don’t want or need. [Do not fork](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) my dotfiles or run `build.sh` unless you know what your are doing.

## Table of Contents

* [Install](#install)
* [Overview](#overview)
* [Details](#details)
    * [Why Debian?](#why_debian)
    * [Applications](#applications)

## Install <a name = "install"></a>

With that said, the easiest way to get started *is* to clone this repo and running `build.sh`:

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

# Overview <a name = "overview"></a>

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

### Why Debian? <a name = "why_debian"></a>

### Applications <a name = "applications"></a>
