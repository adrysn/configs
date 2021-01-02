set -e

DOTFILES_DIR=./dotfiles

[[ -f ~/.bash_profile ]] && \cp -f ~/.bash_profile $DOTFILES_DIR
[[ -f ~/.my_aliases.sh ]] && \cp -f ~/.my_aliases.sh $DOTFILES_DIR
[[ -f ~/.my_envs.sh ]] && \cp -f ~/.my_envs.sh $DOTFILES_DIR
[[ -f ~/.zpreztorc ]] && \cp -f ~/.zpreztorc $DOTFILES_DIR
[[ -f ~/.zshrc ]] && \cp -f ~/.zshrc $DOTFILES_DIR
[[ -f ~/.tmux.conf ]] && \cp -f ~/.tmux.conf $DOTFILES_DIR
[[ -f ~/.vimrc ]] && \cp -f ~/.vimrc $DOTFILES_DIR
