set number
set guifont=Monaco:h14
syntax enable
set background=dark
set termguicolors
" Change color on insert mode
au InsertEnter * hi Normal ctermbg=234 guibg=#000000
au InsertLeave * hi Normal ctermbg=232 guibg=#1b1d1e

execute pathogen#infect()
filetype plugin indent on
set laststatus=2

" Navigation
"     ^
"     k      Hint:  The h key is at the left and moves left.
" < h   l >  The l key is at the right and moves right.
"     j      The j key looks like a down arrow.
"     v
" Colemak navigation
" Trying without this at first
" noremap h k
" noremap j h
" noremap k j
