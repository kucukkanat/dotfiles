#!/usr/bin/env bash

install_vim_plug() {
    echo "Installing vim-plug : "
    
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_vim_plug

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
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}
install_lf () {
	brew install lf
}

# Check OS
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        install_linuxbrew

        install_fzf
		install_lf
elif [[ "$OSTYPE" == "darwin"* ]]; then
        install_homebrew

        install_fzf
		install_lf
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

# Bootstrap
# Copy files
files_to_copy=( .bash_profile .vimrc .tmux.conf )
for file_ in "${files_to_copy[@]}"
do
	cp $file_ ~/$file_
done
folders_to_copy=( bin bash_lib )
for folder_ in "${folders_to_copy[@]}"
do
	cp -a ./$folder_/. ~/$folder_
done
