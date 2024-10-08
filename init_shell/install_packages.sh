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


# === Install eza.
if ! command -v eza &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install eza
            ;;
        *)  # Rust is required
            cargo install eza
    esac
fi


# === Install bat.
if ! command -v bat &> /dev/null ; then
    case "${OS}" in
        "ubuntu")
            sudo apt install -y bat
            ;;
        "centos")
	        bat_version=$(get_latest_release_from_github sharkdp bat)
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
	        dust_version=$(get_latest_release_from_github bootandy dust)
            curl -OL https://github.com/bootandy/dust/releases/download/v${dust_version}/dust-v${dust_version}-x86_64-unknown-linux-musl.tar.gz
            tar -xvf dust-v${dust_version}-x86_64-unknown-linux-musl.tar.gz
            sudo mv dust-v${dust_version}-x86_64-unknown-linux-musl/dust /usr/local/bin/
            rm -rf dust-v${dust_version}-x86_64-unknown-linux-musl*
            ;;
    esac
fi


# === Install duf.
if ! command -v duf &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install duf
            ;;
        *)
	    duf_version=$(get_latest_release_from_github muesli duf)
            curl -OL https://github.com/muesli/duf/releases/download/v${duf_version}/duf_${duf_version}_linux_x86_64.tar.gz
            mkdir duf_${duf_version}_linux_x86_64
            tar -xvf duf_${duf_version}_linux_x86_64.tar.gz -C duf_${duf_version}_linux_x86_64
            sudo mv duf_${duf_version}_linux_x86_64/duf /usr/local/bin/
            rm -rf duf_${duf_version}_linux_x86_64*
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
            sudo yum install -y ripgrep
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
	        fd_version=$(get_latest_release_from_github sharkdp fd)
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
	        delta_version=$(get_latest_release_from_github dandavison delta)
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
fi


# === Install gh (Github CLI)
if ! command -v gh &> /dev/null ; then
    case "${OS}" in
        "osx")
            brew install gh ;;
        "centos")
	        gh_version=$(get_latest_release_from_github cli cli)
            curl -OL https://github.com/cli/cli/releases/download/v${gh_version}/gh_${gh_version}_linux_amd64.tar.gz
            tar -xvf gh_${gh_version}_linux_amd64.tar.gz
            sudo mv gh_${gh_version}_linux_amd64/bin/gh /usr/local/bin/
            rm -rf gh_${gh_version}_linux_amd64*
            ;;
    esac
    git config --global pager.diff "delta"
    git config --global pager.log "delta"
    git config --global pager.reflog "delta"
    git config --global pager.show "delta"
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.features "line-numbers decorations"
    git config --global delta.whitespace-error-style "22 reverse"
fi


# === Install scm_breeze.
if [[ ! -d "${ZDOTDIR:-$HOME}/.scm_breeze" ]] ; then
    info "Installing scm_breeze ..."
    git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
    ${HOME}/.scm_breeze/install.sh
    case "${OS}" in
        "osx") sed_cmd="sed -i ''" ;;
        *) sed_cmd="sed -i" ;;
    esac
    [[ -f ${HOME}/.bashrc ]] && ${sed_cmd} "/scm_breeze.sh/d" "${HOME}/.bashrc"
    [[ -f ${HOME}/.bash_profile ]] && ${sed_cmd} "/scm_breeze.sh/d" "${HOME}/.bash_profile"
    [[ -f ${HOME}/.zshrc ]] && ${sed_cmd} "/scm_breeze.sh/d" "${HOME}/.zshrc"
    info "Installed scm_breeze.vim."
fi


# === Install vim plugins.
if [[ ! -f "${HOME}/.vim/autoload/plug.vim" ]] ; then
    info "Installing plug.vim ..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
    info "Installed plug.vim."
fi


# === Install nvim and its plugins.
if [[ ! -d "${HOME}/.config/nvim" ]] ; then
    info "Configuring nvim ..."
    \cp -rf /tmp/_configs/dotfiles/.config/nvim "${HOME}/.config/"
    info "Configured nvim."
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


# # === Install nvm.
# if ! command -v nvm &> /dev/null ; then
#     git clone https://github.com/nvm-sh/nvm.git "${HOME}/.nvm"
# fi


# === Install fnm instead of nvm.
if ! command -v fnm &> /dev/null ; then
    curl -fsSL https://fnm.vercel.app/install | bash
fi
