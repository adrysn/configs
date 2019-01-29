export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="\u@mpr15:\W$ "

if [ -f ~/.my_envs ]; then
    . ~/.my_envs
fi

if [ -f ~/.my_aliases ]; then
    . ~/.my_aliases
fi

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"

source ~/.iterm2_shell_integration.zsh
