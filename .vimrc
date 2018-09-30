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

" Set line numbers
:set number

" Enable syntax highlighting
:syntax on 

" No swap file
:set noswapfile


call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/vim-easy-align'

" Javascript
Plug 'https://github.com/pangloss/vim-javascript'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'https://github.com/pangloss/vim-javascript'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()