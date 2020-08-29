" Fisa-nvim-config
" http://nvim.fisadev.com
" version: 10.0

" TODO current problems:
" * end key not working undef tmux+fish

" ============================================================================
" Vim-plug initialization Avoid modify this section, unless you are very sure of what you are doing 
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

let g:python3_host_prog = '/home/jms/.virtualenvs/base/bin/python'

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

" Now the actual plugins:

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Better file browser
Plug 'scrooloose/nerdtree'

" Split-Termial utilities
Plug 'vimlab/split-term.vim'

" Class/module browser
Plug 'majutsushi/tagbar'
" TODO known problems:
" * current block not refreshing

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'

" Vim colorscheme pack
Plug 'flazz/vim-colorschemes'

" dbext database connectivity pack
Plug 'vim-scripts/dbext.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
" Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
" Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Pending tasks list
"Plug 'fisadev/FixedTaskList.vim'

" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Completion from other opened files
Plug 'Shougo/context_filetype.vim'

" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }

" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Automatically close parenthesis, etc
Plug 'jiangmiao/auto-pairs'

" Surround
Plug 'tpope/vim-surround'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Better language packs
Plug 'sheerun/vim-polyglot'

" Javascript + JSX syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Javascript autocompletion
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" TODO is there a way to prevent the progress which hides the editor?

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" TODO is there a better option for neovim?

" Window chooser
Plug 't9md/vim-choosewin'

" Automatically sort python imports
Plug 'fisadev/vim-isort'

" Highlight matching html tags
Plug 'valloric/MatchTagAlways'

" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Yank history navigation
"Plug 'vim-scripts/YankRing.vim'

" Linters
Plug 'neomake/neomake'

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'

" Vim-devicons
Plug 'ryanoasis/vim-devicons'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" change mapleader <Leader> key to '\'
let mapleader="\\"

" fast edit and reload of .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" tab navigation
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" better backup, swap and undos storage
set nobackup        " disable backup
set nowb            " turn-off backups when overwriting a file
set noswapfile      " do not use swap files *.swp
"set directory=~/.vim/dirs/tmp     " directory to place swap files in
"set backup                        " make backup files
"set backupdir=~/.vim/dirs/backups " where to put backup files
"set undofile                      " persistent undos - undo after you re-open the file
"set undodir=~/.vim/dirs/undos
"set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
"let g:yankring_history_dir = '~/.vim/dirs/'

filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype

set encoding=utf8   " default encoding
set modelines=0     " disable modelines (CVE-2007-2438)
set history=500     " lines of history kept by vim
set lazyredraw      " disable redraw when executing macros (performance)
"set nowrap         " do not wrap lines
set backspace=2     " more powerful backspacing
set hlsearch        " highlight search terms
set incsearch       " incremental search
set ignorecase      " ignore case when searching
set smartcase       " ignore case only if search pattern is all lower-case
set number          " line numbering
set showmatch       " show matching parenthesis when cursor passes over them
set showcmd         " show cmd in status
set laststatus=2    " show status line (0=never, 1=when two windows, 2=always)
set cursorline      " highlight current line
set splitbelow      " vim default splits
set splitright      " vim default splits
set autoread        " auto-read a file when it has been changed outside of vim

" tabs and spaces handling
set expandtab
set autoindent
let s:tabwidth=2
let &l:tabstop = s:tabwidth
let &l:shiftwidth = s:tabwidth
let &l:softtabstop = s:tabwidth

" json files
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
" html files
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
" js files
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
" css files
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
" sql files
autocmd FileType sql setlocal shiftwidth=2 tabstop=2 softtabstop=2


" Special filetype handling
au BufNewFile,BufRead *.handlebars set filetype=html
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.jsx set filetype=javascript


" pop-up menu scrolling
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"


" dbext config
let g:dbext_default_profile_psql = 'type=PGSQL:host=localhost:port=5432:dbname=jewce:user=jms'
let g:dbext_default_profile = 'psql'
nnoremap <F7> :DBResultsOpen<CR>
nnoremap <F8> :DBResultsClose<CR>


" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    colorscheme Monokai
else
    colorscheme Monokai
endif

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew 
map tm :tabmove 
"map <M-Right> :tabn<CR>
"imap <M-Right> <ESC>:tabn<CR>
"map <M-Left> :tabp<CR>
"imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash 

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Split-term -------------------------

" Open a terminal
nnoremap <F3> :10Term<CR>


" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1


" NERDTree -----------------------------

" toggle nerdtree display
"map <F3> :NERDTreeToggle<CR>
map <S-t> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" use spacebar for opening folders
let NERDTreeMapActivateNode='<Space>'

" Tasklist ------------------------------

" show pending tasks list
" map <F2> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost,BufReadPost * Neomake

" Javascript
"let g:neomake_javascript_eslint_exe = 'eslint'
function! NeomakeESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let g:neomake_javascript_eslint_exe = l:eslint
endfunction
autocmd FileType javascript :call NeomakeESlintChecker()
"let g:neomake_javascript_eslint_exe = GetNpmBin('eslint')

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Autofix Javascript files with a specific config 
" Use this function to automatically use eslint 
" to fix simple errors like missing semi-colons, etc.
function! ESLintFix()
  write
  silent execute "!eslint -c ~/.fix-eslintrc --fix %"
  edit! %
  Neomake
endfunction

" Apply eslint --fix with formatting config 
" on current buffer, when F2 key is pressed
nnoremap <F2> :call ESLintFix()<CR>


" Fzf ------------------------------

" Start fzf picker interface
nnoremap <C-p> :<C-u>FZF<CR>
" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tag<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" commands finder mapping
nmap ,c :Commands<CR>
" to be able to call CtrlP with default search text
"function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    "execute ':CtrlP' . a:ctrlp_command_end
    "call feedkeys(a:search_text)
"endfunction
" same as previous mappings, but calling with current word as default text
"nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
"nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
"nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
"nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
"nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
"nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
"nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>



" Deoplete -----------------------------

" Use deoplete.

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
set completeopt+=longest,menuone
" close the preview window when leaving insert mode
" or the omni completion is done
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['file', 'ultisnips', 'ternjs']

" deoplete tern specific config
" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1
" Whether to include documentation strings (if found) in the result data.
let g:deoplete#sources#ternjs#docs = 1
" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0
let g:deoplete#sources#ternjs#case_insensitive = 1
" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'


" Tern ---------------------------------
"
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" Go to definition in new tab
nmap ,d :TernDoc<CR>
nmap ,q :pclose<CR>

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
"let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
"nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack 
nmap ,wr :Ack <cword><CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
"let g:yankring_clipboard_monitor = 0
"let g:yankring_history_dir = '~/.config/nvim/'

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
"let g:airline#extensions#whitespace#enabled = 0

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on docs/fancy_symbols.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
"let g:airline_symbols.space = "\ua0"
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
