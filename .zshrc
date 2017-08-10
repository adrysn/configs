# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
if [ -f ~/.env_local ]; then
  source ~/.env_local
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

alias vi="mvim -v"
alias vim="mvim -v"

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"
