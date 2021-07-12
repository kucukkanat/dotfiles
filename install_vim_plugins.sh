VIM_PLUGIN_DIR="$HOME/.vim/pack/vendor/start"
rm -rf $VIM_PLUGIN_DIR
mkdir -p $VIM_PLUGIN_DIR

cd $VIM_PLUGIN_DIR
# Install nerdtree
git clone https://github.com/preservim/nerdtree.git $VIM_PLUGIN_DIR/nerdtree

# VSCode theme
git clone https://github.com/tomasiser/vim-code-dark.git $VIM_PLUGIN_DIR/codedark

# COC Vim Autocomplete
git clone https://github.com/neoclide/coc.nvim.git $VIM_PLUGIN_DIR/coc.vim

# Vim Prettier
git clone https://github.com/prettier/vim-prettier $VIM_PLUGIN_DIR/vim-prettier

# Vim GO
git clone https://github.com/fatih/vim-go.git $VIM_PLUGIN_DIR/vim-go

# FZF Vim
git clone https://github.com/junegunn/fzf.vim.git $VIM_PLUGIN_DIR/fzf.vim

# Vim Fugitive
git clone https://tpope.io/vim/fugitive.git $VIM_PLUGIN_DIR/fugitive
# vim -u NONE -c "helptags fugitive/doc" -c q

# Vim Typescript
git clone https://github.com/leafgarland/typescript-vim.git $VIM_PLUGIN_DIR/typescript-vim
