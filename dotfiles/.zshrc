export SHELL=$(which zsh)
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

[ -f ~/.my_aliases.sh ] && source $HOME/.my_aliases.sh
[ -f ~/.my_envs.sh ] && source $HOME/.my_envs.sh
[ -f ~/.my_secrets.sh ] && source $HOME/.my_secrets.sh

# added by travis gem
[ -f /Users/adrysn/.travis/travis.sh ] && source /Users/adrysn/.travis/travis.sh
