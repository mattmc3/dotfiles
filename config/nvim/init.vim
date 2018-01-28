set guifont=Monaco:h14
" set termguicolors

" Change color on insert mode
au InsertEnter * hi Normal ctermbg=234 guibg=#000000
au InsertLeave * hi Normal ctermbg=232 guibg=#1b1d1e

" execute pathogen#infect()
" filetype plugin indent on
" set laststatus=2

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

set nocompatible              " Not compatible with vi
filetype off                  " required

set clipboard=unnamed " Make vim use system keyboard

set tabstop=4 shiftwidth=4 expandtab " Set TAB to four spaces
set number " Enable line numbers
set mouse=a " Enable mouse integration

" Syntax & Coloring
syntax enable

" Enable colors
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " Neovim only

" colorscheme OceanicNext
set background=dark

" Keybindings
map <F7> mzgg=G`z " Reindent entire file

" Functions
command W silent execute 'write !sudo tee ' . shellescape(@%, 1) . ' >/dev/null'
