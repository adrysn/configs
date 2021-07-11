#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

. ./common.sh


# === Install default packages.
case "${OS}" in
    "ubuntu")
        sudo apt update -y
        sudo apt install -y vim htop
        ;;
    "centos")
        sudo yum update -y
        sudo yum install -y vim htop
        ;;
    "osx")
        brew install macvim reattach-to-user-namespace htop
        ;;
esac


# === Git configs.
git config --global user.name "Jonghyun Park"
git config --global user.email "adrysn@gmail.com"
git config --global pull.rebase false


# === Install zsh and make it as the default shell.
if [[ `echo ${SHELL}` != *"zsh" ]] ; then
    info "Installing zsh ..."
    case "${OS}" in
        "ubuntu") sudo apt install -y zsh ;;
        "centos") yum install -y zsh ;;
        "osx") brew install zsh ;;
    esac
    chsh -s $(which zsh)
    info "zsh is now the default shell."
    note "Please launch zsh shell and run install_packages.sh."
fi
