export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
if [ -x "$(command -v mvim)" ]; then
    export VISUAL="mvim -v"
elif [ -x "$(command -v vim)" ]; then
    export VISUAL="vim -v"
else
    export VISUAL="vi"
fi
export EDITOR="$VISUAL"

export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/bin:$PATH"

# Node.js
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# pyenv / pyenv-virtualenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
fi
if [ -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ]; then
    eval "$(pyenv virtualenv-init -)"
fi

# Golang
export PATH="$PATH:$HOME/go/bin"

# fzf & ripgrep
if [ -f "$HOME/.fzf.zsh" ]; then
    source $HOME/.fzf.zsh
    export FZF_DEFAULT_OPTS='--height 50% --border'
    export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
fi

# scm_breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# bat
export BAT_THEME="Solarized (dark)"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# MacTex
[ -f "/Library/Tex/texbin" ] && export PATH="$PATH:/Library/TeX/texbin"

# Created by `userpath` on 2020-07-03 03:40:41
export PATH="$HOME/.local/bin:$PATH"
