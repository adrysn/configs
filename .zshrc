if [ -f ~/.my_envs ]; then
    source ~/.my_envs
fi

if [ -f ~/.my_aliases ]; then
    source ~/.my_aliases
fi

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"

source ~/.iterm2_shell_integration.zsh
