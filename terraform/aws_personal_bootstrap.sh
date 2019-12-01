#! /bin/bash

USERNAME=ubuntu
HOMEDIR=/home/$USERNAME

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/adrysn/configs.git $HOMEDIR/configs
cp $HOMEDIR/configs/dotfiles/.bash_profile $HOMEDIR
cp $HOMEDIR/configs/dotfiles/.my_aliases.sh $HOMEDIR
cp $HOMEDIR/configs/dotfiles/.my_envs.sh $HOMEDIR
source $HOMEDIR/.my_aliases.sh
source $HOMEDIR/.my_envs.sh

# vim
cp $HOMEDIR/configs/dotfiles/.vimrc $HOMEDIR
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# tmux
cp $HOMEDIR/configs/dotfiles/.tmux.conf $HOMEDIR

# zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
cp $HOMEDIR/configs/dotfiles/.zpreztorc $HOMEDIR
cp $HOMEDIR/configs/dotfiles/.zshrc $HOMEDIR
sudo chsh -s $(which zsh) $USERNAME

# pyenv
git clone https://github.com/pyenv/pyenv.git $HOMEDIR/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $HOMEDIR/.pyenv/plugins/pyenv-virtualenv

# fzf / ripgrep
git clone --depth 1 https://github.com/junegunn/fzf.git $HOMEDIR/.fzf
$HOMEDIR/.fzf/install --all

# scm_breeze
git clone git://github.com/scmbreeze/scm_breeze.git $HOMEDIR/.scm_breeze
$HOMEDIR/.scm_breeze/install.sh
