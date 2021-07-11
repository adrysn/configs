#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# ZSH_DISABLE_COMPFIX=true

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

[ -f ~/.my_envs.sh ] && source $HOME/.my_envs.sh
[ -f ~/.my_aliases.sh ] && source $HOME/.my_aliases.sh
[ -f ~/.my_secrets.sh ] && source $HOME/.my_secrets.sh

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
