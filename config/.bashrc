# ------------------------------------------------------------------------------
# default settings
# ------------------------------------------------------------------------------

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
 
# ------------------------------------------------------------------------------
# source functions
# ------------------------------------------------------------------------------

source ~/dotfiles/config/.bash_functions

# ------------------------------------------------------------------------------
# custom prompt
# ------------------------------------------------------------------------------

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[1;93m\]\u\[\e[0m\] \[\e[1;37m\]on \[\e[1;93m\]\h \[\e[37m\]in \[\e[1;93m\]\w \n \[\e[2;49;39m\]\$ \[\e[0m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
     PS1='${debian_chroot:+($debian_chroot)}\[\e[1;93m\]\u\[\e[0m\] \[\e[1;37m\]on \[\e[1;93m\]\h \[\e[37m\]in \[\e[1;93m\]\w \n \[\e[2;49;39m\]\$ \[\e[0m\]'
    ;;
*)
    ;;
esac

# ------------------------------------------------------------------------------
# autostart tmux
# ------------------------------------------------------------------------------

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# ------------------------------------------------------------------------------
# aliases
# ------------------------------------------------------------------------------

alias ls='ls -A --color=auto'
alias ll='ls -alF --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias c='clear'
alias vim="/usr/bin/nvim.appimage"
alias nvim="/usr/bin/nvim.appimage"
alias zathura="ztab"

# ------------------------------------------------------------------------------
# environment variables
# ------------------------------------------------------------------------------

# freesurfer
if [ -d "/usr/local/freesurfer" ]; then
    export FREESURFER_HOME=/usr/local/freesurfer
    source $FREESURFER_HOME/SetUpFreeSurfer.sh
fi

# matlab 
if [ -d "/usr/local/MATLAB" ]; then
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

PATH=$PATH:~/.local/bin
export FZF_DEFAULT_COMMAND="find -L"
export EDITOR="/usr/bin/nvim.appimage"
