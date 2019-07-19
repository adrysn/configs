export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL="mvim -v"
export EDITOR="$VISUAL"

export PATH="/usr/local/bin:$HOME/bin:$PATH"

# Node.js
[ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -x "$(command -v yarn)" ] && export PATH="$PATH:`yarn global bin`"

# pyenv / pyenv-virtualenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi
if [ -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ]; then
    eval "$(pyenv virtualenv-init -)"
fi

# Go
if [ -d "$HOME/Develop/go" ]; then
    export PATH=$PATH:/usr/local/go/bin:/Users/adrysn/Develop/go/bin
    export GOPATH=$HOME/Develop/go
fi

# fzf & ripgrep
if [ -f "$HOME/.fzf.zsh" ]; then
    source $HOME/.fzf.zsh
    export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
fi

# scm_breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
