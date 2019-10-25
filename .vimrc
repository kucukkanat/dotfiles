" No irritating swap file
:set noswapfile
" Map esc key to ;; for conveinenve
:imap ;; <Esc>
" Show line numbers in file explorer
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
" Show status line (filename) # https://shapeshed.com/vim-statuslines/
:set laststatus=2
" Set tab size
:set tabstop=2
:set shiftwidth=2
" Set line numbers
:set number
" Enable syntax highlighting
:syntax on 

" Vim-Plug Plugins
" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/Quramy/tsuquyomi'
Plug 'https://github.com/sheerun/vim-polyglot'
call plug#end()

