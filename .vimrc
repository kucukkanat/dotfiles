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
" Prettier                     
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Typescript autocomplete      
Plug 'https://github.com/Quramy/tsuquyomi'
" Syntax highlighting          
" Plug 'https://github.com/sheerun/vim-polyglot'
" File explorer                
Plug 'https://github.com/scrooloose/nerdtree'
call plug#end()   
