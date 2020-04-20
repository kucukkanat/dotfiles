# Assure folder
source ${DF_ROOT}/src/functions/prompt_user.sh

install_vim_plugin() {
	vim_plugin_path="$HOME/.vim/pack/git-plugins/start"
	rm -rf vim_plugin_path
	mkdir -p $vim_plugin_path
	cd $vim_plugin_path
	git clone $1 --depth 1
}

install_coc_vim() {
  mkdir -p ~/.vim/pack/coc/start
  cd ~/.vim/pack/coc/start
  curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -
}

install_vim_plugin https://github.com/preservim/nerdtree.git
install_vim_plugin https://github.com/tomasiser/vim-code-dark.git
install_vim_plugin https://github.com/pangloss/vim-javascript
install_vim_plugin https://github.com/mattn/emmet-vim
install_vim_plugin https://github.com/dense-analysis/ale.git
install_vim_plugin https://github.com/leafgarland/typescript-vim
install_vim_plugin https://github.com/peitalin/vim-jsx-typescript
install_vim_plugin https://github.com/vim-airline/vim-airline
install_vim_plugin https://tpope.io/vim/fugitive.git
install_coc_vim
# These require 'prettier' and 'typescript' installed!
install_vim_plugin https://github.com/Quramy/tsuquyomi.git
install_vim_plugin https://github.com/prettier/vim-prettier.git
