" This is essentially a simplified version of bling's excellent dotvim distribution

" Start Functions------------------------------------------
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

function! s:get_cache_dir(suffix)
  if !isdirectory(expand("$HOME/.vim/_cache/" . a:suffix))
    call mkdir(expand("$HOME/.vim/_cache/" . a:suffix))
  endif
  return resolve(expand("$HOME/.vim/_cache/" . a:suffix))
endfunction

" From http://bit.ly/1msNvvh
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

" End Functions--------------------------------------------

" Start Basic Vim Settings---------------------------------
if !isdirectory(expand("$HOME/.vim/_cache"))
  call mkdir(expand("$HOME/.vim/_cache"))
endif
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set mouse=a
set mousehide
set ttyfast
set viewoptions=options,cursor,unix,slash
set encoding=utf8
set autoread
set fileformats+=mac
set nrformats-=octal
set showcmd
set tags=tags;/
set showfulltag
set modeline
set modelines=5
set list
set listchars=tab:│\ ,trail:•,extends:»,precedes:«
set noshelltemp
set backspace=indent,eol,start
set autoindent
set shiftround
set scrolloff=1
set sidescrolloff=5
set scrolljump=5
set display+=lastline
set wildmenu
set wildmode=list:full
set wildignore+=*.o,*.out,*.obj,*.rbc,*.rbo,*.class,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.jpg,*.png,*.gif,*.jpeg,*.bmp,*.tif,*.tiff,*.psd,*.hg,*.git,*.svn,*.exe,*.dll,*.pyc,*.DS_Store
set wildignorecase
set splitbelow
set splitright
set noerrorbells
set novisualbell
set t_vb=
set hlsearch
set incsearch
set ignorecase
set smartcase
set t_Co=256
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set lazyredraw
set number
set laststatus=2
set noshowmode
set foldmethod=manual
let &colorcolumn=80
set complete-=i
set ttimeout
set ttimeoutlen=100
set ruler
if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif
set history=1000
set tabpagemax=50
set viminfo^=!
set sessionoptions-=options
let mapleader=","
inoremap <C-U> <C-G>u<C-U>
nnoremap <C-h> <C-W><C-h>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap j gj
vnoremap < <gv
vnoremap > >gv
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprev<CR>

" I don't want to do this, but I have to
autocmd FileType php set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType typoscript set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType html set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType xml set tabstop=4|set shiftwidth=4|set noexpandtab
au BufNewFile,BufRead *.txt set filetype=typoscript

if has('autocmd')
  filetype plugin indent on
endif
if has ('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" go back to previous position of cursor if any
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe 'normal! g`"zvzz' |
  \ endif

autocmd FileType css,scss nnoremap <silent> <leader>S vi{:sort<CR>
autocmd FileType markdown setlocal nolist
autocmd FileType vim setlocal fdm=indent keywordprg=:help

" Mappings
nnoremap <silent> <Space><Space> :noh<CR>

" GUI configuration pulled directly from bling/dotvim
if has('gui_running')
  set guioptions+=t
  set guioptions-=T

  if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin"
      set gfn=Ubuntu_Mono:h14
      set transparency=2
    endif
  endif

  if has("win32") || has("win16")
    set gfn=InputMono_Light:h9:cANSI
  endif

  if has('gui_gtk')
    set gfn=Input\ Mono\ Condensed\ 12
  endif
else
  if $COLORTERM == 'gnome-terminal'
    set t_Co=256 "why you no tell me correct colors?!?!
  endif
  if $TERM_PROGRAM == 'iTerm.app'
    " different cursors for insert vs normal mode
    if exists('$TMUX')
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
  endif
endif

if executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

if exists('$TMUX')
  set clipboard=
else
  set clipboard=unnamed
endif

if exists('+undofile')
  set undofile
  set undodir=s:get_cache_dir('undo')
endif

set dir=s:get_cache_dir('swap')
set noswapfile


" End Basic Vim Settings ----------------------------------

" Start Plugin Setup------------------------------------
if has('vim_starting')
  set nocompatible
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'Shougo/neocomplcache.vim'
Plug 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
Plug 'Shougo/vimshell'
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-fugitive'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-scripts/CycleColor'
Plug 'zeis/vim-kolor'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'joonty/vdebug'
Plug 'vim-scripts/Tab-Name'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/nerdtree-ack'
Plug 'mtth/scratch.vim'
Plug 'vim-scripts/CSApprox'
Plug 'junegunn/seoul256.vim'

" Lazy bundles
Plug 'groenewege/vim-less', {'for':'less'}
Plug 'cakebaker/scss-syntax.vim', {'for': ['sass', 'scss'] }
Plug 'hail2u/vim-css3-syntax', {'for': ['css','scss','sass'] }
Plug 'ap/vim-css-color', {'for':['css','scss','sass','less','styl']}
Plug 'othree/html5.vim', {'for':['html']}
Plug 'wavded/vim-stylus', {'for':['styl']}
Plug 'digitaltoad/vim-jade', {'for':['jade']}
Plug 'juvenn/mustache.vim', {'for':['mustache']}
Plug 'gregsexton/MatchTag', {'for':['html','xml']}
Plug 'pangloss/vim-javascript', {'for':['javascript']}
Plug 'maksimr/vim-jsbeautify', {'for':['javascript']}
Plug 'kchmck/vim-coffee-script', {'for':['coffee']}
Plug 'mmalecki/vim-node.js', {'for':['javascript']}
Plug 'leshill/vim-json', {'for':['javascript','json']}
Plug 'othree/javascript-libraries-syntax.vim', {'for':['javascript','coffee','ls','typescript']}
Plug 'vim-php/phpctags'

" Work stuff
Plug 'webgefrickel/vim-typoscript', {'for':['typoscript','text']}

call plug#end()
" End Plugin Setup--------------------------------------

" Plugin settings -----------------------------------------
nnoremap <silent> <leader>fjs :call JsBeautify()<cr>
let g:neocomplete#enable_at_startup=1
let g:neocomplete#data_directory=s:get_cache_dir('neocomplete')
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_temporary_dir=s:get_cache_dir('neocomplcache')
let g:neocomplcache_enable_fuzzy_completion=1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'


nmap <silent> <leader>yw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

nmap <Leader>ss :Scratch<CR>

nmap <Leader>rh <Plug>GitGutterRevertHunk
nmap <Leader>sh <Plug>GitGutterStageHunk

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""

let g:vdebug_options= {
\    "port" : 9000,
\    "server" : 'localhost',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 1,
\    "ide_key" : 'PHPSTORM',
\    "path_maps" : {},
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}

colorscheme kolor
