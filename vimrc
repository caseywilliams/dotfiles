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
set belloff=all

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

" JSON with comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" Scroll to show at least two lines on all edges
set scrolloff=2
set sidescrolloff=2

" Strip trailing whitespace on <Leader>w
nnoremap <Leader>w :%s/\s\+$//g<CR>

" Don't care about trailing whitespace in markdown files
autocmd FileType markdown setlocal nolist

" Convenience mappings
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

"""""
" GUI
"""""

set guioptions-=m
set guioptions-=r
set guioptions-=L
set mouse=a

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
nmap <Leader>rh <Plug>(GitGutterRevertHunk)
" git add the current hunk:
nmap <Leader>sh <Plug>(GitGutterStageHunk)
" skip to the next hunk:
nmap <Leader>jj <Plug>(GitGutterNextHunk)
" skip to the previous hunk:
nmap <Leader>kk <Plug>(GitGutterPrevHunk)

"""""""""""""""""""
" Windows & Buffers
"""""""""""""""""""
" Delete buffer but keep window on ctrl-q
map <silent> <c-q> :Kwbd<CR>

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
Plug 'airblade/vim-gitgutter'
Plug 'docunext/closetag.vim', {'for':['html','xml','erb']}
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/csapprox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kien/ctrlp.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/nerdfont.vim'
Plug 'othree/javascript-libraries-syntax.vim', {'for':['javascript','coffee','typescript']}
Plug 'puremourning/vimspector'
Plug 'Raimondi/delimitMate'
Plug 'reedes/vim-colors-pencil'
Plug 'rgarver/Kwbd.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/CycleColor'
Plug 'vim-scripts/Drawit'
Plug 'vim-scripts/vimspell'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

let g:coc_global_extensions = [
      \'coc-css',
      \'coc-emmet',
      \'coc-eslint',
      \'coc-explorer',
      \'coc-fzf-preview',
      \'coc-fzf-preview',
      \'coc-git',
      \'coc-go',
      \'coc-html-css-support',
      \'coc-json',
      \'coc-lists',
      \'coc-sh',
      \'coc-snippets',
      \'coc-sql',
      \'coc-terminal',
      \'coc-tsserver',
      \'coc-tsserver',
      \'coc-yaml',
      \]

""""""""
" Colors
""""""""
set background=dark
set t_Co=256

colorscheme space-vim-dark

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

""""""""""""""""
" Plugin configs
""""""""""""""""
let g:gitgutter_max_signs=100000
" Revert the current hunk:
nmap <Leader>hr <Plug>GitGutterRevertHunk
" git add the current hunk:
nmap <Leader>hs <Plug>GitGutterStageHunk
" skip to the next hunk:
nmap <Leader>hn <Plug>GitGutterNextHunk
" skip to the previous hunk:
nmap <Leader>hp <Plug>GitGutterPrevHunk

let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git'
let g:ctrlp_cmd='CtrlPMixed'
let g:vimspector_enable_mappings = 'HUMAN'

" CoC Settings
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<tab>'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>T <Plug>(coc-terminal-toggle)
nnoremap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
