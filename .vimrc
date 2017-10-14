" ============================================================================
" Vundle
set nocompatible        " this is 21st century
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
" let vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" add all your plugins here (note older versions of Vundle used Bundle instead of Plugins)

"" Visual
Plugin 'airblade/vim-gitgutter'     " shows a git diff in the gutter
Plugin 'vim-airline/vim-airline'    " pretty status bar
Plugin 'vim-airline/vim-airline-themes'
set updatetime=250      " vim-gutter
""" vim-airline
let g:airline_powerline_fonts = 1   " display buffer name
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'

"" Addons
Plugin 'ctrlpvim/ctrlp.vim'     " finder
Plugin 'jeetsukumaran/vim-buffergator'  " buffer management
Plugin 'sjl/vitality.vim'       " make vim play nicely with iTerm 2 and tmux
" ctrlp.vim
let g:ctrlp_user_command = [
    \ '.git/',
    \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard | grep -Ev "(jpg|png|gif)"'
    \ ]
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|(__pycache__|build|dist|venv[^\/]*))$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
set wildignore+=*.swp,*.zip,*.exe
set wildignore+=*.jpg,*.png,*.gif
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
" buffergator
let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_suppress_keymaps = 1

"" Syntax
Plugin 'nvie/vim-flake8'
Plugin 'Valloric/YouCompleteMe'
Plugin 'achimnol/python-syntax'
Plugin 'webdesus/polymer-ide.vim'
" YouCompleteMe
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_strings = 1

call vundle#end()           " required
filetype plugin indent on   " required


" ============================================================================
" General
autocmd! bufwritepost .vimrc source %   " auto reload .vimrc when saved
autocmd BufLeave,FocusLost * wall       " auto save when loose focus/buffer
syntax enable           " syntax highlighting
set encoding=utf-8      " use UTF-8
set mouse=a             " use mouse
let mapleader = ","     " easier leader key
set nobackup            " disable stupid backup and swap files
set nowritebackup
set noswapfile

"" Editing
set autoindent          " indent when moving to the next line while coding
set smartindent         " tab is converted to 4 spaces (Python convention)
set tabstop=4
set shiftwidth=0        " use tabstop value
set softtabstop=-1      " use shiftwidth value
set expandtab           " tabs into spaces
set smarttab
set bs=2                " make backspace behave naturally
set history=500         " limit history/undo levels
set undolevels=500
set hlsearch            " highlight matches
set ignorecase          " make search case insensitive
set smartcase
set clipboard=unnamed   " use system clipboard
set pastetoggle=<F2>    " fix indent problem when pasting from ext. source

"" UI
colorscheme pablo
highlight SpecialKey ctermfg=darkgrey guifg=#cccccc
highlight ColorColumn ctermbg=black guibg=#dddddd
set laststatus=2        " display status line always
set number              " show line number
set colorcolumn=80      " draw vertical line
set list                " show tabs, spaces, trailing blanks
set listchars=tab:\┃\ ,space:·,trail:~,extends:>,precedes:<,nbsp:+


" ============================================================================
" Key bindings
map <F2> <Esc>:w<CR>:!python %:p<CR>
noremap <Leader>bb :CtrlPBuffer<CR>    " CtrlP
noremap <Leader>bm :CtrlPMixed<CR>
noremap <Leader>bs :CtrlPMRU<CR>
noremap <Leader>jj :BuffergatorMruCyclePrev<CR>     " buffergator
noremap <Leader>kk :BuffergatorMruCycleNext<CR>
noremap <Leader>bl :BuffergatorOpen<CR>
noremap <Leader>bt :enew<CR>
noremap <Leader>bq :bp <BAR> bd #<CR>
noremap <c-j> <c-w>j    " <ctrl - move> to move around the windows
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
nnoremap <Leader><space> :nohlsearch<CR>
nnoremap <space> za
nnoremap <F5> :checktime<CR>
vnoremap <c-c> "+y                  " quick copy to system clipboard
vnoremap <Leader>s :sort<CR>        " map sort function to a key


" ============================================================================
" IDE-like Setup
"" Python
autocmd BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
let python_highlight_all=1

"" Web
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2
