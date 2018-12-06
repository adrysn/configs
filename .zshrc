export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL="mvim -v"
export EDITOR="$VISUAL"

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.env_local ]; then
  source ~/.env_local
fi

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"

source ~/.iterm2_shell_integration.zsh

export PATH="/usr/local/bin:$HOME/bin:$PATH"

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:`yarn global bin`"

# pyenv / pyenv-virtualenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# go
export PATH=$PATH:/usr/local/go/bin:/Users/adrysn/Develop/go/bin
export GOPATH=$HOME/Develop/go

# fzf & ripgrep
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
