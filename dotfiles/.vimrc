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

"" Visual
Plugin 'altercation/vim-colors-solarized'   " solarized theme
Plugin 'rakr/vim-one'               " one-light, one-dark color schemes
Plugin 'vim-airline/vim-airline'    " pretty status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'     " shows a git diff in the gutter
set updatetime=250      " vim-gutter
""" vim-airline
let g:airline_powerline_fonts = 1   " display buffer name
let g:airline_theme='one'
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'

"" Addons
Plugin 'vimplugin/project.vim'  " ide-like navigator
Plugin 'jremmen/vim-ripgrep'
Plugin 'ctrlpvim/ctrlp.vim'     " finder
" Plugin 'junegunn/fzf'           " fuzzy finder (rendering issues in MacVim)
" Plugin 'junegunn/fzf.vim'
Plugin 'jeetsukumaran/vim-buffergator'  " buffer management
Plugin 'sjl/vitality.vim'       " make vim play nicely with iTerm 2 and tmux
Plugin 'Konfekt/FastFold'       " speed up vim's folding
" project.vim
let g:proj_window_width=30
let g:proj_window_increment=70
let g:proj_flags="bgimst"
nmap <silent> <C-n> <Plug>ToggleProject
" vim-ripgrep
let g:rg_highlight = 'true'
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
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = "B"

"" Editing
Plugin 'jiangmiao/auto-pairs'   " auto-pair parenthesis, brackets
Plugin 'alvan/vim-closetag'     " auto-close html tags
Plugin 'tpope/vim-endwise'      " cleverly add end or endfunction
Plugin 'tpope/vim-surround'     " all about parens, brackets, quotes, ...
Plugin 'tpope/vim-commentary'   " easier commenting
Plugin 'tpope/vim-fugitive'     " Git wrapper
Plugin 'vim-scripts/ReplaceWithRegister'    " replace text with register
Plugin 'christoomey/vim-sort-motion'    " sort paragraph alphabetically, etc
Plugin 'christoomey/vim-system-copy'    " interact with system clipboard
Plugin 'kana/vim-textobj-user'          " customize text obj
Plugin 'kana/vim-textobj-indent'        " indent block as a text obj
Plugin 'editorconfig/editorconfig-vim'  " editorconfig support

"" Syntax
Plugin 'achimnol/python-syntax'
Plugin 'honza/vim-snippets'
Plugin 'nvie/vim-flake8'
Plugin 'jonsmithers/vim-html-template-literals' " highlight JS literal string
Plugin 'pangloss/vim-javascript'
" Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'
Plugin 'cespare/vim-toml'
" Plugin 'webdesus/polymer-ide.vim'
" YouCompleteMe
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-l>"
let g:UltiSnipsListSnippets = "<c-k>"
" vim-html-template-literals
let g:html_indent_style1 = "inc"

"" Language specifics
Plugin 'Vimjas/vim-python-pep8-indent'  " indentation comply with PEP8
Plugin 'tmhedberg/SimpylFold'           " better python folding
Plugin 'tweekmonster/django-plus.vim'
Plugin 'JarrodCTaylor/vim-python-test-runner'   " run tests swiftly

call vundle#end()           " required
endif
filetype plugin indent on   " required


" ============================================================================
"" UI
syntax enable           " syntax highlighting
let opacity=100
let blur=0
let python_highlight_all=1

if has("gui_running")
    set guifont=Hack:h14
    set background=dark
    if has("gui_macvim")
        " let g:solarized_visibility="low"
        " colorscheme solarized
        colorscheme one
    else
        colorscheme one
    endif
else
    if has("gui_macvim")
        " colorscheme solarized
        colorscheme one
    else
        colorscheme one
    endif
endif

highlight Normal ctermbg=234
highlight ColorColumn ctermbg=236 guibg=#453440
highlight Folded guifg=#8f96a3 guibg=#454a54 ctermbg=236 ctermfg=245
highlight SpecialKey ctermfg=238 guifg=#424242
highlight Pmenu ctermfg=15 ctermbg=0  " YouCompleteMe popup color
set guioptions=         " no scroll bars
set laststatus=2        " display status line always
set number              " show line number
set relativenumber      " use relative line number
set colorcolumn=80      " draw vertical line
set nowrap              " I don't like line wrapping
set list                " show tabs, spaces, trailing blanks
set listchars=tab:\┃\ ,space:·,trail:~,extends:>,precedes:<,nbsp:+
set wildmenu            " tab completion for menu commands


" ============================================================================
" General
autocmd! bufwritepost .vimrc source %   " auto reload .vimrc when saved
autocmd BufLeave,FocusLost * wall       " auto save when loose focus/buffer
set encoding=utf-8      " use UTF-8
set mouse=a             " use mouse
let mapleader = ","     " easier leader key
set nobackup            " disable stupid backup and swap files
set nowritebackup
set noswapfile
set path+=**            " search down into subfolders
set lazyredraw ttyfast

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
set incsearch           " searching while typing
set smartcase
set pastetoggle=<F2>    " fix indent problem when pasting from ext. source

" File browsing (netRW)
let g:netrw_altv = 1
let g:netrw_banner=0            " disable banner
let g:netrw_browse_split=4
let g:netrw_liststyle=3         " tree view
let g:netrw_winsize = 30        " width


" ============================================================================
" Key bindings
map <F2> <Esc>:w<CR>:!python %:p<CR>
inoremap jk <Esc>
noremap <Leader>bb :CtrlPBuffer<CR>    " CtrlP
noremap <Leader>bm :CtrlPMixed<CR>
noremap <Leader>bs :CtrlPMRU<CR>
noremap <Leader>b. :CtrlPTag<CR>
noremap <Leader>jj :BuffergatorMruCyclePrev<CR>     " buffergator
noremap <Leader>kk :BuffergatorMruCycleNext<CR>
noremap <Leader>bl :BuffergatorOpen<CR>
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

" Snippets
nnoremap \html :-1read $HOME/.vim/.skeleton.html<CR>3jf>a
nnoremap \pywait import time; time.sleep(5000)<ESC>


" ============================================================================
" IDE-like Setup
"" Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

"" Web
" au BufNewFile,BufRead *.js,*.html,*.css
"     \ set tabstop=2
