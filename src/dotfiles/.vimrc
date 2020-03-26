" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
" Fast saving
nmap <leader>w :w!<cr>

" Always search case insensitive
set ignorecase
" Autoload file if changed outside vim
set autoread
" No irritating swap file
set noswapfile
" Map esc key to ;; for conveinenve
imap ;; <Esc>
" Set tab size
set autoindent
set tabstop=2
set shiftwidth=2
" Vim puts spaces instead of tab when you use tab key
set expandtab
" Set line numbers
set number
" Enable syntax highlighting
syntax on  
" Highlight search
set hlsearch
" Add suffixes to be able to go to files without extension
set suffixesadd+=.js
set suffixesadd+=.ts
set suffixesadd+=.jsx
set suffixesadd+=.tsx
" Copy to clipboard
vmap '' :w !pbcopy<CR><CR>

" Open / Close tabs easily
" CR is Carriage Return ~ ENTER
nmap TC :tabclose<CR>
nmap TN :tabnew 
" Enable AutoComplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" Set Mouse for 'a' = 'All'
set mouse=a
" Go to file for npm scoped packages
set isfname+=@-@
" Set path for nodejs projects for gf
set path+=$PWD/node_modules

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
" ===== END CORE CONFIG ======= "

source $HOME/.vimpluginrc