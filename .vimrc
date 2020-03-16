" Always search case insensitive"
set ignorecase
" No irritating swap file
set noswapfile
" Map esc key to ;; for conveinenve
imap ;; <Esc>
" Show status line (filename) # https://shapeshed.com/vim-statuslines/
set laststatus=2
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

