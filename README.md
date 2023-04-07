## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are (usually) hidden files used to configure a Unix-like system and its applications. This repo contains my own dotfiles, currently based around [Debian 12](https://wiki.debian.org/DebianBookworm), as well as scripts for automatically getting my machines up and running after a clean OS install. [GitHub](https://dotfiles.github.io/) has gathered some nice tutorials if you want to know more about how to manage your dotfiles.

Note that my dotfiles are in a constant state of change! They work for me (most of the time, anyways), but may not work for or suit you. Thus, if you plan to use stuff from this repo, **review the code first**. Remove or change things you don't want or need.

## System at a glance <a name = "system_at_a_glance"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Debian 12](https://wiki.debian.org/DebianBookworm)|
| Window manager      | [river](https://github.com/riverwm/river)|
| Wallpaper           | [#282c34](https://www.colorhexa.com/282c34)|
| Bar                 | [yambar](https://codeberg.org/dnkl/yambar)|
| Cursor              | [phinger-cursors](https://github.com/phisch/phinger-cursors)|
| Shell               | [zsh](https://www.zsh.org/)|
| Terminal            | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono) + [Nerd Font patch](https://www.nerdfonts.com/font-downloads)|
| Editor              | [Neovim](https://neovim.io/)|
| File manager        | [ranger](https://github.com/ranger/ranger)|

## Install <a name = "install"></a>

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```
