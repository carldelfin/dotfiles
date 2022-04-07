# history
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# completion system
autoload -Uz compinit
compinit

source ~/dotfiles/config/.shell_functions

# ------------------------------------------------------------------------------
# aliases
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# environment variables
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# zplug - manage plugins
# ------------------------------------------------------------------------------

source /usr/share/zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf"
zplug "themes/robbyrussell", from:oh-my-zsh, as:theme   # Theme

# zplug - install/load new plugins when zsh is started or reloaded
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

