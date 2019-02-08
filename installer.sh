#!/usr/bin/env bash

install_linuxbrew() {
    if hash brew 2>/dev/null; then
        echo "Linux Brew already exists"
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
        
        # Post install actions
        echo "Linux brew post-installation actions : \n"
        test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
        test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
        echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    fi
    
}

install_homebrew() {
    if hash brew 2>/dev/null; then
        echo "Homebrew already exists"
    else
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_fzf() {
    brew install fzf

    # To install useful key bindings and fuzzy completion:
    $(brew --prefix)/opt/fzf/install
}

# Check OS
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        install_linuxbrew

        install_fzf
elif [[ "$OSTYPE" == "darwin"* ]]; then
        install_homebrew

        install_fzf
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
        echo "Can not install fzf on ${OSTYPE}. Do it manually : https://github.com/junegunn/fzf#installation"
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        echo "Can not install fzf on ${OSTYPE}. Do it manually : https://github.com/junegunn/fzf#installation"
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        echo "Can not install fzf on ${OSTYPE}. Do it manually : https://github.com/junegunn/fzf#installation"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
        echo "Can not install fzf on ${OSTYPE}. Do it manually : https://github.com/junegunn/fzf#installation"
else
        # Unknown.
        echo "Can not install fzf on ${OSTYPE}. Do it manually : https://github.com/junegunn/fzf#installation"
fi