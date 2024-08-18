#!/usr/bin/env bash
set -e

DOTFILES_DIR=./dotfiles
mkdir -p "$DOTFILES_DIR/.config"


# -- Shell
[[ -f ~/.bash_profile ]] && \cp -f ~/.bash_profile $DOTFILES_DIR
[[ -f ~/.my_aliases.sh ]] && \cp -f ~/.my_aliases.sh $DOTFILES_DIR
[[ -f ~/.my_envs.sh ]] && \cp -f ~/.my_envs.sh $DOTFILES_DIR
[[ -f ~/.zshrc ]] && \cp -f ~/.zshrc $DOTFILES_DIR

# Zprezto
[[ -f ~/.zpreztorc ]] && \cp -f ~/.zpreztorc $DOTFILES_DIR


# -- Tmux
[[ -f ~/.tmux.conf ]] && \cp -f ~/.tmux.conf $DOTFILES_DIR


# -- Terminal
# WezTerm
[[ -f ~/.wezterm.lua ]] && \cp -f ~/.wezterm.lua $DOTFILES_DIR/
[[ -d ~/.config/wezterm ]] && \cp -rf ~/.config/wezterm $DOTFILES_DIR/.config/


# -- Vi(m)
[[ -f ~/.vimrc ]] && \cp -f ~/.vimrc $DOTFILES_DIR

# NeoVim (AstroNvim)
[[ -d ~/.config/nvim ]] && \cp -rf ~/.config/nvim $DOTFILES_DIR/.config/
[[ -d ~/.config/nvim/.git ]] && \rm -rf $DOTFILES_DIR/.config/nvim/.git
