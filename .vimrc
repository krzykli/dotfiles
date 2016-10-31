
"General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
inoremap jk <Esc>
set timeoutlen=200
let mapleader = ";"
set ignorecase
color kokos

" search
set hlsearch
set incsearch

" build shortcut
nnoremap <Leader>b : !start cmd /k "build.bat" & pause & exit<CR>

" replace all occurences
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" jedi-vim
let g:jedi#use_tabs_not_buffers = 1
autocmd FileType python setlocal completeopt-=preview

" run selected python code with F5
vnoremap <F5> :'<'>!python<CR>:redraw!<CR>

" convert a word to uppercase
nnoremap <Leader>u gUiwe
inoremap <Leader>u <Esc>gUiwea

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
syntax on

set title
set number "numbered lines
set softtabstop=4 "tab length
set shiftwidth=4 "indent length
set expandtab "convert tabs to spaces
set scrolloff=10
set cursorline
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set guioptions-=r  " remove scroll bar right
set guioptions-=R  " remove scroll on split
set guioptions-=L  " remove scroll bar left
set laststatus=2   " always show status line
set noswapfile
set wildmenu
set background=dark
set nofoldenable    " disable folding
filetype off
filetype plugin indent on

"set t_Co=256
set colorcolumn=80
"highlight ColorColumn guibg=#333 ctermbg=237

nnoremap <Leader>w :update<CR>
set pastetoggle=<F2> "Paste toggle

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

"Tab navigation
nnoremap tn :tabnew<CR>
nnoremap tj :tabprev<CR>
nnoremap tk :tabnext<CR>

"C++
" Code Block
inoremap {{ {<CR>}<Esc>ko 
" Go inside parenthesis after creating them 
inoremap (( ()<Esc>i

"Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'davidhalter/jedi-vim.git'
Plugin 'chaoren/vim-wordmotion'
"Plugin 'bling/vim-airline'
"Plugin 'edkolev/promptline.vim'
"Plugin 'edkolev/tmuxline.vim'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'majutsushi/tagbar'
Plugin 'lrvick/Conque-Shell.git'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
"Plugin 'christoomey/vim-tmux-navigator'
Plugin 'terryma/vim-multiple-cursors'
"Plugin 'ervandew/supertab'
"Plugin 'vim-scripts/fish.vim'
call vundle#end()

"Airline
let g:airline_powerline_fonts=1
let g:airline_theme="powerlineish"

"Tagbar
nmap <F8> :TagbarToggle<CR>

"NERDTree
silent! nmap <F3> :NERDTreeToggle<CR>
"silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F4>"

"Tagbar
if has("unix")
    source ~/.vim/workflow.vim
else
    let g:tagbar_ctags_bin='/usr/local/bin/ctags'  "Proper Ctags locations
    set guifont=Sauce\ Code\ Powerline\:h13
endif

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python'


"Tmux
if exists('$TMUX')
  echom "TMUX"
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <c-h> :call tmuxorsplitswitch('h', 'l')<cr>
  nnoremap <silent> <c-j> :call tmuxorsplitswitch('j', 'd')<cr>
  nnoremap <silent> <c-k> :call tmuxorsplitswitch('k', 'u')<cr>
  nnoremap <silent> <c-l> :call tmuxorsplitswitch('l', 'r')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

"Supertab
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']

"Surround
nmap "" csw"
nmap '' csw'

