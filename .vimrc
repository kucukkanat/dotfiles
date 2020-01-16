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

" Highlight search
:set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

colorscheme default
