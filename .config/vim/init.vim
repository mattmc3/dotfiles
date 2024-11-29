"
" Notes:
"
" References
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
" https://github.com/fabi1cazenave/cua-mode.vim/blob/master/plugin/cua-mode.vim
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim

" better defaults were introduced in vim 7, but they only load for a missing vimrc.
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Kickstart:
source ~/.config/vim/kickstart.vim

" General Settings
set colorcolumn=88              " add ruler
set nobackup                    " We have vcs, we don't need backups this way
set nowritebackup               " We have vcs, we don't need backups this way
set noswapfile                  " No need for this on a modern system
set autowrite                   " autosaving files is a nice feature
set lazyredraw                  " don't redraw the screen on macros, or other non-typed operations
set shortmess+=I                " no vim welcome screen
set virtualedit+=block          " allow the cursor to go anywhere in visual block mode
set wildmode=list:full
set foldmethod=marker

" https://vim.fandom.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" Cursor
" Use a line cursor within insert mode and a block cursor everywhere else.
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Editor

set list                            " needed for listchars
set listchars=tab:»\ ,trail:·       " Display tabs and trailing spaces visually
set title                           " Sets the terminal to show the buffer title
set scrolloff=4                     " when scrolling around, keep a buffer of a few lines above/below


" Whitespace

set expandtab                       " use spaces instead of tabs.
set tabstop=4                       " number of spaces that a tab in a file counts for
set shiftwidth=4                    " affects how autoindentation works
set softtabstop=4                   " when tab is pressed, only move to the next tab stop
set shiftround                      " tab / shifting moves to closest tabstop.
set smartindent                     " intelligently  dedent / indent new lines based on rules.


"
" Key bindings
"

" Assign keys
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
" noremap <M-Le t> B
nnoremap <D-s> :w<CR>
nnoremap <D-z> :u<CR>
inoremap <D-z> <C-o>:u<C-r>

" Make search more sane
set showmatch  " live match highlighting
set gdefault   " use the `g` flag by default.
" make search use normal PERL regex
" nnoremap / /\v
" vnoremap / /\v
" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>:<backspace>


" Save on focus lost (breaks when unnamed)
" au FocusLost * :wa

" Theme
" to get the font name, set it in MacVim and then run `:set guifont?` to see
" the value.
if has('gui_running')
    set guifont=HackNF-Regular:h15
endif

" FZF
set rtp+=/usr/local/opt/fzf

