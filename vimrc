" vim-bootstrap b990cad

"*****************************************************************************
"" Rob's Shit
"*****************************************************************************

" for vimproc plugin
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif

" ROBS NOTES: change cursor in iTerm2
" https://iterm2.com/documentation/2.1/documentation-escape-codes.html
if $TERM_PROGRAM == "iTerm.app"
    " insert mode (Vertical Bar)
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " replace mode (Underline)
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    " normal mode (Block)
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ROBS NOTES: F5 to delete all trailing whitespaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" ROBS NOTES: remap shift+; (:) to ;
noremap ;; ;
nmap ; :

" modify selected text using combining diacritics
" ROBS NOTES: UNDERLINE & STRIKETHROUGH CHARACTERS.. but how do I use?
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')
function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

" ROBS NOTES: getting started with ctags... not using
" https://medium.com/@galea/getting-started-with-ctags-vim-on-macos-87bcb07cf6d
set tags=tags

" don't hide quotes in JSON files ugh!
set conceallevel=0

" ROBS NOTES: swp files
" Move swp files all to here
set directory^=~/.vim/swap
set backupdir^=~/.vim/swap
set swapfile

" ROBS NOTES: wild settings
set path+=**
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" ROBS NOTES: Make tags shortcut
command! MakeTags !ctags -R *

" ROBS NOTES: File Browsing with netrw
" ROBS NOTES: Seems like this is all done vim-vinegar
" let g:netrw_banner=0
" let g:netrw_browse_split=4
" let g:netrw_altv=1
" let g:netrw_liststyle=3
" let g:netrw_winsize=25
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

" ROBS NOTES: save undos
set undodir=~/.vim/undodir
set undofile  " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload

" ROBS NOTES: always split on the right
set splitright
set splitbelow

" ROBS NOTES: highlight current line on active window
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
    set nocompatible               " Be iMproved
endif

" ROBS NOTES: vim-bootstrap is a plugin
let g:vim_bootstrap_langs = "python"
let g:vim_bootstrap_editor = "" " nvim or vim

" ROBS NOTES: polyglot don't do syntax highlighting for python
let g:polyglot_disabled = ['python']

" ROBS NOTES: download vim-plug if it doesn't exist
let vimplug_exists=expand('~/./autoload/plug.vim')
if !filereadable(vimplug_exists)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent !\curl -fLo ~/./autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = "yes"

    autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/./plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'

" ROBS NOTES: commment stuff out
" Use gcc to comment out a line (takes a count)
" gc to comment out the target of a motion (for example, gcap to comment out a paragraph),
" gc in visual mode to comment out the selection, and gc in operator pending
" :7,17Commentary, or as part of a :global invocation like with :g/TODO/Commentary. That's it.
Plug 'tpope/vim-commentary'

" ROBS NOTES: :Git :Gstatus :Gsplit :Gvdiffsplit
Plug 'tpope/vim-fugitive'

" ROBS NOTES: vinegar is netrw improved
Plug 'tpope/vim-vinegar'

" ROBS NOTES: a universal set of defaults everyone can agree on
Plug 'tpope/vim-sensible'

" ROBS NOTES: a vim plugin for interacting with databases :DB
Plug 'tpope/vim-dadbod'

" ROBS NOTES: mappings for working with JSON in Vim
" aj provides a text object for the outermost JSON object, array, string, number, or keyword.
" gqaj \"pretty print\" (wraps/indents/sorts keys/otherwise cleans up) the JSON construct under the cursor.
" gwaj takes the JSON object on the clipboard and extends it into the JSON object under the cursor.
Plug 'tpope/vim-jdaddy'

" ROBS NOTES: tpope's colorscheme
Plug 'tpope/vim-vividchalk'

" ROBS NOTES: nice status line bottom of vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ROBS NOTES: adds icons in the sign column w/re/ to git status
" also has a lot of shortcuts to navigate git hunks
" check out :help gitgutter
Plug 'airblade/vim-gitgutter'

" ROBS NOTES: this is really cool! :Grep
" I don't know how to search for help on this plugin
Plug 'vim-scripts/grep.vim'

" ROBS NOTES: use gvim colorschemes on CLI vim
Plug 'vim-scripts/CSApprox'

" ROBS NOTES: trailing whitespace highlight red
Plug 'bronson/vim-trailing-whitespace'

Plug 'iamcco/markdown-preview.nvim'

" ROBS NOTES: coc (disabled, kept getting error)
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" ROBS NOTES: Add a bunch of colorschemes
Plug 'flazz/vim-colorschemes'

" ROBS NOTES: Colorscheme switcher, F8 and Shift+F8 to switch
Plug 'xolox/vim-colorscheme-switcher'

" ROBS NOTES: Syntax Error Checking
" (flake8 / pylint for python)
" Plug 'vim-syntastic/syntastic'

" ROBS NOTES: thin vertical lines ,l to toggle
Plug 'Yggdroot/indentLine' " IndentLinesToggle

" ROBS NOTES: vim-bootstrap.com... is this working?
Plug 'avelino/vim-bootstrap-updater'

" ROBS NOTES: jinja2 syntax highlighting
Plug 'glench/vim-jinja2-syntax'

" ROBS NOTES: extends " and @ so you can see the contents of the registers
Plug 'junegunn/vim-peekaboo'

" ROBS NOTES: adds syntax highlighting for a huge number of files
Plug 'sheerun/vim-polyglot'

" ROBS NOTES: Drawing boxes (disabled forgot how to use)
"Plug 'gyim/vim-boxdraw'

" ROBS NOTES: Added UnconditionalPaste for "*gcp
Plug 'vim-scripts/UnconditionalPaste'

" ROBS NOTES: Make tables in vim (disabled)
" Plug 'dhruvasagar/vim-table-mode'
" let g:table_mode_corner_corner='+'
" let g:table_mode_header_fillchar='='

" ROBS NOTES: extensive module to interact with external executables
" looks like a wrapper around popen and some file I/O
" at minimum can be used instead of :!
" help vimproc
Plug 'Shougo/vimproc.vim', {'do': g:make}

" ROBS NOTES: I think these are dependencies to vim-colorscheme?
Plug 'xolox/vim-misc'

" ROBS NOTES: :SaveSession and :OpenSession :CloseSession :DeleteSession
" setting g:session_directory
Plug 'xolox/vim-session'

" ROBS NOTES: snips are shorthand aliases
" ... but I think you need YouCompleteMe for these to work
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"" Colorscheme molokai
Plug 'tomasr/molokai'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" python
"" Python Bundle

" ROBS NOTES: how do I use?
Plug 'lifepillar/pgsql.vim'

Plug 'vim-scripts/indentpython.vim'

" ROBS NOTES: what is supertab?
Plug 'ervandew/supertab'

" ROBS NOTES: what is this?
" Plug 'majutsushi/tagbar'

Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'hdima/python-syntax'

" ROBS NOTES: VirtualEnvList VirtualEnvActivate VirtualEnvDeactive
Plug 'jmcantrell/vim-virtualenv'

"*****************************************************************************
"*****************************************************************************
" ROBS NOTES: Switching from fzf to telescope
if has('nvim')
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif

if has('nvim')
    " neovim lspconfig
    " https://github.com/neovim/nvim-lspconfig
    Plug 'neovim/nvim-lspconfig'
    " https://github.com/dense-analysis/ale
    Plug 'dense-analysis/ale'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

"*****************************************************************************
"*****************************************************************************

call plug#end()

" ROBS NOTES: session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"" Include user's extra bundle
if filereadable(expand("~/.rc.local.bundles"))
  source ~/.rc.local.bundles
endif

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python" },
  highlight = {
    enable = true
  },
}
EOF

" python-language-server (pyls) palantir
lua << EOF
require'lspconfig'.pyls.setup{
  cmd = {"pyls"},
  filetypes = {"python"},
  settings = {
    pyls = {
      configurationSources = {"flake8"},
      plugins = {
        jedi_completion = {enabled = true},
        jedi_hover = {enabled = true},
        jedi_references = {enabled = true},
        jedi_signature_help = {enabled = true},
        jedi_symbols = {enabled = true, all_scopes = true},
        flake8 = {
          enabled = true,
          ignore = {},
          maxLineLength = 120
        },
      }
    }
  },
  on_attach = on_attach
}
EOF

" ROBS NOTES: ale config

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set formatoptions-=t

" ROBS NOTES: MAP LEADER!!
"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
syntax enable
set ruler
set number

let base16colorspace=256
set background=dark
let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  "colorscheme vividchalk
  "colorscheme molokai
  "colorscheme solarized
endif

set mousemodel=popup

" ROBS NOTES: testing
set mouse=a

set t_Co=256
set guioptions=egmrti

" ROBS NOTES: where is my cursor? There it is
set cursorline
set cursorcolumn

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    colorscheme solarized8_light
    " set guifont=Menlo:h12
    set guifont=Monaco:h11
    set transparency=7
  endif
else
  " CHANGE colorscheme here
  " colorscheme molokai
  colorscheme solarized8_light
  let g:CSApprox_loaded = 1
  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
endif

if &term =~ '256color'
  set t_ut=
endif

if has("termguicolors")
    set termguicolors
endif

"" Disable the blinking cursor.
"set gcr=a:blinkon0

" ROBS NOTES: Keep at least 3 lines on bottom
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

"set statusline=%F%m%r%h%w%{kite#statusline()}%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev lcl lclose

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" vimshell.vim
" let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
" let g:vimshell_prompt =  '$ '

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************

"*****************************************************************************
"" wrapping
"*****************************************************************************

" ROBS NOTES: don't wrap
set textwidth=0
set wrap!
set wm=0

" ROBS NOTES: I don't like wrapping in txt mode
" if !exists('*s:setupNoWrapping')
"   function s:setupNoWrapping()
"     set textwidth=0
"     set wrap!
"     set wm=0
"   endfunction
" endif

" " ROBS NOTES: If there is wrapping change j k behaviour
" if !exists('*s:setupWrapping')
"   function s:setupWrapping()
"     set wrap
"     set wm=2
"     set textwidth=79
"     set formatoptions+=t
"     nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
"     nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
"   endfunction
" endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
" augroup vimrc-wrapping
"   autocmd!
"   autocmd BufRead,BufNewFile *.txt call s:setupNoWrapping()
" augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git (via fugitive)
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" vertical indent lines toggle
nnoremap <leader>l :IndentLinesToggle<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" snippets
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" let g:UltiSnipsEditSplit="vertical"

" syntastic
" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_exec = '/usr/local/bin/flake8'
" let g:syntastic_python_flake8_args='--ignore=E501,E225'
" let g:flake8_max_line_length=120
" let g:flake8_ignore="E501"
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list=1
" let g:syntastic_aggregate_errors = 1

" Tagbar (not using tags)
" noremap <leader>m :TagbarToggle<CR>
" let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"" I think this loads the latest version of the file
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

"" Set working directory
nnoremap <leader>. :lcd =expand("%:p:h")<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

noremap <leader>p "+gP<CR>
noremap YY "+y<CR>
noremap PP "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

" ROBS NOTES: Move tab nav to the top
"" Tab nav
noremap <leader>q :tabp<CR>
noremap <leader>w :tabn<CR>

"" Close buffer
noremap <leader>cc :bd<CR>

" ROBS NOTES: Clear highlighted text from search
"" Clean search (highlight)
"nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

nnoremap <silent> <Leader>= :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
" nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=120
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

au BufNewFile,BufRead *.py set autoindent fileformat=unix encoding=utf-8
au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2 softtabstop=2 shiftwidth=2

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let python_highlight_all = 1

"*****************************************************************************
"*****************************************************************************
" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"*****************************************************************************
"*****************************************************************************


"" Include user's local vim config
if filereadable(expand("~/.rc.local"))
  source ~/.rc.local
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

"*****************************************************************************
"" MacVim Stuff
"*****************************************************************************

" System vimrc file for MacVim
"
" Author:       Bjorn Winckler <bjorn.winckler@gmail.com>
" Maintainer:   macvim-dev (https://github.com/macvim-dev)

" Disable localized menus for now since only some items are translated (e.g.
" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none

" Python2
" MacVim is configured by default to use the pre-installed System python2
" version. However, following code tries to find a Homebrew, MacPorts or
" an installation from python.org:
if exists("&pythondll") && exists("&pythonhome")
  if filereadable("/usr/local/Frameworks/Python.framework/Versions/2.7/Python")
    " Homebrew python 2.7
    set pythondll=/usr/local/Frameworks/Python.framework/Versions/2.7/Python
  elseif filereadable("/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python")
    " MacPorts python 2.7
    set pythondll=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python
  elseif filereadable("/Library/Frameworks/Python.framework/Versions/2.7/Python")
    " https://www.python.org/downloads/mac-osx/
    set pythondll=/Library/Frameworks/Python.framework/Versions/2.7/Python
  endif
endif

" Python3
" MacVim is configured by default to use Homebrew python3 version
" If this cannot be found, following code tries to find a MacPorts
" or an installation from python.org:
if exists("&pythonthreedll") && exists("&pythonthreehome") &&
      \ !filereadable(&pythonthreedll)
  if filereadable("/opt/local/Library/Frameworks/Python.framework/Versions/3.7/Python")
    " MacPorts python 3.7
    set pythonthreedll=/opt/local/Library/Frameworks/Python.framework/Versions/3.7/Python
  elseif filereadable("/Library/Frameworks/Python.framework/Versions/3.7/Python")
    " https://www.python.org/downloads/mac-osx/
    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.7/Python
  endif
endif

" ROBS NOTES: Change to local .env
function Senv()
  let g:syntastic_python_python_exec = '.env/bin/python'
endfunction

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ***** Markdown Preview/Viewer *****
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']
