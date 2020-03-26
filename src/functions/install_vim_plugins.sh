# Assure folder
source ${DF_ROOT}/src/functions/prompt_user.sh

install_vim_plugin() {
	vim_plugin_path="$HOME/.vim/pack/git-plugins/start"
	rm -rf vim_plugin_path
	mkdir -p $vim_plugin_path
	cd $vim_plugin_path
	git clone $1 --depth 1
}

install_vim_plugin https://github.com/preservim/nerdtree.git
install_vim_plugin https://github.com/tomasiser/vim-code-dark.git
install_vim_plugin https://github.com/pangloss/vim-javascript
install_vim_plugin https://github.com/mattn/emmet-vim
install_vim_plugin https://github.com/dense-analysis/ale.git
install_vim_plugin https://github.com/leafgarland/typescript-vim
install_vim_plugin https://github.com/vim-airline/vim-airline
# These require 'prettier' and 'typescript' installed!
install_vim_plugin https://github.com/Quramy/tsuquyomi.git
install_vim_plugin https://github.com/prettier/vim-prettier.git
