" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir

" ===
" === General Editor Settings
" ===
set exrc
set secure

set number " show line numbers on left sidebar
set relativenumber " show line number on the current line and relative numbers on all other lines

set mouse=a " enable mouser for scrolling and resizing
set cursorline " highlight the line currently under curor
set scrolloff=4 " the number of screen lines to keep above and below the cursor
set sidescrolloff=4 " the number of screen columns to keep to the left and right of the cursor
set colorcolumn=81
set noshowmode " show vim current mode

" === Mode Settings ===

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
" === indent settings ===

set noexpandtab " don't convert tabs to spaces
set shiftwidth=4 " when shifting,indent using four spaces
set tabstop=4 " indent using four spaces
set softtabstop=4 "
set autoindent " new lines inherit the indentation of previous lines
set list " show special symbols
set listchars=tab:\|\ ,trail:▫ " replace special symbols
set smarttab " insert "tabstop" number of spaces when the "tab" key is pressed

set title " set the window's title, reflecting the file currently being edited
set confirm " displays the confirmation dialog asking if you want to save the file
set hidden " hide files instead of closing them when switch current file in buffer
set ruler " always show cursor position
" set laststatus=2 " always display the status bar

set showmatch " show match symbol
set incsearch " incremental search that shows partial matches
set hlsearch " search highlignting

set showcmd " show cmmand line
set wildmenu " display command line's tab complete options as a menu
set wildmode=list:full

set ttimeoutlen=0 " set vim will wait for longer after each keystroke of the mapping before aborting it and carrying out the behaviour
set notimeout " disable timeout on the vim leader key

set viewoptions=cursor,folds,slash,unix " remembering some status
set wrap " enable line wrap

set linebreak " line wrap will not break word
set breakindent " line warp will has some indent

set ignorecase " ignore case when searching
set smartcase " automatically switch search to case-sensitive when search query contains an uppercase letter

set ttyfast " should make scrolling faster
set lazyredraw
set visualbell

set foldenable " enable fold text
set foldmethod=indent " fold text by indent
set foldlevel=99
set formatoptions=qmM

set shortmess+=c

set splitright " put vsplite window on the right of current window
set splitbelow " put hsplite window on the below of current window
" set inccommand=split " preview command effect
set completeopt=longest,noinsert,menuone,noselect,preview

set updatetime=100 " auto write time
set virtualedit=block
set background=dark
if has('syntax')
	syntax on
endif

if has('win32')
    set fileformats=dos,unix,mac
else
    set fileformats=unix,mac,dos
endif

"===
"=== Special Settings
"===

autocmd FileType c,cpp,html,htmldjango,lua,javascript,nsis set shiftwidth=2 | set tabstop=2 | set expandtab | set cindent | set cinoptions=t0,g1,h1,N-s,E-s,j1,:0
autocmd FileType make set noexpandtab | set tabstop=8 | set shiftwidth=2
autocmd FileType c,cpp,python,vim set textwidth=80

"===
"=== Basic Mapping
"===

let mapleader="\<space>" " defualt key is ,
noremap ; :

" Press ` to change case (instead of ~)
noremap ` ~

" select current line
noremap <silent> \v v$h

" Folding
noremap <silent> <LEADER>o za

" Save & Quit
noremap S :w<CR>
noremap Q :q<CR>
noremap <C-q> :q<CR>
noremap <C-s> :w<CR>

" Insert Key
noremap h i
noremap H I

" Indentation
nnoremap < <<
nnoremap > >>
" Search
noremap <LEADER><CR> :nohlsearch<CR>
" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Delete find pair
nnoremap dy d%

" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g

" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
noremap <silent> i k
noremap <silent> n h
noremap <silent> e j
noremap <silent> o l
noremap <silent> gi gk
noremap <silent> ge gj

" U/E keys for 5 times u/e (faster navigation)
noremap <silent> I 5k
noremap <silent> E 5j

" set h (same as n, cursor left) to 'end of word'
noremap k e

" Faster in-line navigation
noremap W 5w
noremap B 5b

" Ctrl + U or E will move up/down the view port without moving the cursor
noremap <C-I> 5<C-y>
noremap <C-E> 5<C-e>

" source $HOME/.config/nvim/cursor.vim

" ===
" === Window management
" ===
" Use Ctrl new arrow keys for moving the cursor around windows
noremap <C-w> <C-w>w
noremap <C-i> <C-w>k
noremap <C-e> <C-w>j
noremap <C-n> <C-w>h
noremap <C-o> <C-w>l
noremap <C-l> <C-w>o

" edit
noremap <LEADER>cw ciw
noremap <LEADER>yw yiw
noremap <LEADER>pw viwp

" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap se :set splitbelow<CR>:split<CR>
noremap sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap so :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <C-up> :res +5<CR>
noremap <C-down> :res -5<CR>
noremap <C-left> :vertical resize-5<CR>
noremap <C-right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + x to close the window below the current window
noremap <LEADER>x <C-w>j:q<CR>

" move line
noremap <LEADER>i <Esc>:m .-2<CR>
noremap <LEADER>e <Esc>:m .+1<CR>
vnoremap <LEADER>i :m '<-2<CR>gv=gv
vnoremap <LEADER>e :m '>+1<CR>gv=gv

" back/forward
noremap <LEADER>n <C-o>
noremap <LEADER>o <C-i>

" ===
" === Tab management
" ===
" Create a new tab with tu
noremap tu :tabe<CR>
noremap tU :tab split<CR>

" Move around tabs with tn and ti
noremap tn :-tabnext<CR>
noremap to :+tabnext<CR>

" Move the tabs with tmn and tmi
noremap tmn :-tabmove<CR>
noremap tmo :+tabmove<CR>

" ===
" === Searching
" ===
noremap - N
noremap = n

" Open a new instance of st with the cwd
nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" ===
" === Insert Mode Cursor Movement
" ===
inoremap <C-a> <ESC>A

" ===
" === Command Mode Cursor Movement
" ===
cnoremap <C-,> <Home>
cnoremap <C-.> <End>
cnoremap <C-i> <Up>
cnoremap <C-e> <Down>
cnoremap <C-n> <Left>
cnoremap <C-o> <Right>
cnoremap <C-s> <S-Left>
cnoremap <C-t> <S-Right>

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" find and replace
noremap \s :%s//g<left><left>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Folding
noremap <silent> <LEADER>o za

" go to the start of the line
noremap <silent> N ^

" go to the end of the line
noremap <silent> O $

" set wrap
noremap <LEADER>sw :set wrap<CR>

