" ~/.vimrc
" author: mattmc3
" https://github.com/mattmc3/dotfiles
"
" Notes:
" No plugins in this config. Plugins are for nvim, not vim
"
" References:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
" https://github.com/fabi1cazenave/cua-mode.vim/blob/master/plugin/cua-mode.vim
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

"
" General settings
"
set clipboard+=unnamed          " use the OS clipboard
set nocompatible                " no need to cater to vi
set modelines=0                 " prevent security exploits - no need to execute code on file open
set encoding=utf-8              " utf-8 is the encoding we want to use for text files.
set nobackup                    " We have vcs, we don't need backups this way
set nowritebackup               " We have vcs, we don't need backups this way
set noswapfile                  " No need for this on a modern system
set hidden                      " allow me to have buffers with unsaved changes.
set autoread                    " when a file has changed on disk, just load it. Don't ask.
set autowrite                   " autosaving files is a nice feature
set lazyredraw                  " don't redraw the screen on macros, or other non-typed operations
set shortmess+=I                " no vim welcome screen
set virtualedit+=block          " allow the cursor to go anywhere in visual block mode
set visualbell                  " don't beep at me
set backspace=indent,eol,start  " define what backspace does

"
" More settings
"

" theme
set background=dark                 " tell nvim the color scheme will be a dark one
colorscheme desert                  " set the color scheme (builtin: evening, elflord)
syntax on

" editor
" to get the postscript name, use ⌘-i in fontbook
if has('gui_running')
    set guifont=MesloLGSForPowerline-Regular:h13
endif
set list                            " needed for listchars
set listchars=tab:»\ ,trail:·       " Display tabs and trailing spaces visually
set number                          " Enable line numbers
" set relativenumber                  " Show relative line numbers
set mouse=a                         " Enable mouse integration
set title                           " Sets the terminal to show the buffer title
set showcmd                         " show commands as I type thiem
set scrolloff=4                     " when scrolling around, keep a buffer of a few lines above/below

"
" indentation
"
set expandtab                       " use spaces instead of tabs.
set tabstop=4                       " number of spaces that a tab in a file counts for
set shiftwidth=4                    " affects how autoindentation works
set softtabstop=4                   " when tab is pressed, only move to the next tab stop
set shiftround                      " tab / shifting moves to closest tabstop.
set autoindent                      " match indents on new lines.
set smartindent                     " intellegently dedent / indent new lines based on rules.


"
" Key bindings
"

" space makes a nice leader key
nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Make U be redo.
nnoremap U <C-r>

" Colemak
" set langmap=je,JE,li,LI,nj,NJ,ek,EK,il,IL,kn,KN
" Arrow with neiu, and then make H-U, J->E, K->N, and L->I.
" set langmap=nh,NH,ej,EJ,il,IL,uk,UK,je,JE,li,LI,hu,HU,nh,kn,KN
" Make tn get us out of insert mode because that's handy.
" inoremap tn <ESC>
imap ii <ESC>

" Emacs shortcuts
inoremap <C-a> <ESC>I
nnoremap <C-a> ^
inoremap <C-e> <ESC>A
nnoremap <C-e> $
inoremap <M-b> <Esc>Bi
inoremap <M-f> lWi

""" CUA shortcuts
" meta(alt)-left/right moves across words
map <M-Left>  B
map <M-Right> W
map <M-Up>    {
map <M-Down>  }

" inoremap <M-Right> <ESC>E
" noremap <M-Right> E
" inoremap <M-Left> <ESC>B
" noremap <M-Left> B
nnoremap <D-s> :w<CR>
nnoremap <D-z> :u<CR>
inoremap <D-z> <C-o>:u<C-r>

" Make search more sane
set ignorecase " case insensitive search
set smartcase  " If there are uppercase letters, become case-sensitive.
set incsearch  " live incremental searching
set showmatch  " live match highlighting
set hlsearch   " highlight matches
set gdefault   " use the `g` flag by default.
" make search use normal PERL regex
nnoremap / /\v
vnoremap / /\v
" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>:<backspace>


" Save on focus lost (breaks when unnamed)
" au FocusLost * :wa
