#!/usr/bin/env bash
set -e

DOTFILES_DIR=./dotfiles
mkdir -p $DOTFILES_DIR/.config


# -- Shell
\cp -f $DOTFILES_DIR/.baseh_profile ${HOME}/
\cp -f $DOTFILES_DIR/.my_aliases.sh ${HOME}/
\cp -f $DOTFILES_DIR/.my_envs.sh ${HOME}/
\cp -f $DOTFILES_DIR/.zshrc ${HOME}/
# Zprezto
\cp -f $DOTFILES_DIR/.zpreztorc ${HOME}/


# -- Tmux
\cp -f $DOTFILES_DIR/.tmux.conf ${HOME}/


# -- Terminal
# WezTerm
\cp -f $DOTFILES_DIR/.wezterm.lua ${HOME}/
\cp -f $DOTFILES_DIR/.config/wezterm ${HOME}/.config/


# -- Vi(m)
\cp -f $DOTFILES_DIR/.vimrc ${HOME}/
# NeoVim
\cp -f $DOTFILES_DIR/.config/nvim ${HOME}/.config/

