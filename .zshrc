export SHELL=/usr/local/bin/zsh
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

if [ -f ~/.my_envs.sh ] ; then source $HOME/.my_envs.sh ; fi
if [ -f ~/.my_aliases.sh ] ; then source $HOME/.my_aliases.sh ; fi

bindkey -v

# added by travis gem
[ -f /Users/adrysn/.travis/travis.sh ] && source /Users/adrysn/.travis/travis.sh
