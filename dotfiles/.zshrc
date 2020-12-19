ZSH_DISABLE_COMPFIX=true

# Init prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f ~/.my_aliases.sh ] && source $HOME/.my_aliases.sh
[ -f ~/.my_envs.sh ] && source $HOME/.my_envs.sh
[ -f ~/.my_secrets.sh ] && source $HOME/.my_secrets.sh

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
