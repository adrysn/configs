#!/bin/bash

# # Add user account
# USERNAME=adrysn
# useradd -s /bin/bash -m -d "/home/$USERNAME" $USERNAME
# usermod -aG sudo $USERNAME

## Create a shortcut file to convert to user account
#cat > /usr/local/bin/$USERNAME.sh <<EOF
##! /bin/sh
#sudo -u $USERNAME -s -H $(getent passwd $USERNAME | cut -d: -f7) -l
#EOF
#chmod +x /usr/local/bin/$USERNAME.sh

apt update
apt install -y zsh
# ## pyenv
apt install -y make build-essential libssl-dev \
    zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
    liblzma-dev

apt install -y snapd
snap install ripgrep --classic  # ripgrep is not available in 18.04 repo
