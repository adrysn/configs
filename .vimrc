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
Plugin 'tpope/vim-fugitive'         " git wrapper
Plugin 'scrooloose/nerdtree'        " file tree explorer
    map <c-n> <ESC>:NERDTree<CR>
Plugin 'vim-airline/vim-airline'    " pretty status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'     " shows a git diff in the gutter
    set updatetime=250
Plugin 'ctrlpvim/ctrlp.vim'         " finder
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }
    set wildignore+=*.pyc
    set wildignore+=*_build/*
    set wildignore+=*/coverage/*
Plugin 'tmhedberg/SimpylFold'       " better code folding
    let g:SimpylFold_docstring_preview = 1
"" Syntax
Plugin 'Valloric/YouCompleteMe'     " auto-completion
    let g:ycm_python_binary_path = 'python'
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
Plugin 'SirVer/ultisnips'           " ultimate solution for snippet
Plugin 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger       = "<c-j>"
    let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
    let g:UltiSnipsListSnippets        = "<c-k>"
Plugin 'nathanaelkane/vim-indent-guides'  " visually display indent levens
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=red   ctermbg=237
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
Plugin 'scrooloose/syntastic'       " syntax checking/highlighting
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
Plugin 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
Plugin 'pangloss/vim-javascript'
Plugin 'webdesus/polymer-ide.vim'
Plugin 'sjl/vitality.vim'
    let g:polymer_ide#use_syntastic = 1
    let g:syntastic_html_checkers = ['polylint']
    let g:syntastic_djangohtml_checkers = ['polylint']
call vundle#end()           " required
filetype plugin indent on   " required

" ============================================================================
" General
autocmd! bufwritepost .vimrc source %   " auto reload .vimrc when saved
autocmd FocusLost * wall
" autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1
syntax on               " syntax highlighting
set encoding=utf-8      " use UTF-8
colorscheme pablo

" ============================================================================
" Options
set cursorline          " show a visual line under the cursor's current line
set autoindent          " indent when moving to the next line while writing code
set smartindent         " tab is converted to 4 spaces (Python convention)
set tabstop=4
set shiftwidth=0        " use tabstop value 
set softtabstop=-1      " use shiftwidth value
" set textwidth=80
set colorcolumn=80      " draw vertical line
highlight ColorColumn ctermbg=darkgreen guibg=darkgreen
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
map <c-j> <c-w>j    " <ctrl - move> to move around the windows
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <Leader>m <esc>:tabprevious<CR> " easier tab moving
map <Leader>. <esc>:tabnext<CR>
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
