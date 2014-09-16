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
" End Functions--------------------------------------------

" Start Basic Vim Settings---------------------------------
if !isdirectory(expand("$HOME/.vim/_cache"))
  call mkdir(expand("$HOME/.vim/_cache"))
endif
syntax on
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
"
" go back to previous position of cursor if any
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe 'normal! g`"zvzz' |
  \ endif

autocmd FileType js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()
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
    set gfn=Ubuntu\ Mono\ 11
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

" Start NeoBundle Setup------------------------------------
if has('vim_starting')
  set nocompatible
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('$HOME/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My plugins
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-scripts/CycleColor'
NeoBundle 'zeis/vim-kolor'

" Lazy bundles
NeoBundleLazy 'groenewege/vim-less', {'autoload':{'filetypes':['less']}}
NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload':{'filetypes':['scss','sass']}}
NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload':{'filetypes':['css','scss','sass']}}
NeoBundleLazy 'ap/vim-css-color', {'autoload':{'filetypes':['css','scss','sass','less','styl']}}
NeoBundleLazy 'othree/html5.vim', {'autoload':{'filetypes':['html']}}
NeoBundleLazy 'wavded/vim-stylus', {'autoload':{'filetypes':['styl']}}
NeoBundleLazy 'digitaltoad/vim-jade', {'autoload':{'filetypes':['jade']}}
NeoBundleLazy 'juvenn/mustache.vim', {'autoload':{'filetypes':['mustache']}}
NeoBundleLazy 'gregsexton/MatchTag', {'autoload':{'filetypes':['html','xml']}}
NeoBundleLazy 'pangloss/vim-javascript', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'maksimr/vim-jsbeautify', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'leafgarland/typescript-vim', {'autoload':{'filetypes':['typescript']}}
NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload':{'filetypes':['coffee']}}
NeoBundleLazy 'mmalecki/vim-node.js', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'leshill/vim-json', {'autoload':{'filetypes':['javascript','json']}}
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {'autoload':{'filetypes':['javascript','coffee','ls','typescript']}}

" Work stuff
NeoBundleLazy 'webgefrickel/vim-typoscript', {'autoload':{'filetypes':['typoscript','text']}}




call neobundle#end()
filetype plugin indent on

" Install prompt on startup
NeoBundleCheck
" End NeoBundle Setup--------------------------------------

" Plugin settings -----------------------------------------
nnoremap <silent> <leader>fjs :call JsBeautify()<cr>
let g:neocomplete#enable_at_startup=1
let g:neocomplete#data_directory=s:get_cache_dir('neocomplete')
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_temporary_dir=s:get_cache_dir('neocomplcache')
let g:neocomplcache_enable_fuzzy_completion=1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""

nnoremap <C-h> <C-W><C-h>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap j gj
vnoremap < <gv
vnoremap > >gv

colorscheme kolor
