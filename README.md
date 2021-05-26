## dotfiles?

[Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) are (usually) hidden files used to configure a system settings and its applications. This repo contains my own dotfiles, currently based around [Pop!_OS](https://pop.system76.com/), as well as scripts for automatically getting my machines up and running after a clean OS install. For a general introduction to dotfiles, check out [GitHub does dotfiles](https://dotfiles.github.io/). Note that my dotfiles are the result of years of constant tweaking and tinkering. They work for me, but may not work for you. Thus, if you plan to use stuff from this repo, **review** the code and remove things you don’t want or need. [Do not fork](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/) my dotfiles or run `build.sh` unless you know what your are doing.

I use my computers almost exclusively for research, and this is reflected in my dotfiles. Some applications, like [neovim](https://neovim.io/), are setup in a fairly specific manner, suited to my tastes and needs. Some projects I work on may require certain applications that I use intensively for a while, and then tend to forget about. Thus, the associated [wiki](https://github.com/carldelfin/dotfiles/wiki) serves as a kind of reference manual for myself. Perhaps you might find it useful, too.

## System at a glance <a name = "system_at_a_glance"></a>

| Component           | Link                                            |
| --------------------| :-----------------------------------------------|
| Distro              | [Pop!_OS](https://pop.system76.com/)|
| WM                  | [bspwm](https://github.com/baskerville/bspwm)|
| Bar                 | [Polybar](https://github.com/polybar/polybar)|
| Theme               | [Adwaita One Dark](https://github.com/lonr/adwaita-one-dark)|
| Icons               | [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)|
| Wallpaper           | [Pop One Dark](https://github.com/carldelfin/dotfiles/blob/main/wallpaper/pop_one_dark.png)|
| Terminal            | [kitty](https://sw.kovidgoyal.net/kitty/)|
| Terminal font       | [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) + [Nord Font patch](https://www.nerdfonts.com/font-downloads)|

## Install <a name = "install"></a>

With the above in mind, the easiest way to get started *is* to clone this repo and just executing `build.sh`:

```bash
git clone https://github.com/carldelfin/dotfiles.git && cd dotfiles && bash build.sh
```
