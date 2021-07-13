" ~/.config/nvim/init.vim
" author: mattmc3
" https://github.com/mattmc3/dotfiles

" references:
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful

"
" General settings
"
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
set cursorline                  " show where the cursor is
set backspace=indent,eol,start  " define what backspace does

"
" Plugins
"
" To install:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if has("win32")
    let plug_path = "~\\vimfiles\\plugged"
else
    let plug_path = "~/.local/share/nvim/site/plugged"
endif

call plug#begin(plug_path)
Plug 'tpope/vim-sensible'
Plug 'nanotech/jellybeans.vim', { 'as': 'jellybeans' }
Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'cweagans/vim-taskpaper'
Plug 'liuchengxu/vim-which-key'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

" configure nvim-tree
let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
nnoremap <C-n> :NvimTreeToggle<CR>

" Configure which-key plugin
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Configure netrw
" https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" theme
set background=dark                 " tell nvim the color scheme will be a dark one
colorscheme jellybeans              " set the color scheme (builtin: evening, elflord)

" editor
" to get the postscript name, use ⌘-i in fontbook
" to see which font is used, do ':set guifont?'
try
    if has('gui_running')
        set guifont=MesloLGSForPowerline-Regular:h13
    endif
catch /^Vim\%((\a\+)\)\=:E518/
    if has('gui_vimr')
        " VimR has disabled support for guifont
    else
        throw v:exception
    endif
endtry
set list                            " needed for listchars
set listchars=tab:»\ ,trail:·       " Display tabs and trailing spaces visually
set number                          " Enable line numbers
"set relativenumber                  " Show relative line numbers
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

" Add leader shortcuts
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Make U be redo.
nnoremap U <C-r>

""" Colemak
" set langmap=je,JE,li,LI,nj,NJ,ek,EK,il,IL,kn,KN
" Arrow with neiu, and then make H-U, J->E, K->N, and L->I.
" set langmap=nh,NH,ej,EJ,il,IL,uk,UK,je,JE,li,LI,hu,HU,nh,kn,KN
" Make tn get us out of insert mode because that's handy.
" inoremap tn <ESC>
imap jj <ESC>

" Emacs shortcuts
inoremap <C-a> <ESC>I
nnoremap <C-a> ^
inoremap <C-e> <ESC>A
nnoremap <C-e> $
inoremap <M-b> <Esc>Bi
inoremap <M-f> lWi

" CUA and Emacs shortcuts
inoremap <M-Right> <C-o>E
noremap <M-Right> E
inoremap <M-Left> <C-o>B
noremap <M-Left> B
nnoremap <C-s> :w<CR>

""" Search
" Make search more sane
set ignorecase " case insensitive search
set smartcase  " if there are uppercase letters, become case-sensitive.
set incsearch  " live incremental searching
set showmatch  " live match highlighting
set hlsearch   " highlight matches
set gdefault   " use the `g` flag by default.

" make escape clear the search
nnoremap <esc> :let @/ = ""<return><esc>
nnoremap <esc>^[ <esc>^[

" make search use normal PERL regex
" nnoremap / /\v
" vnoremap / /\v

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>:<backspace>

""" Clipboard
" 'dd' cuts a line and replaces the clipboard. We can remap d to use the
" blackhole register instead and then it won't nuke the clipboard when you
" delete a line. You can still easily cut a line the the clipboard with 'Vx'
" https://stackoverflow.com/questions/11993851/how-to-delete-not-cut-in-vim/11993928
set clipboard+=unnamed
nnoremap d "_d
vnoremap d "_d

""" Autosave
" https://vi.stackexchange.com/questions/74/is-it-possible-to-make-vim-auto-save-files
" save when idle for a bit
autocmd CursorHold * update

