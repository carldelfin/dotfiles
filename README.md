## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are (usually) hidden files used to configure a Unix-like system and its applications. This repo contains my own dotfiles, currently based around [Debian 11](https://www.debian.org/News/2021/20210814), as well as scripts for automatically getting my machines up and running after a clean OS install. [GitHub](https://dotfiles.github.io/) has gathered some nice tutorials if you want to know more about how to manage your dotfiles.

Note that my dotfiles are in a constant state of change! They work for me (most of the time, anyways), but may not work for or suit you. Thus, if you plan to use stuff from this repo, **review the code first**. Remove or change things you don't want or need.

## System at a glance <a name = "system_at_a_glance"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian 11](https://www.debian.org/News/2021/20210814)|
| Window manager      | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [Polybar](https://github.com/polybar/polybar)|
| Theme               | [Nordic](https://github.com/EliverLara/Nordic)|
| Terminal            | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + [Nord Font patch](https://www.nerdfonts.com/font-downloads)|
| Editor              | [Neovim](https://neovim.io/)|
| File manager        | [ranger](https://github.com/ranger/ranger)|

## Install <a name = "install"></a>

With the above in mind, the easiest way to get started is to clone this repo and executing `build.sh`:

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```

## Workflow

I use my computers (one workstation, one laptop, and one barebones acting as a central server) almost exclusively for research and research-related activities, and this is reflected in my dotfiles. Some applications, like [Neovim](https://neovim.io/), are setup specifically and chiefly with [R](https://www.r-project.org/) and [R Markdown](https://rmarkdown.rstudio.com/) in mind, using [Nvim-R](https://github.com/jalvesaq/Nvim-R), [vimtex](https://github.com/lervag/vimtex) and [vim-pandoc](https://github.com/vim-pandoc/vim-pandoc). Other small applications, like [zoxide](https://github.com/ajeetdsouza/zoxide), are used to increase productivity. 

One day, I plan to write a series of blog posts about my setup. Until then, the associated [wiki](https://github.com/carldelfin/dotfiles/wiki), although far from complete, serves as a kind of reference manual for myself. Perhaps you might find it useful, too.
