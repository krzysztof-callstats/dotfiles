" Be iMproved
set nocompatible

"=====================================================
"" Vundle settings
"=====================================================
filetype off
let $vundle=$vimhome."~/.vim_runtime/bundle/Vundle.vim"
set rtp+=$vundle
set rtp+=~/.fzf
call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required

    "-------------------=== Code/Project navigation ===-------------
    Plugin 'scrooloose/nerdtree'                " Project and file navigation
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'majutsushi/tagbar'                  " Class/module browser
    Plugin 'ctrlpvim/ctrlp.vim'                 " Fast transitions on project files
    Plugin 'junegunn/fzf.vim'                   " Fuzzy Finder

    "-------------------=== Other ===-------------------------------
    Plugin 'bling/vim-airline'                  " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
    Plugin 'powerline/powerline'                " Powerline fonts plugin
    Plugin 'fisadev/FixedTaskList.vim'          " Pending tasks list
    Plugin 'rosenfeld/conque-term'              " Consoles as buffers
    Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
    Plugin 'jiangmiao/auto-pairs.git'           " Braces magic
    Plugin 'flazz/vim-colorschemes'             " Colorschemes
    Plugin 'airblade/vim-gitgutter.git'         " Git support
    Plugin 'rafi/awesome-vim-colorschemes.git'  " Awesome Vim color schemes
    Plugin 'ryanoasis/vim-devicons'             " Icons

    "-------------------=== Snippets support ===--------------------
    Plugin 'garbas/vim-snipmate'                " Snippets manager
    Plugin 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
    Plugin 'tomtom/tlib_vim'                    " dependencies #2
    Plugin 'honza/vim-snippets'                 " snippets repo

    "-------------------=== Languages support ===-------------------
    Plugin 'tpope/vim-commentary'               " Comment stuff out
    Plugin 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
    Plugin 'Valloric/YouCompleteMe'             " Autocomplete plugin

    "-------------------=== Python  ===-----------------------------
    Plugin 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
    Plugin 'scrooloose/syntastic'               " Syntax checking plugin for Vim
    Plugin 'ambv/black'                         " Format python with black

    "-------------------=== Golang  ===-----------------------------
    Plugin 'fatih/vim-go'

call vundle#end()                           " required
filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
" let g:tagbar_width=42
autocmd BufEnter *.py,*.go :call tagbar#autoopen(0)
autocmd BufWinLeave *.py,*.go :TagbarClose

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
" let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap <F3> :NERDTreeToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=2         " Focus file always

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"
let g:go_highlight_types       = 1
let g:go_highlight_fields      = 1
let g:go_highlight_functions   = 1
let g:go_highlight_methods     = 1
let g:go_highlight_operators   = 1
let g:go_highlight_extra_types = 1

"=====================================================
"" SnipMate settings
"=====================================================
let g:snippets_dir='~/.vim/vim-snippets/snippets'
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

"=====================================================
"" Syntastic settings
"=====================================================
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='E'
let g:syntastic_style_error_symbol='E'
let g:syntastic_warning_symbol='W'
let g:syntastic_style_warning_symbol='W'


" Go
let g:syntastic_auto_loc_list = 1
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

"=====================================================
"" YouCompleteMe settings
"=====================================================
set completeopt-=preview

let g:ycm_global_ycm_extra_conf='~/.vim_runtime/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>

"=====================================================
"" Black settings
"=====================================================
autocmd BufWritePre *.py execute ':Black'
