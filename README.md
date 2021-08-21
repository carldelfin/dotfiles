## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are hidden files (i.e., files whose filename start with a dot) used to configure a Unix-like system and its applications. This repo contains my own dotfiles, currently based around [Debian Sid](https://www.debian.org/releases/sid/), as well as scripts for automatically getting my machines up and running after a clean OS install. For a general introduction to dotfiles, check out the [Arch Linux Wiki](https://wiki.archlinux.org/title/Dotfiles). Note that my dotfiles are in a constant state of change. They work for me (most of the time, anyways), but may not work for you. Thus, if you plan to use stuff from this repo, **review the code first**. Remove or change things you don’t want or need.

## System at a glance <a name = "system_at_a_glance"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian Sid](https://www.debian.org/releases/sid/)|
| WM                  | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [Polybar](https://github.com/polybar/polybar)|
| Theme               | [Tokyo Night](https://github.com/koiosdev/Tokyo-Night-Linux)|
| Icons               | [Numix](https://github.com/numixproject/numix-icon-theme)|
| Terminal            | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + [Nord Font patch](https://www.nerdfonts.com/font-downloads)|
| Editor              | [Neovim](https://neovim.io/)|

## Install <a name = "install"></a>

With the above in mind, the easiest way to get started is to clone this repo and just executing `build.sh`:

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

## Workflow

I use my computers (one laptop and one workstation) almost exclusively for research, and this is reflected in my dotfiles. Some applications, like [Neovim](https://neovim.io/), are setup with [R](https://www.r-project.org/) and [R Markdown](https://rmarkdown.rstudio.com/) in mind, chiefly via [Nvim-R](https://github.com/jalvesaq/Nvim-R), [vimtex](https://github.com/lervag/vimtex) and [vim-pandoc](https://github.com/vim-pandoc/vim-pandoc). The associated [wiki](https://github.com/carldelfin/dotfiles/wiki), although far from complete, serves as a kind of reference manual for myself. Perhaps you might find it useful, too.
