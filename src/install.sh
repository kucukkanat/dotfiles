#!/bin/bash
#### COLORS ####
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Copy dotfiles
cp ${DF_ROOT}/src/dotfiles/.bash_profile $HOME
cp ${DF_ROOT}/src/dotfiles/.tmux.conf $HOME
cp ${DF_ROOT}/src/dotfiles/.vimpluginrc $HOME
cp ${DF_ROOT}/src/dotfiles/.vimrc $HOME
mkdir -p $HOME/.config/fish
cp ${DF_ROOT}/src/dotfiles/config.fish $HOME/.config/fish

# Install binary dependencies
dependencies=(git tmux vim go node fish)
for dep in "${dependencies[@]}"; do
    if [ -z $(command -v $dep) ]; then
        printf "\n${yel}$dep is not installed. Will install now. ${end}\n"
        ${DF_ROOT}/src/piu install $dep
    fi
done

# Install node dependencies
yarn_dependencies=(typescript http-server nodemon prettier eslint)
if [ -z $(command -v yarn) ]; then
    npm install -g yarn
fi
for dep in "${yarn_dependencies[@]}"; do
    printf "\n${blue}Installing $dep ${end}"
    yarn global add $dep
done

# Install Vim Plugins
source ${DF_ROOT}/src/functions/install_vim_plugins.sh
# Install fff
source ${DF_ROOT}/src/functions/install_fff.sh
# Install Go Packages
go get -u github.com/gokcehan/lf
go get github.com/jesseduffield/lazygit
# Install Git Prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
# Install Git completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >$HOME/git-completion
# Npm global without sudo
mkdir -p "${HOME}/.npm-packages"
if [ -n $(command -v npm) ]; then
    npm config set prefix "${HOME}/.npm-packages"
else
    printf "\nNPM is not installed\n"
    printf "Install npm and run this script again to set npm config\n"
fi

printf "\n${blu}Installation complete.${end} \n"
