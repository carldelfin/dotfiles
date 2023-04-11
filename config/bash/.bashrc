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

export TERM="xterm-256color"

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

source ~/dotfiles/config/.shell_functions

# ------------------------------------------------------------------------------
# aliases
# ------------------------------------------------------------------------------

alias ls='ls -alF --color=auto'
alias ll='ls -alF --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias c='clear'
alias e='exit'
alias rr='python $HOME/.local/bin/ranger-1.9.3/ranger.py'
alias vim='$HOME/.local/bin/nvim.appimage'
alias nvim='$HOME/.local/bin/nvim.appimage'
alias vf='vim $(fzf --height 40% --reverse)'
alias ff='fzf'

# ------------------------------------------------------------------------------
# environment variables and various settings
# ------------------------------------------------------------------------------

export VISUAL=nvim
export EDITOR=nvim
export FZF_DEFAULT_COMMAND="find -."

# z.lua
eval "$(lua $HOME/.local/bin/z.lua-1.8.16/z.lua --init bash enhanced once)"
export RANGER_ZLUA="$HOME/.local/bin/z.lua-1.8.16/z.lua"

function t() {
    if  [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}

# ranger
RANGER_LOAD_DEFAULT_RC=false
