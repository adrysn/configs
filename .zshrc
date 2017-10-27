export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL="mvim -v"
export EDITOR="$VISUAL"

alias vi="mvim -v"
alias vim="mvim -v"
alias git=hub

if [ -f ~/.env_local ]; then
  source ~/.env_local
fi

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"

source ~/.iterm2_shell_integration.zsh

# Node.js
export PATH="$HOME/.npm-packages/bin:$PATH"
export PATH="$PATH:`yarn global bin`"

# rabbitmq
PATH=$PATH:/usr/local/sbin

# pyenv / pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# go
export PATH=$PATH:/usr/local/go/bin:/Users/adrysn/Develop/go/bin
export GOPATH=$HOME/Develop/go
