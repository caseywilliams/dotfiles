" Don't behave like vi
set nocompatible

" Set charset to UTF-8
set encoding=utf-8
scriptencoding utf-8

" Detect filetypes
filetype plugin indent on

" Enable syntax highlighting
syntax enable
set omnifunc=syntaxcomplete#Complete

" When you start a new line, use the same indentation as the previous line
" instead of starting from the very beginning
set autoindent

" Let me switch buffers without asking me to save all the time
set hidden

" Make the backspace key behave normally
set backspace=indent,eol,start

" Show line numbers
set number

" Relative line numbers
set relativenumber

" Show percentage scrolled and current line/column
set ruler

" Show commands as you type them
set showcmd

" Add statusline
set laststatus=2

" Quiet any completion messages / bells
set shortmess+=c

" Set leader to comma
let mapleader=","

" No bells, ever
set noerrorbells
set t_vb=
set novisualbell

" Let vim look for settings in modelines
set modeline
set modelines=5

" Show whitespace
set list
set listchars=tab:│\ ,trail:•,extends:»,precedes:«

" When opening a file, start with the cursor wherever it was last time it was edited
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \  exe 'normal! g`"zvzz' |
      \ endif

" Scroll to show at least two lines on all edges
set scrolloff=2
set sidescrolloff=2

" Strip trailing whitespace on <Leader>w
nnoremap <Leader>w :%s/\s\+$//g<CR>

"""""""""""
" Papercuts
"""""""""""

:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q
cmap w!! w !sudo tee % >/dev/null
nnoremap Y y$
" Make cursor move as expected inside wrapped lines:
nnoremap j gj
nnoremap k gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" Disable command lookup
nnoremap K k
vnoremap K k
" Disable command shell mode
nnoremap q: <nop>
" Maintain visual select after indentation
vnoremap < <gv
vnoremap > >gv

""""""""""""""""
" History & Undo
""""""""""""""""

set undolevels=1000
set history=1000

" Don't make swap files
set noswapfile
set nobackup
set nowritebackup

" Do make a persistent undo file
if v:version >= 703
  set undofile
  set undodir=~/.vim/tmp,~/.tmp,~/tmp,~/var/tmp,/tmp
endif

""""""""""""
" Formatting
""""""""""""
set smartindent

" Tabs, spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"""""""""""""""""""
" Windows & Buffers
"""""""""""""""""""

" Use Ctrl-<direction> to navigate between splits
map <silent> <c-k> :wincmd k<CR>
map <silent> <c-j> :wincmd j<CR>
map <silent> <c-h> :wincmd h<CR>
map <silent> <c-l> :wincmd l<CR>

" Cycle through open buffers using the left and right arrow keys
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>

""""""""""""""""""
" Search, wildmenu
""""""""""""""""""

" Highlight matched searches so they're easier to see
set hlsearch
" Use double spacebar to clear any highlighted searches
nnoremap <silent> <Space><Space> :nohlsearch<CR>
" Start matching searches as soon as you start typing
set incsearch

" Make the current search result always appear in the middle of the screen:
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Ignore case for tab-completing commands, use smartcase for searches
set ignorecase
nnoremap / /\C

" Better tab complete menu
set wildmenu
set completeopt+=menuone,noselect
set completeopt-=preview

" wildmenu behavior default
set wildmode=list:full

" Ignore case for wildmenu completion
set wildignorecase

" Don't tab complete files with these extensions
set wildignore+=*.o,*.out,*.obj,*.rbc,*.rbo,*.class,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.jpg,*.png,*.gif,*.jpeg,*.bmp,*.tif,*.tiff,*.psd,*.hg,*.git,*.svn,*.exe,*.dll,*.pyc,*.DS_Store

" Use ag or ack instead of grep
if executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

""""""""""""""
" Per-filetype
""""""""""""""

" Don't care about trailing whitespace in markdown files
autocmd FileType markdown setlocal nolist

"""""""""""""""
" Gvim settings
"""""""""""""""

set guioptions-=m
set guioptions-=r
set guioptions-=L
set mouse=a

"""""""""""""
" Plugin init
"""""""""""""

call plug#begin('~/.vim/plugged')

" Colors
Plug 'godlygeek/csapprox'
Plug 'liuchengxu/space-vim-dark'
Plug 'nanotech/jellybeans.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'vim-scripts/CycleColor'
" Plug 'flazz/vim-colorschemes'

" Completion, snippets
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
"Plug 'Rip-Rip/clang_complete'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Language-specific
Plug 'fatih/vim-go'
Plug 'docunext/closetag.vim', {'for':['html','xml','erb']}
Plug 'plasticboy/vim-markdown'
" Plug 'tpope/vim-markdown'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'tpope/vim-fireplace'
Plug 'vhdirk/vim-cmake'
Plug 'danchoi/ri.vim'

" Libraries
Plug 'othree/javascript-libraries-syntax.vim', {'for':['javascript','coffee','typescript']}

" Formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/vimspell'
Plug 'scrooloose/nerdcommenter'

" Syntax highlighting
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'

" Files and buffers
Plug 'vim-scripts/a.vim'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'

" Tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Search
Plug 'mileszs/ack.vim'
Plug 'tyok/nerdtree-ack'

" Misc
Plug 'mattn/calendar-vim'
Plug 'rgarver/Kwbd.vim'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/Drawit'
Plug 'zenbro/mirror.vim'

call plug#end()

""""""""
" Colors
""""""""
set background=dark
set t_Co=256

colorscheme jellybeans
let g:jellybeans_use_term_italics=1
let g:jellybeans_use_term_background_color=1

" disable background color erase so non-text backgrounds aren't messed up
set t_ut=

""""""""""""
" Statusline
""""""""""""
let g:airline_theme='raven'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='¦'

"""""
" Git
"""""
let g:gitgutter_max_signs=100000
" Revert the current hunk:
nmap <Leader>rh <Plug>GitGutterRevertHunk
" git add the current hunk:
nmap <Leader>sh <Plug>GitGutterStageHunk
" skip to the next hunk:
nmap <Leader>jj <Plug>GitGutterNextHunk
" skip to the previous hunk:
nmap <Leader>kk <Plug>GitGutterPrevHunk

""""""""""
" NERDtree
""""""""""
let g:NERDTreeShowGitStatus = 1

""""""""""""
" Completion
""""""""""""
let g:SuperTabDefaultCompletionType = "context"

""""""""""
" Snippets
""""""""""
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets,~/.dotfiles/vim/snippets'

""""""
" Tags
""""""
map <Leader>t :TagbarToggle<CR>

""""""""
" Syntax
""""""""
let g:syntastic_cpp_cflags = '-Wall -std=c++14'

"""""""""""""""""""
" Windows & Buffers
"""""""""""""""""""
" Kwbd with Q
nnoremap <silent> Q <Plug>Kwbd<CR>

" Load local overrides
so ~/.vimrc.local
