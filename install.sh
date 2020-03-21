#!/bin/bash
DOTFILES_FOLDER=$(pwd)
#### COLORS ####
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

if [ -z $(command -v git) ]; then
	printf "\n${red}This script requires \"git\" to be installed on your system!\n"
	printf "\nPlease install git first${end}\n\n"
	exit 1
fi

prompt_user() {
	printf "\n"
	read -n 1 -p "${blu}$1 y/n ?${end}" user_answer
	printf "\n"
	if [[ $user_answer == y ]] || [[ -z $user_answer ]];then
		eval $2
	else
		eval $3
	fi
}
install_vim_plugin(){
	local vim_plugin_path="$HOME/.vim/pack/plugins/start"
	if [ ! -d vim_plugin_path ];then
		# create vim plugin path if does not exist
		mkdir -p $vim_plugin_path
	fi
	cd $vim_plugin_path
	git clone $1 --depth 1
}

# Check if command is available in the system
is_installed(){
	local result=1
	if [ -z $(command -v $1) ]; then
		local result=0
	fi
	# Echo is like return here
	echo $result
}

# Install lazygit
install_lazygit(){
	if [ $(is_installed go) == 0];then
		printf "\n${red}Go is not installed on your system! Please install go first!${end}\n"
		exit 1
	fi
	go get github.com/jesseduffield/lazygit
}

# Install gokcehan/lf
install_lf(){
	mkdir -p $HOME/.config/lf
	go get -u github.com/gokcehan/lf
}

install_tsuquyomi(){
	if [ $(is_installed yarn) == 1  ];then
		yarn global add typescript
		git clone https://github.com/Quramy/tsuquyomi.git
	else
		printf "\n${red}yarn is not installed can not install tsuquyomi${end}\n"
	fi
}
install_vimprettier(){
	if [ $(is_installed yarn) == 1 ];then
	yarn global add prettier
	git clone https://github.com/prettier/vim-prettier.git
	else
		printf "\n${red}yarn is not installed can not install vim_prettier${end}\n"
	fi
}

install_git_prompt(){
	# Install Git Prompt
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
}

install_vim_plugins(){
	# Install Vim plugins
	install_vim_plugin https://github.com/preservim/nerdtree.git
	install_vim_plugin https://github.com/tomasiser/vim-code-dark.git
	install_vim_plugin https://github.com/sheerun/vim-polyglot
	install_vim_plugin https://github.com/mattn/emmet-vim
	install_vim_plugin https://github.com/dense-analysis/ale.git

	install_tsuquyomi
	install_vimprettier
	
	# Copy .vimrc with plugins
	cp $DOTFILES_FOLDER/.vimrc_withplugins $HOME
	mv $HOME/.vimrc_withplugins $HOME/.vimrc
}

vim_no_plugins(){
	cp $(pwd)/.vimrc $HOME
}

######################
#### START SCRIPT ####
######################
# Copy fish profile
mkdir -p $HOME/.config/fish
cp $DOTFILES_FOLDER/config.fish $HOME/.config/fish
# Copy bash profile
cp $DOTFILES_FOLDER/.bash_profile $HOME
# Copy Tmux Config
cp $DOTFILES_FOLDER/.tmux.conf $HOME

# Npm global without sudo
mkdir -p "${HOME}/.npm-packages"
if [ -n $(command -v npm) ]; then
	npm config set prefix "${HOME}/.npm-packages"
else
	printf "\nNPM is not installed\n"
	printf "Install npm and run this script again to set npm config\n"
fi

prompt_user "Do you want to install vim plugins? :$end " install_vim_plugins vim_no_plugins

# Install homebrew if MAC
if [[ "$OSTYPE" == "darwin"* ]] && [[ $(is_installed brew) == 0 ]]; then
		printf "\nHomebrew is not installed, will install now: "
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install FFF
mkdir -p $HOME/bin
curl https://raw.githubusercontent.com/dylanaraps/fff/master/fff > $HOME/bin/fff
chmod +x $HOME/bin/fff

# Install Git completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > $HOME/git-completion

# Install Git Prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

printf "\n${blu}Installation complete.${end} \n"


