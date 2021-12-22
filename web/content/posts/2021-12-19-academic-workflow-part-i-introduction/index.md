---
title: 'My academic workflow, part I: Introduction'
author: Carl Delfin
date: '2021-12-19'
slug: []
categories: []
tags: []
draft: yes
editor_options: 
  markdown: 
    wrap: sentence
---

What I aim for:

-   Open source, FOSS
-   Stability
-   Minimal (visually, system wise)
-   Control

# 1. Using Linux

Linux vs windows (vs Mac)

-   Complete control
-   Efficieny
-   Minimalism

Privacy, stability, reliability

There is a reason why the worlds supercomputers and servers almost exclusively run linux (<https://itsfoss.com/linux-runs-top-supercomputers/>)

<https://www.idc.com/promo/smartphone-market-share>

<https://www.jimhester.com/post/2020-08-20-best-os-for-r/>

In 2021, the lines of code submitted to the Linux Git repository reached 27.8 million.
In 2021, 100% of the world's top 500 supercomputers run on Linux.
Out of the top 25 websites in the world, only 2 aren't using Linux.
96.3% of the world's top 1 million servers run on Linux.
90% of all cloud infrastructure operates on Linux and practically all the best cloud hosts use it.

<https://hostingtribunal.com/blog/linux-statistics/>

<https://en.wikipedia.org/wiki/Unix_philosophy>

/proc and /sys are nice.
You get access to the guts of your system and the ability to twiddle things with very high-level languages.

Most developers seem to use a lot of software.
On Linux, most software is freely-downloadable.
You hear about something, you can use it.
If you learn a package, it's available everywhere.
One command to download and install it on most distros.

It helps to have a bit of interest in computer science

Some programs eg singularity doesn't run natively on windows or mac (<https://sylabs.io/guides/3.9/admin-guide/installation.html>)

More control over the system

More configurability

<https://en.wikipedia.org/wiki/Usage_share_of_operating_systems#Supercomputers>

<https://www.jimhester.com/post/2020-08-20-best-os-for-r/>

Lightweight

Debian 11 - stable, secure: <https://www.reddit.com/r/linux/comments/jyyl50/is_linux_really_more_secure_than_windows/>

Security wise, more or less equal?

That said, i find linux firewall (ufw) simple Minimal vs full CD

LUKS etc

bspwm/shxkcd/polybar - miminal, easy to configure

tiling wm

<https://en.wikipedia.org/wiki/History_of_the_graphical_user_interface>

<https://en.wikipedia.org/wiki/Desktop_environment>

<https://en.wikipedia.org/wiki/Tiling_window_manager>

Customizable - I can decide preety much everything

dotfiles

mention other programs, eg zathura, rofi, pass, rofi-pass

Scripting with bash

<https://missing.csail.mit.edu/>

There is no doubt that setting up one's tool chain, development workflow, interactions can be more difficult on Windows often requiring more time with powershell than one might want to spend.

# 2. R and R Markdown

## 2.1. R

Why chose R?

{{< video src="/vid/test1.mp4" type="video/mp4" preload="auto" >}}

R vs SPSS

And by the way, it’s not just tech firms: R is in use at analysis and consulting firms, banks and other financial institutions, academic institutions and research labs, and pretty much everywhere else data needs analyzing and visualizing. Even the New York Times uses R!

Because R was designed with statistical analysis in mind, it has a fantastic ecosystem of packages and other resources that are great for data science. The dplyr package, for example, makes data manipulation a breeze, and ggplot2 is a fantastic tool for data visualization.

The R community is also particularly warm and inclusive, and there are amazing groups like R Ladies and Minority R Users designed to helpmake sure everyone learn and use R skills.

https://stackoverflow.blog/2017/10/10/impressive-growth-r/

https://lindeloev.net/spss-is-dying/

As a statistician, most of the time is spent pre-processing data before doing the statistics. Since the advent of tidyr in 2014, this has become incredibly easy to do. Perhaps more importantly, it has become much easier to read the code, which facilitates seamless collaboration and empowers you to learn much quicker from examples online. Pre-processing is often a non-linear process where you go back and forth. 

 In R, you can load data, pre-process it, and do a mixed model in just five relatively self-explanatory lines of code. It would take 20+ clicks in SPSS. If you want to do it for multiple datasets, you have to go through all that SPSS-clicking again (remember the dictaphone). It is really easy to miss a click and unknowingly get wrong results. Less repetition and debugging means more time saved in R.
 
 Consider SPSS a liability. Either weakly through taking more person-hours to use. Or strongly, through the increased risk of hard-to-detect errors
 
 http://www.unige.ch/ses/sococ/cl/bib/qual/spss.history.html?
 
 https://en.wikipedia.org/wiki/SPSS
 
 R's capabilities are extended through user-created[34] packages, which offer statistical techniques, graphical devices, import/export, reporting (RMarkdown, knitr, Sweave), etc
 

## R Markdown

Writing reports in Rmarkdown

# 3. Zotero

Show FF plugin, exporting .bib

# 4. Neovim

## 4.1. Modal versus WYSIWYG

https://en.wikipedia.org/wiki/Vi#Interface

https://en.wikipedia.org/wiki/Vim_(text_editor)

Like vi, Vim's interface is not based on menus or icons but on commands given in a text user interface;

Vim has 12 different editing modes, 6 of which are variants of the 6 basic modes.[34] The most important modes are:

* Normal mode – used for editor commands. This is also the default mode, unless the insertmode option is specified.
* Visual mode – similar to normal mode, but used to highlight areas of text. Normal commands can be run on the highlighted area, for instance to move or edit a selection.
* Insert mode – similar to editing in most modern editors. In this mode, buffers can be modified with the text inserted.
* Command-line or Cmdline mode – supports a single line input at the bottom of the Vim window. Normal commands (beginning with :), and some other keys for specific actions (including pattern search and the filter command) activate this mode. On completion of the command, Vim returns to the previous mode.
    
<https://insights.stackoverflow.com/survey/2021#most-loved-dreaded-and-wanted-new-collab-tools-love-dread>

RStudio is a really good IDE

Main difference from regular text editor: modal

Benefits, show examples?

Customization, init.vim

Mention Lua?

## 4.2. Down the rabbit hole of color schemes

Custom color scheme, ayur

# 5. Combining Zotero, Rmd, Neovim

Exporting the .bib

Rmd skeleton/template

Using nvim-r

<https://csgillespie.github.io/efficientR/workflow.html>

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

First you need a microcontroller to actually communicate with the computer.
Elite c, promicro, nano

Then switches.
This could be a topic for an entire post.
Or even one post per switch.
Nevertheless, there are two main types: MX and choc.
These come in linear, tactile, and clicky variants.
These variants come with different properties, the most prominent being the amount of force necessary to activate the switch.
There are other properties as well, such as the force diagram such, affecting the general *feel* of the switch.

Then keycaps.
This is a whole other universe.
The shape/contour of switches, OEM, cherry, SA, DSA, etc.

Keycaps come in different materials, the most common being ABS and PBT plastic.
Keyboard enthusiasts enter group buys and wait for years to get a keyset they like.

In the end, I went with black, blank chocs.
No distraction!

Order all parts, get a soldering iron, and get busy!

## 7.3 Programming a keyboard

Customizing colemak-dh, focus on R programming and writing
