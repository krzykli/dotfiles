" Leaders
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ";"
nnoremap <Leader>b :update<CR>:!./build.sh<CR>
"nnoremap <Leader>r :!./build/build.out<CR>
nnoremap <Leader>r :update<CR>:!./build.sh;./build/build.out<CR>

nnoremap <Leader>w :update<CR>
nnoremap <Leader>rt :!ctags -R --exclude=.git<CR>
inoremap <Leader>date <C-R>=strftime("%a%d%b%Y")<CR>
"nnoremap <Leader>b : !start cmd /k "build.bat" & pause & exit<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>u gUiwe
inoremap <Leader>u <Esc>gUiwea
inoremap <Leader>u <Esc>gUiwea
nnoremap <Leader>O vi""*y:tabnew<CR>:e <C-R>*<CR>
nnoremap <Leader>o vi""*y:e! <C-R>*<CR>

nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
nmap lg :!lazygit<CR>

"General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set pastetoggle=<F2> "Paste toggle
color molokai
nmap <F5> :redraw!<CR>

set undodir=~/.vim/.undo
set backupdir=~/.backup
set directory=~/.swap

inoremap jk <Esc>

nnoremap <Esc> :q<CR>
nnoremap <Esc><Esc> :q!<CR>
vnoremap <C-c> "*y

set encoding=utf-8
set selection=inclusive
set timeoutlen=200
set ignorecase

inoremap <A-p> <Esc>"*p:redraw!<CR>
nnoremap <A-p> <Esc>"*p:redraw!<CR>
nnoremap fms o# FB_MODIFIED_START<Esc>
nnoremap fme o# FB_MODIFIED_END<Esc>

nnoremap <leader>fa :CtrlP<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <C-u> :!git pull<cr>

" python
au! FileType python setl nosmartindent 
set formatoptions+=cr
nnoremap pdb oimport pdb; pdb.set_trace()<Esc>

" search
set hlsearch
set incsearch

" wrap word in brackets
inoremap w0 (<Esc>lEa)

" move to the last char in line in insert mode
inoremap a; <Esc>A

"autocmd FileType python setlocal completeopt-=preview
" brackets wrap a word
inoremap w0 (<Esc>lEi)

" go to the end of the line
inoremap a; <Esc>A

" moving with lh keys in normal mode
nnoremap <S-l> e
nnoremap <S-h> b

" moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nnoremap <A-h> d^

"set shell=/bin/bash
syn keyword cType u32

set title
"set number "numbered lines
set softtabstop=4 "tab length
set shiftwidth=4 "indent length
set expandtab "convert tabs to spaces
set scrolloff=10
set cursorline
hi CursorLine   cterm=NONE ctermbg=1 ctermfg=6

set guioptions-=L  " remove scroll bar left
set guioptions-=R  " remove scroll on split
set guioptions-=T  " remove toolbar
set guioptions-=m  " remove menu bar
set guioptions-=r  " remove scroll bar right
set laststatus=2   " always show status line
set noswapfile
set wildmenu
set background=dark
set nofoldenable    " disable folding
filetype off
filetype plugin indent on

set t_Co=16

"Invisible characters, on be default
set list listchars=trail:·,tab:»·
set list

"Split navigation
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

set splitbelow
set splitright

set showtabline=2
set laststatus=2

"Tab navigation
nnoremap tn :tabnew<CR>
nnoremap tj :tabprev<CR>
nnoremap tk :tabnext<CR>

"C++
" Code Block
inoremap {{ {<CR>}<Esc>ko 
" Go inside parenthesis after creating them 
inoremap (( ()<Esc>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'VundleVim/Vundle.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'mhinz/vim-startify'
Plug 'kevinhwang91/rnvimr', {'branch': 'main'}
Plug 'rbgrouleff/bclose.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'mhinz/vim-signify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'kana/vim-arpeggio'
Plug 'majutsushi/tagbar'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tikhomirov/vim-glsl'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'rbong/vim-crystalline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yegappan/grep'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

"Tagbar
nmap <F8> :TagbarToggle<CR>

"NERDTree
silent! nmap <F3> :Vexplore<CR>

let g:NERDTreeMapActivateNode="<F4>"

"Tagbar
if has('win32')
    let g:tagbar_ctags_bin='C:\Program Files (x86)\ctags58\ctags.exe'
endif

"Supertab
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']

"multi_cursor
let g:multi_cursor_exit_from_insert_mode = 0

"Surround
nmap "" csw"
nmap '' csw'

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"grep
nmap <Leader>grep :Gitgrep 
nmap <Leader>rg :Rg 

"Ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <Leader>= :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

runtime! ~/dotfiles/syntax.vim
