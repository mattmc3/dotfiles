" set guifont=Monaco:h14
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
" set langmap=jh,kj,hk
"     ^
"     j
" < h   l >
"     k
"     v
set langmap=jk,kj

" jj to get back to normal mode
" :imap jj <ESC>
inoremap jj <Esc>`^

" Make U be redo instead of undo line
noremap U <C-r>

set nocompatible              " Not compatible with vi
filetype off                  " required

set clipboard+=unnamed " Make vim use system

set tabstop=4 shiftwidth=4 expandtab " Set TAB to four spaces
set number " Enable line numbers
set relativenumber " show relative line numbers
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
" command W silent execute 'write !sudo tee ' . shellescape(@%, 1) . ' >/dev/null'

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

" set fileencoding=utf-8
set showcmd  " show commands as I type them
set clipboard+=unnamed
set lazyredraw
set showmatch
set virtualedit=block

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" use column 80 as a vertical indicator
if exists('+colorcolumn')
  set colorcolumn=80,120
  " Change guibg color
  highlight ColorColumn guibg=#030303
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" https://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

