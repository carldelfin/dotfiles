---
title: 'My academic workflow, part I: Introduction'
author: Carl Delfin
date: '2021-12-19'
slug: []
categories: []
tags: []
draft: yes
---

What I aim for:

- Open source, FOSS
- Stability
- Minimal (visually, system wise)
- Control

# 1. Using Linux

Linux vs windows (vs Mac)

- Complete control
- Efficieny
- Minimalism

Privacy, stability, reliability

There is a reason why the worlds supercomputers and servers almost exclusively run linux (https://itsfoss.com/linux-runs-top-supercomputers/)


https://www.idc.com/promo/smartphone-market-share

https://www.jimhester.com/post/2020-08-20-best-os-for-r/

In 2021, the lines of code submitted to the Linux Git repository reached 27.8 million.
In 2021, 100% of the world’s top 500 supercomputers run on Linux.
Out of the top 25 websites in the world, only 2 aren’t using Linux.
96.3% of the world’s top 1 million servers run on Linux.
90% of all cloud infrastructure operates on Linux and practically all the best cloud hosts use it.

https://hostingtribunal.com/blog/linux-statistics/

https://en.wikipedia.org/wiki/Unix_philosophy

/proc and /sys are nice. You get access to the guts of your system and the ability to twiddle things with very high-level languages. 

Most developers seem to use a lot of software. On Linux, most software is freely-downloadable. You hear about something, you can use it. If you learn a package, it's available everywhere. One command to download and install it on most distros. 


It helps to have a bit of interest in computer science

Some programs eg singularity doesn't run natively on windows or mac (https://sylabs.io/guides/3.9/admin-guide/installation.html)

More control over the system

More configurability

https://en.wikipedia.org/wiki/Usage_share_of_operating_systems#Supercomputers

https://www.jimhester.com/post/2020-08-20-best-os-for-r/

Lightweight

Debian 11 - stable, secure:
https://www.reddit.com/r/linux/comments/jyyl50/is_linux_really_more_secure_than_windows/

Security wise, more or less equal?

That said, i find linux firewall (ufw) simple
Minimal vs full CD

LUKS etc

bspwm/shxkcd/polybar - miminal, easy to configure

tiling wm

https://en.wikipedia.org/wiki/History_of_the_graphical_user_interface

https://en.wikipedia.org/wiki/Desktop_environment

https://en.wikipedia.org/wiki/Tiling_window_manager

Customizable - I can decide preety much everything

dotfiles

mention other programs, eg zathura, rofi, pass, rofi-pass

Scripting with bash

https://missing.csail.mit.edu/

There is no doubt that setting up one's tool chain, development workflow, interactions can be more difficult on Windows often requiring more time with powershell than one might want to spend.

# 2. R and Rmarkdown

Writing reports in Rmarkdown

# 3. Zotero

Show FF plugin, exporting .bib

# 4. Neovim

https://insights.stackoverflow.com/survey/2021#most-loved-dreaded-and-wanted-new-collab-tools-love-dread

RStudio is a really good IDE

Main difference from regular text editor: modal

Benefits, show examples?

Customization, init.vim

Mention Lua?

Sidetrack: custom color scheme, ayur

# 5. Combining Zotero, Rmd, Neovim

Exporting the .bib

Rmd skeleton/template

Using nvim-r

https://csgillespie.github.io/efficientR/workflow.html

# 6. Hardware

Local network, backups etc

Workstation, laptop, backup computer

External HDDs

Backup scripts, cronjobs

3-2-1 rule

# 7. Optimizing input: Keyboards

## 7.1 Why are things the way they are?

Two major things you can change: which letters/symbols go where (the keyboard layout), and where the keys are physically located - let's start with the first

QWERTY is standard, stems from typewriters, non jamming, etc etc

Very inefficient (show examples?)

Newer developments, dvorak, colemak, etc

(I settled on colemak-dh, with modifications)

Next is physical layout, standard, 100% keyboard has between 104 to 108 keys.

A laptop has fewer, tenkeyless or 75%

60%, 40%

But these follow the same layout as an old typwriter, with row staggared keys

Fingers are not row-staggered, and some fingers are also longer than others

Plus, do we really need all keys on a keyboard?

If you build your own, usually QMK or ZMK firmware - you code your own keyboard layout yourself, very customizable

It turns out that 34 keys is enough to do what a 100% keyboard does, and more!

## 7.2 Building a keyboard

In addition to keyboard layout and physical layout, there are tons of other options. 

First you need a microcontroller to actually communicate with the computer. Elite c, promicro, nano

Then switches. This could be a topic for an entire post. Or even one post per switch. Nevertheless, there are two main types: MX and choc. These come in linear, tactile, and clicky variants. These variants come with different properties, the most prominent being the amount of force necessary to activate the switch. There are other properties as well, such as the force diagram such, affecting the general *feel* of the switch.

Then keycaps. This is a whole other universe. The shape/contour of switches, OEM, cherry, SA, DSA, etc.

Keycaps come in different materials, the most common being ABS and PBT plastic. Keyboard enthusiasts enter group buys and wait for years to get a keyset they like.

In the end, I went with black, blank chocs. No distraction!

Order all parts, get a soldering iron, and get busy!

## 7.3 Programming a keyboard

Customizing colemak-dh, focus on R programming and writing