export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PS1="\u@mpr15:\W$ "
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/vim

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.env_local ]; then
    . ~/.env_local
fi

[ -s "/Users/adrysn/.scm_breeze/scm_breeze.sh" ] && source "/Users/adrysn/.scm_breeze/scm_breeze.sh"
