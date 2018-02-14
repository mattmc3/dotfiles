set guifont=Monaco:h14
" set termguicolors

" Change color on insert mode
au InsertEnter * hi Normal ctermbg=234 guibg=#000000
au InsertLeave * hi Normal ctermbg=232 guibg=#1b1d1e

" execute pathogen#infect()
" filetype plugin indent on
" set laststatus=2

" QWERTY Navigation
"     ^
"     k      Hint:  The h key is at the left and moves left.
" < h   l >  The l key is at the right and moves right.
"     j      The j key looks like a down arrow.
"     v
"
" Colemak navigation
"     ^
"     h
" < j   l >
"     k
"     v
set langmap=jh,kj,hk

" jj to get back to normal mode
:imap jj <ESC>

set nocompatible              " Not compatible with vi
filetype off                  " required

set clipboard=unnamed " Make vim use system

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

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'nanotech/jellybeans.vim', { 'as': 'jellybeans' }
Plug 'vim-airline/vim-airline'

" Initialize plugin system
call plug#end()

color jellybeans

" Always show statusline
set laststatus=2

let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python2_host_prog = '/usr/local/bin/python'

set encoding=utf-8
let g:airline_powerline_fonts = 1
