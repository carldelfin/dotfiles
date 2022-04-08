# --------------------------------------------------------------------------------------------------
# misc 
# --------------------------------------------------------------------------------------------------

# source shell functions
source ~/dotfiles/config/zsh/.shell_functions

# automatic cd
setopt AUTO_CD

# case insensitive globbing
setopt NO_CASE_GLOB

# recolor autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

# change prompt
PROMPT="%F{003}%B%n%b%f on %F{003}%B%m%b%f in %F{003}%B%~%b%f"$'\n'" > "

# --------------------------------------------------------------------------------------------------
# plugins
# --------------------------------------------------------------------------------------------------

source /usr/share/zplug/init.zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

# install/load new plugins when zsh is started or reloaded
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# --------------------------------------------------------------------------------------------------
# history
# --------------------------------------------------------------------------------------------------

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# share history across multiple zsh sessions
setopt SHARE_HISTORY

# append to history
setopt APPEND_HISTORY

# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY

# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 

# do not store duplications
setopt HIST_IGNORE_DUPS

#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS

# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# --------------------------------------------------------------------------------------------------
# completion/correction 
# --------------------------------------------------------------------------------------------------

setopt CORRECT
setopt CORRECT_ALL

# completion system
autoload -Uz compinit && compinit

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# --------------------------------------------------------------------------------------------------
# aliases
# --------------------------------------------------------------------------------------------------

alias ls='ls -A'
alias ll='ls -alF --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias c='clear'
alias e='exit'
alias rr='ranger'
alias vim='/usr/bin/nvim.appimage'
alias nvim='/usr/bin/nvim.appimage'
alias ff='vim $(fzf --height 40% --reverse)'

# --------------------------------------------------------------------------------------------------
# environment variables
# --------------------------------------------------------------------------------------------------

# zoxide
eval "$(zoxide init bash --cmd t)"

# freesurfer
if [ -d "/usr/local/freesurfer" ]; then
    export FREESURFER_HOME=/usr/local/freesurfer
    source $FREESURFER_HOME/SetUpFreeSurfer.sh
fi

# matlab
if [ -d "/usr/local/MATLAB" ]; then
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

# neovim
PATH=$PATH:~/.local/bin
export FZF_DEFAULT_COMMAND="find -L"
export EDITOR="/usr/bin/nvim.appimage"
PATH="$HOME/.local/bin:$PATH"

# ranger
RANGER_LOAD_DEFAULT_RC=false

# go
export PATH=$PATH:/usr/local/go/bin

# ltex
export PATH=$PATH:/home/cmd/.local/bin/ltex-ls-15.2.0/bin

# xsecurelock
export XSECURELOCK_AUTH_BACKGROUND_COLOR=rgb:40/44/52
export XSECURELOCK_AUTH_FOREGROUND_COLOR=rgb:235/203/139
export PATH=/usr/local/go/bin:/home/cmd/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/cmd/.local/bin:/usr/local/go/bin:/home/cmd/.local/bin/ltex-ls-15.2.0/bin
