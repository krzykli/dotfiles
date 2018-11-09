source O:\dev\krzysztof.klimczyk\dotfiles\flyingBark.vim

" Leaders
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ";"
nnoremap <Leader>b :update<CR>:!rez build -i -c<CR>
"nnoremap <Leader>rr :!rez release<CR>
nnoremap <Leader>w :update<CR>
inoremap <Leader>date <C-R>=strftime("%a%d%b%Y")<CR>
"nnoremap <Leader>b : !start cmd /k "build.bat" & pause & exit<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
nnoremap <Leader>u gUiwe
inoremap <Leader>u <Esc>gUiwea

"General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F2> "Paste toggle
color kokos
nmap <F5> :redraw!<CR>

set undodir=O:\dev\krzysztof.klimczyk\dotfiles\.vim\.undo\\
set backupdir=O:\dev\krzysztof.klimczyk\dotfiles\.vim\.backup\\
set directory=O:\dev\krzysztof.klimczyk\dotfiles\.vim\.swap\\

inoremap jk <Esc>

nnoremap <Esc> :q<CR>
vnoremap <C-c> "*y

set encoding=utf-8
set selection=inclusive
set timeoutlen=200
set ignorecase

inoremap <A-p> <Esc>"*p:redraw!<CR>
nnoremap <A-p> <Esc>"*p:redraw!<CR>
nnoremap fms o# FB_MODIFIED_START<Esc>
nnoremap fme o# FB_MODIFIED_END<Esc>

" python
au! FileType python setl nosmartindent 
set formatoptions+=cr
nnoremap pdb oimport pdb; pdb.set_trace()<Esc>

" indentation options
au! FileType python setl nosmartindent
set formatoptions+=cr

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
syntax on

set title
"set number "numbered lines
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

set t_Co=16
"set colorcolumn=80
"highlight ColorColumn guibg=#333 ctermbg=237

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'chaoren/vim-wordmotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'kana/vim-arpeggio'
Plugin 'lrvick/Conque-Shell.git'
Plugin 'majutsushi/tagbar'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/Tail-Bundle'
call vundle#end()

"Tagbar
nmap <F8> :TagbarToggle<CR>

"NERDTree
silent! nmap <F3> :NERDTreeToggle<CR>

let g:NERDTreeMapActivateNode="<F4>"

"Tagbar
let g:tagbar_ctags_bin='C:\Program Files (x86)\ctags58\ctags.exe'

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python'

"Supertab
let g:SuperTabNoCompleteAfter = ['^', ',', '\s']

"Surround
nmap "" csw"
nmap '' csw'

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"multi_cursor
let g:multi_cursor_exit_from_insert_mode = 0

"Airline
set encoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_ashes'
set guifont=Source\ Code\ Pro\ for\ Powerline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
let g:airline#extensions#hunks#enabled=0

"Arpeggio
"call arpeggio#map('i', '', 0, 'fu', 'function')
