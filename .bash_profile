export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PS1="\u@mpr15:\W$ "
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL="mvim -v"
export EDITOR="$VISUAL"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.env_local ]; then
    . ~/.env_local
fi

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"

source ~/.iterm2_shell_integration.zsh

export PATH="$HOME/bin:$PATH"

# Node.js
export PATH="$HOME/.npm-packages/bin:$PATH"
export PATH="$PATH:`yarn global bin`"

# pyenv / pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# go
export PATH=$PATH:/usr/local/go/bin:/Users/adrysn/Develop/go/bin
export GOPATH=$HOME/Develop/go
