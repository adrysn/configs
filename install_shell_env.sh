#!/bin/bash
set -e

cd "$(dirname '$0')"
source ./common.sh

OSNAME="$OSTYPE"
DOTFILE_SRC_DIR=./dotfiles

cp "$DOTFILE_SRC_DIR"/.bash_profile ~
cp "$DOTFILE_SRC_DIR"/.my_* ~
# echo 'source $HOME/.bash_profile' >> ~/.bashrc


# -- Install OS packages
info "installing OS packages..."
if [[ "$OSNAME" == "darwin"* ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	sudo apt update -y
	sudo apt install -y curl git net-tools vim
fi

# -- Configure vim
info "configuring vim..."
cp "$DOTFILE_SRC_DIR"/.vimrc ~
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c 'PlugInstall'


# -- Configure tmux
info "configuring tmux..."
cp "$DOTFILE_SRC_DIR"/.tmux.conf ~
if [[ "$OSNAME" == "darwin"* ]]; then
	brew install tmux
else
	sudo apt install tmux
fi


# -- pyenv / virtualenv
info "installing pyenv / virtualenv..."
if [[ "$OSNAME" == "darwin"* ]]; then
	brew install openssl readline sqlite3 xz zlib
else
	sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv


# -- Install zprezto (if zsh exists)
if command -v zsh &> /dev/null; then
	info "installing zprezto..."
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	cp "$DOTFILE_SRC_DIR"/.zshrc ~
	cp "$DOTFILE_SRC_DIR"/.zpreztorc ~
fi

info "done."
