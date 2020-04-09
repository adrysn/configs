let mapleader = ","     " easier leader key

" ============================================================================
" Vundle
set nocompatible        " this is 21st century
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
" let vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" add all your plugins here (note older versions of Vundle used Bundle instead of Plugins)

" ----------------------------------------------------------------------------
" Visual
Plugin 'itchyny/lightline.vim'      " pretty status bar
Plugin 'lifepillar/vim-solarized8'  " solarized theme
Plugin 'mhinz/vim-signify'          " shows a git diff in the gutter async
Plugin 'rakr/vim-one'               " one-light, one-dark color schemes
"" lightline
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \     'left': [['mode', 'paste'],
    \              ['gitbranch', 'readonly', 'filename', 'modified']],
    \ },
    \ 'component_function': {
    \     'gitbranch': 'FugitiveHead',
    \ },
\ }
"" vim-signify
set updatetime=200

" ----------------------------------------------------------------------------
" Addons
Plugin 'jeetsukumaran/vim-buffergator'  " buffer management
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf'           " fuzzy finder
Plugin 'junegunn/fzf.vim'
Plugin 'Konfekt/FastFold'       " speed up vim's folding
Plugin 'sjl/vitality.vim'       " make vim play nicely with iTerm 2 and tmux
"" buffergator
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = "B"
noremap <Leader>jj :BuffergatorMruCyclePrev<CR>
noremap <Leader>kk :BuffergatorMruCycleNext<CR>
noremap <Leader>bl :BuffergatorOpen<CR>
"" vim-ripgrep
let g:rg_highlight = 'true'
set wildignore+=*.swp,*.zip,*.exe
set wildignore+=*.jpg,*.png,*.gif
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
"" fzf
noremap <c-p>      :GFiles<CR>
noremap <Leader>bb :Buffers<CR>
noremap <Leader>bs :Files<CR>
noremap <Leader>bg :GFiles?<CR>

" ----------------------------------------------------------------------------
" Editing
Plugin 'alvan/vim-closetag'     " auto-close html tags
Plugin 'christoomey/vim-sort-motion'    " sort paragraph alphabetically, etc
Plugin 'christoomey/vim-system-copy'    " interact with system clipboard
Plugin 'editorconfig/editorconfig-vim'  " editorconfig support
Plugin 'farmergreg/vim-lastplace'       " reopen files at last position
Plugin 'jiangmiao/auto-pairs'   " auto-pair parenthesis, brackets
Plugin 'kana/vim-textobj-indent'        " indent block as a text obj
Plugin 'kana/vim-textobj-user'          " customize text obj
Plugin 'terryma/vim-multiple-cursors'   " multiple selection
Plugin 'tpope/vim-commentary'   " easier commenting
Plugin 'tpope/vim-endwise'      " cleverly add end or endfunction
Plugin 'tpope/vim-fugitive'     " Git wrapper
Plugin 'tpope/vim-surround'     " all about parens, brackets, quotes, ...
Plugin 'vim-scripts/ReplaceWithRegister'    " replace text with register

" ----------------------------------------------------------------------------
" Syntax
Plugin 'achimnol/python-syntax'
Plugin 'cespare/vim-toml'
Plugin 'hashivim/vim-terraform'
Plugin 'honza/vim-snippets'
Plugin 'jonsmithers/vim-html-template-literals' " highlight JS literal string
Plugin 'nvie/vim-flake8'
Plugin 'pangloss/vim-javascript'
Plugin 'w0rp/ale'
"" vim-html-template-literals
let g:html_indent_style1 = "inc"

" ----------------------------------------------------------------------------
" Language specifics
"" Python
Plugin 'tmhedberg/SimpylFold'           " better python folding
Plugin 'tweekmonster/django-plus.vim'
Plugin 'Vimjas/vim-python-pep8-indent'  " indentation comply with PEP8
"" JS
Plugin 'heavenshell/vim-jsdoc'          " generate JSDoc

call vundle#end()           " required
endif
filetype plugin indent on   " required


" ============================================================================
" UI
syntax enable           " syntax highlighting
let opacity=100
let blur=0
let python_highlight_all=1

if has("gui_running")
    set guifont=JetBrains_Mono:h15
else
    if $TERM =~ "-256color$" || $TERM == "linux"
        set t_Co=256
        if exists("+termguicolors")
            set termguicolors
            let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
        endif
    endif
endif
set background=dark     " I prefer dark background
try
    colorscheme solarized8
catch
endtry

highlight ColorColumn ctermbg=236 guibg=#453440
highlight SpecialKey ctermfg=238 guifg=#424242 ctermbg=NONE guibg=NONE
set colorcolumn=80      " draw vertical line
set cursorline          " show cursor line indicator
set guioptions=         " no scroll bars
set laststatus=2        " display status line always
set list                " show tabs, spaces, trailing blanks
set listchars=tab:\┃\ ,space:·,trail:~,extends:>,precedes:<,nbsp:+
set nowrap              " I don't like line wrapping
set number              " show line number
set relativenumber      " use relative line number
set wildmenu            " tab completion for menu commands


" ============================================================================
" General
autocmd! bufwritepost .vimrc source %   " auto reload .vimrc when saved
autocmd BufLeave,FocusLost * wall       " auto save when loose focus/buffer
set encoding=utf-8      " use UTF-8
set mouse=a             " use mouse
set nobackup            " disable stupid backup and swap files
set nowritebackup
set noswapfile
set path+=**            " search down into subfolders
set lazyredraw ttyfast

"" Indent
set tabstop=8
set shiftwidth=4
set softtabstop=4
set noexpandtab
set autoindent
set nosmartindent
set nocindent
if exists("+breakindent")
    set breakindent
endif

"" Editing
set bs=2                " make backspace behave naturally
set history=500         " limit history/undo levels
set undolevels=500
set pastetoggle=<F2>    " fix indent problem when pasting from ext. source

"" Search
set hlsearch            " highlight matches
set ignorecase          " make search case insensitive
set incsearch           " searching while typing
set smartcase


" ============================================================================
" Key bindings
map <F2> <Esc>:w<CR>:!python %:p<CR>
inoremap jk <Esc>
inoremap <C-a> <C-o>0   " move start of the line in insert mode
inoremap <C-e> <C-o>$   " move end of the line in insert mode
noremap <Leader>bt :enew<CR>
noremap <Leader>bq :bp <BAR> bd #<CR>
noremap <Leader>gs :bp <BAR> bd #<CR>
noremap <c-j> <c-w>j    " <ctrl - move> to move around the windows
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>
nnoremap <Leader><space> :nohlsearch<CR>
nnoremap <space> za
nnoremap <F5> :checktime<CR>
vnoremap <Leader>s :sort<CR>        " map sort function to a key

"" Git
nnoremap <Leader>gs :Gstatus<CR>    " git shortcuts
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
" nnoremap <Leader>gL :exe ':!cd ' . expand('%:p:h') . '; git la'<CR>
" nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git las'<CR>
" nnoremap <Leader>gh :Silent Glog<CR>
" nnoremap <Leader>gH :Silent Glog<CR>:set nofoldenable<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
" nnoremap <Leader>gp :Git push<CR>
" nnoremap <Leader>g- :Silent Git stash<CR>:e<CR>
" nnoremap <Leader>g+ :Silent Git stash pop<CR>:e<CR>

"" Snippets
nnoremap \html :-1read $HOME/.vim/.skeleton.html<CR>3jf>a
nnoremap \pywait import time; time.sleep(5000)<ESC>


" ============================================================================
" IDE-like Setup
"" Python
au FileType python	setl ts=8 sts=4 sw=4 et
au FileType html	setl ts=8 sts=2 sw=2 et
au FileType javascript	setl ts=8 sts=2 sw=2 et
au FileType json	setl ts=8 sts=2 sw=2 et
au FileType yaml	setl ts=8 sts=2 sw=2 et
au FileType toml	setl ts=8 sts=2 sw=2 et
au FileType markdown	setl ts=8 sts=2 sw=2 et
