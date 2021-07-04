#!/usr/bin/env zsh
set -o errexit
set -o nounset
set -o pipefail

WORKDIR="$(dirname '$0')"
. ./common.sh


case "${OS}" in
    "ubuntu")
        sudo apt update -y
        ;;
    "centos")
        sudo yum update -y
        ;;
    "osx")
        ;;
esac


# === Install zprezto.
if [[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]] ; then
    info "Installing zprezto ..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    cd "${ZDOTDIR:-$HOME}/.zprezto"
    git clone --recurse-submodules https://github.com/belak/prezto-contrib contrib
    cd "${WORKDIR}"
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
    git clone https://github.com/adrysn/configs.git /tmp/_configs
    \cp -f /tmp/_configs/dotfiles/.my_aliases.sh ${HOME}/
    \cp -f /tmp/_configs/dotfiles/.my_envs.sh ${HOME}/
    \cp -f /tmp/_configs/dotfiles/.tmux.conf ${HOME}/
    \cp -f /tmp/_configs/dotfiles/.vimrc ${HOME}/
    \cp -f /tmp/_configs/dotfiles/.zpreztorc ${HOME}/
    \cp -f /tmp/_configs/dotfiles/.zshrc ${HOME}/
    rm -rf /tmp/_configs
    info "Installed zprezto."
fi


# === Install exa.
if ! command -v exa &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install exa
            ;;
        *)
            exa_version=0.10.1
            curl -OL https://github.com/ogham/exa/releases/download/v${exa_version}/exa-linux-x86_64-musl-v${exa_version}.zip
            unzip exa-linux-x86_64-musl-v${exa_version}.zip -d ./exa/
            sudo mv exa/bin/exa /usr/local/bin/exa
            rm -rf ./exa exa-linux-x86_64-musl-v${exa_version}.zip
            ;;
    esac
fi


# === Install bat.
if ! command -v bat &> /dev/null ; then
    case "${OS}" in
        "ubuntu")
            sudo apt install -y bat
            ;;
        "centos")
            # -> bat
            bat_version=0.18.1
            curl -OL https://github.com/sharkdp/bat/releases/download/v${bat_version}/bat-v${bat_version}-x86_64-unknown-linux-musl.tar.gz
            tar -xvzf bat-v${bat_version}-x86_64-unknown-linux-musl.tar.gz -C .
            sudo mv ./bat-v${bat_version}-x86_64-unknown-linux-musl/bat /usr/local/bin/bat
            rm -rf ./bat-v${bat_version}-x86_64-unknown-linux-musl*
            ;;
        "osx")
            brew install bat
            ;;
    esac
fi


# === Install dust.
if ! command -v dust &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install dust
            ;;
        *)
            dust_version=0.6.0
            curl -OL https://github.com/bootandy/dust/releases/download/v${dust_version}/dust-v${dust_version}-x86_64-unknown-linux-musl.tar.gz
            tar -xvf dust-v${dust_version}-x86_64-unknown-linux-musl.tar.gz
            sudo mv dust-v${dust_version}-x86_64-unknown-linux-musl/dust /usr/local/bin/
            rm -rf dust-v${dust_version}-x86_64-unknown-linux-musl*
            ;;
    esac
fi


# === Install dust.
if ! command -v duf &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install duf
            ;;
        *)
            duf_version=0.6.2
            curl -OL https://github.com/muesli/duf/releases/download/v${duf_version}/duf_${duf_version}_linux_x86_64.tar.gz
            mkdir duf_v${duf_version}_linux_x86_64
            tar -xvf duf_v${duf_version}_linux_x86_64.tar.gz -C duf_v${duf_version}_linux_x86_64
            sudo mv duf_v${duf_version}_linux_x86_64/duf /usr/local/bin/
            rm -rf duf_v${duf_version}_linux_x86_64*
            ;;
    esac
fi


# === Install fzf.
if ! command -v fzf &> /dev/null ; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
    ~/.fzf/install --completion --key-bindings --no-update-rc
fi


# === Install ripgrep.
if ! command -v rg &> /dev/null ; then
    case "${OS}" in
        "ubuntu")
            sudo apt install -y ripgrep
            ;;
        "centos")
            sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
            sudo yum install ripgrep
            ;;
        "osx")
            brew install ripgrep
            ;;
    esac
fi

# === Install fd.
if ! command -v fd &> /dev/null ; then
    case "${OS}" in
        "ubuntu")
            sudo apt install -y fd-find
            mkdir -p ${HOME}/.local/bin
            ln -s $(which fdfind) ~/.local/bin/fd
            ;;
        "centos")
            fd_version=8.2.1
            curl -OL https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v${fd_version}-x86_64-unknown-linux-musl.tar.gz
            tar -xvf fd-v${fd_version}-x86_64-unknown-linux-musl.tar.gz
            sudo mv fd-v${fd_version}-x86_64-unknown-linux-musl/fd /usr/local/bin/
            rm -rf fd-v${fd_version}-x86_64-unknown-linux-musl*
            ;;
        "osx")
            brew install fd
            ;;
    esac
fi


# === Install jq.
if ! command -v jq &> /dev/null ; then
    case "${OS}" in
        "ubuntu")
            sudo apt install -y jq ;;
        "centos")
            sudo yum install -y jq ;;
        "osx")
            brew install jq ;;
    esac
fi


# === Install delta.
if ! command -v delta &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install git-delta ;;
        "centos")
            delta_version=0.8.2
            curl -OL https://github.com/dandavison/delta/releases/download/${delta_version}/delta-${delta_version}-x86_64-unknown-linux-musl.tar.gz
            tar -xvf delta-${delta_version}-x86_64-unknown-linux-musl.tar.gz
            sudo mv delta-${delta_version}-x86_64-unknown-linux-musl/delta /usr/local/bin/
            rm -rf delta-${delta_version}-x86_64-unknown-linux-musl*
            ;;
    esac
    git config --global pager.diff "delta"
    git config --global pager.log "delta"
    git config --global pager.reflog "delta"
    git config --global pager.show "delta"
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.features "line-numbers decorations"
    git config --global delta.whitespace-error-style "22 reverse"
    git config --global 'delta "decorations"'.commit-decoration-style "bold yellow box ul"
fi


# === Install vim plugins.
if [[ ! -f "${HOME}/.vim/autoload/plug.vim" ]] ; then
    info "Installing plug.vim ..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
    info "Installed plug.vim."
fi


# === Install pyenv.
if ! command -v pyenv &> /dev/null ; then
    info "Installing pyenv and pyenv-virtualenv ..."
    case "${OS}" in
        "ubuntu")
            sudo apt install -y make build-essential libssl-dev zlib1g-dev \
                 libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                 libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
            ;;
        "centos")
            sudo yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel
            ;;
        "osx")
            brew install openssl readline sqlite3 xz zlib
            ;;
    esac
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    info "Installed pyenv and pyenv-virtualenv."
fi


# === Install nvm.
if ! command -v nvm &> /dev/null ; then
    git clone https://github.com/nvm-sh/nvm.git ${HOME}/.nvm
fi
