" ============================================================================
" Vundle
set nocompatible        " required
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
" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

"" Addons
Plugin 'ctrlpvim/ctrlp.vim'     " finder
"Plugin 'scrooloose/nerdtree'   " file tree explorer
"Plugin 'tpope/vim-vinegar'
"Plugin 'tpope/vim-surround'    " quick parenthesis actions
"map <c-n> <ESC>:NERDTree<CR>   " nerdtree
" ctrlp.vim
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|(__pycache__|build|dist|venv[^\/]*))$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

"" Syntax
Plugin 'nvie/vim-flake8'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
"Plugin 'achimnol/python-syntax'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'pangloss/vim-javascript'
Plugin 'webdesus/polymer-ide.vim'
autocmd BufWritePost *.py call Flake8()     " vim-flake8
"let g:vim_markdown_folding_disabled = 1    " vim-markdown
" YouCompleteMe
let g:ycm_python_binary_path = 'python'
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_use_ultisnips_completer = 1
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_python_checkers = []
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

call vundle#end()           " required
filetype plugin indent on   " required

" ============================================================================
" General
autocmd! bufwritepost .vimrc source %   " auto reload .vimrc when saved
autocmd BufLeave,FocusLost * wall
" autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
"let python_highlight_all=1
syntax on               " syntax highlighting
set encoding=utf-8      " use UTF-8
colorscheme pablo

" ============================================================================
" Options
set autoindent          " indent when moving to the next line while writing code
set smartindent         " tab is converted to 4 spaces (Python convention)
set tabstop=4
set shiftwidth=0        " use tabstop value 
set softtabstop=-1      " use shiftwidth value
" set textwidth=80
set colorcolumn=80      " draw vertical line
highlight ColorColumn ctermbg=black guibg=black
set expandtab
set smarttab
set fileformat=unix
set mouse=a             " control with mouse on 
set bs=2                " make backspace behave naturally 
set pastetoggle=<F2>    " fix indent problem when pasting from ext. source
set clipboard=unnamed   " use system clipboard
set history=700         " limit history/undo levels
set undolevels=700
set hlsearch            " make search case insensitive
set incsearch
set ignorecase
set smartcase
set number              " show line number
set nobackup            " disable stupid backup and swap files
set nowritebackup
set noswapfile
set laststatus=2        " display status line always


" ============================================================================
" Internal variables
let mapleader = ","     " easier leader key


" ============================================================================
" Key bindings
map <F2> <Esc>:w<CR>:!python3 %:p<CR>
noremap <c-j> <c-w>j    " <ctrl - move> to move around the windows
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
noremap <Leader>m gT                    " eaiser tab moving
noremap <Leader>. gt
noremap tt <Esc>:tabnew<CR>
vnoremap <c-c> "+y                  " quick copy to system clipboard
vnoremap <Leader>s :sort<CR>        " map sort function to a key
nnoremap <space> za


" ============================================================================
" IDE Setup
"" Python
" autocmd BufNewFile,BufRead *.py
"     \ set tabstop=4
"     \ set expandtab
"     \ set autoindent
"     \ set fileformat=unix
"" Web
" au BufNewFile,BufRead *.js,*.html,*.css
"     \ set tabstop=2
