" Don't behave like vi
set nocompatible

" Set charset to UTF-8
set encoding=utf-8
scriptencoding utf-8

" Detect filetypes
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" When you start a new line, use the same indentation as the previous line
" instead of starting from the very beginning
set autoindent

" Let me switch buffers without asking me to save all the time
set hidden

" Make the backspace key behave normally
set backspace=indent,eol,start

" Show commands as you type them
set showcmd

" Add a basic statubar
set laststatus=2

" Show line numbers
set number

" Show current position in file (perecntage scrolled) and current line and
" column
set ruler

" No bells
set noerrorbells
set t_vb=
set novisualbell

" Let vim look for settings in modelines
set modeline
set modelines=5

" Make Y yank to the end of the current line.
nnoremap Y y$

" Store lots of undo information
set undolevels=1000

" Remember more command and search history
set history=1000

" The I-forgot-to-sudo fix
cmap w!! w !sudo tee % >/dev/null

" Tabs are vim's default behavior, but if you want to use spaces instead of tabs:
set expandtab

" Use 2-space 'tabs' by default:
set tabstop=2
set softtabstop=2
set shiftwidth=2

" C-like indentation blah blah
set smartindent

" Do any text wrapping at 80 characters
set textwidth=80

" Use Ctrl-<direction> to navigate between splits
map <silent> <c-k> :wincmd k<CR>
map <silent> <c-j> :wincmd j<CR>
map <silent> <c-h> :wincmd h<CR>
map <silent> <c-l> :wincmd l<CR>

" Make cursor move as expected inside wrapped lines:
nnoremap j gj
nnoremap k gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Set leader to comma
let mapleader=","

" Keep messages displayed to a minimum length and avoid scrolling in message
" outputs (avoid the 'press a key' prompts)
set shortmess=at

" Show whitespace
set list
set listchars=tab:│\ ,trail:•,extends:»,precedes:«

" Better tab complete menu
set wildmenu

" wildmenu behavior default
set wildmode=list:full

" Ignore case when tab-completing filenames
set wildignorecase

" Ignore case for tab-completing commands, use smartcase for searches
set ignorecase
nnoremap / /\C

" Don't tab complete files with these extensions
set wildignore+=*.o,*.out,*.obj,*.rbc,*.rbo,*.class,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.jpg,*.png,*.gif,*.jpeg,*.bmp,*.tif,*.tiff,*.psd,*.hg,*.git,*.svn,*.exe,*.dll,*.pyc,*.DS_Store

" Fairy dust to make vim work faster over a laggy connection
set ttyfast

" Highlight matched searches so they're easier to see
set hlsearch

" Double spacebar to clear any highlighted searches
nnoremap <silent> <Space><Space> :nohlsearch<CR>

" Start matching searches as soon as you start typing
set incsearch

" Just don't even show me command shell mode - make Q redo the last macro
nnoremap Q @@
nnoremap q: <nop>

" I never use command lookup, so disable it
nnoremap K k
vnoremap K k

" Relative line numbers
set relativenumber

" When I write/quit sloppily, do what I mean, not what I say
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" Don't make swap files
set noswapfile
set nobackup
set nowritebackup

" Do make a persistent undo file
if v:version >= 703
        set undofile
        set undodir=~/.vim/tmp,~/.tmp,~/tmp,~/var/tmp,/tmp
endif

" Color in column 80
set colorcolumn=80
" Colorcolumn should be light black
highlight ColorColumn ctermbg=7
" ...and for gvim/mvim:
highlight ColorColumn guibg=Black

" Don't use matchparen.vim to highlight matching parents
let loaded_matchparen = 1

" When opening a file, start with the cursor wherever it was last time you
" edited it.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe 'normal! g`"zvzz' |
  \ endif

" Don't care about trailing whitespace in markdown files
autocmd FileType markdown setlocal nolist

" Autoreload vimrc when written
autocmd! bufwritepost vimrc source ~/.vimrc

" Cycle through open buffers using the left and right arrow keys
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>

" Maintain visual select after indentation
vnoremap < <gv
vnoremap > >gv

" Make sure there are at least two lines of padding above and below your
" cursor. This causes the window to scroll when you get within close two lines
" of the bottom of the screen.
set scrolloff=2
" Also keep two columns to the left and right when scrolling horizontally
set sidescrolloff=2

" Use F2 to toggle paste mode instead of having to type ':set paste' whenever
" you need to paste some crap in
set pastetoggle=<F2>

" This set of mappings makes the current search result always appear in the
" middle of the screen:
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Strip trailing whitespace on <Leader>w
:nnoremap <Leader>w :%s/\s\+$//g<CR>

" Gvim settings
set guioptions-=m
set guioptions-=r
set guioptions-=L
if has("gui_gtk2")
  set guifont=PT\ Mono\ \for\Powerline\ 12
endif

" Plugin time
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'tmhedberg/matchit'
Plug 'bling/vim-airline'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet-snippets'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mileszs/ack.vim'
Plug 'tyok/nerdtree-ack'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'w0ng/vim-hybrid'
Plug 'brookhong/DBGPavim'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/CycleColor'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/csapprox'
Plug 'rgarver/Kwbd.vim'
Plug 'lilydjwg/colorizer'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/vimspell'
Plug 'chriskempson/base16-vim'

Plug 'vim-scripts/c.vim', {'for': ['c','cpp']}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
Plug 'shawncplus/phpcomplete.vim', {'for': 'php'}
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'rodjek/vim-puppet', {'for': 'puppet'}
Plug 'cakebaker/scss-syntax.vim', {'for': ['sass', 'scss'] }
Plug 'chase/vim-ansible-yaml', {'for': 'yaml'}
Plug 'groenewege/vim-less', {'for': 'less'}
Plug 'wavded/vim-stylus', {'for':['styl']}
Plug 'juvenn/mustache.vim', {'for':['mustache']}
Plug 'joestelmach/lint.vim', {'for':['javascript']}
Plug 'pangloss/vim-javascript', {'for':['javascript']}
Plug 'kchmck/vim-coffee-script', {'for':['coffee']}
Plug 'mmalecki/vim-node.js', {'for':['javascript']}
Plug 'leshill/vim-json', {'for':['javascript','json']}
Plug 'othree/javascript-libraries-syntax.vim', {'for':['javascript','coffee','ls','typescript']}
Plug 'docunext/closetag.vim', {'for':['html','xml','erb']}
Plug 'webgefrickel/vim-typoscript', {'for':['typoscript','text']}
call plug#end()

" Use 256 colors and configure csapprox
set t_Co=256
let g:CSApprox_attr_map = { 'bold': 'bold', 'italic': '', 'sp': '' }
colorscheme bubblegum
set background=dark
let g:airline_theme="bubblegum"

" CycleColor on F11/F12
nnoremap <F12> :CycleColorNext<CR>
nnoremap <F11> :CycleColorPrev<CR>

" Settings for the dbgPavim xdebug client
" Use port 9000 for debugging:
let g:dbgPavimPort = 9000
" Don't auto-break at the first line:
let g:dbgPavimBreakAtEntry = 0
" Don't hate
set mouse=a

" Tagbar toggle mapping
map <Leader>t :TagbarToggle<CR>

" ag > ack > grep
if executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
  set grepformat=%f:%l:%c:%m
endif
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

" Gitgutter settings
let g:gitgutter_max_signs=100000
" Revert the current hunk:
nmap <Leader>rh <Plug>GitGutterRevertHunk
" git add the current hunk:
nmap <Leader>sh <Plug>GitGutterStageHunk
" skip to the next hunk:
nmap <Leader>hh <Plug>GitGutterNextHunk
" skip to the previous hunk:
nmap <Leader>lh <Plug>GitGutterPrevHunk

" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='¦'

" Show git status in nerdtree
let g:NERDTreeShowGitStatus = 1

" Completion config, via bling.vim by bling
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
let g:neocomplete#enable_at_startup=1
let g:neocomplete#data_directory='~/.vim/cache/neocomplete'

au FileType make set tabstop=4|set shiftwidth=4|set noexpandtab

" Stuff to use on the work mac
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    au FileType php set tabstop=4|set shiftwidth=4|set noexpandtab
    au FileType typoscript set tabstop=4|set shiftwidth=4|set noexpandtab
    au FileType html set tabstop=4|set shiftwidth=4|set noexpandtab
    au FileType xml set tabstop=4|set shiftwidth=4|set noexpandtab
    au BufNewFile,BufRead *.txt set filetype=typoscript
  endif
endif

au FileType make set tabstop=4|set shiftwidth=4|set noexpandtab
