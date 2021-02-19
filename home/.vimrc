"        _
"  _  __(_)_ _  ________
" | |/ / /  ' \/ __/ __/
" |___/_/_/_/_/_/  \__/

" Presettings {{{
set encoding=utf-8
scriptencoding utf-8
" }}}

" Plugins {{{
if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugins')
  Plug 'airblade/vim-gitgutter'          " Git diff on the sign column
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Show link structure of highlight groups
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
  Plug 'glidenote/memolist.vim'          " Create and manage memo
  Plug 'glts/vim-textobj-comment'        " Textobjects for comments
  Plug 'haya14busa/vim-asterisk'         " Provides improved * motion
  Plug 'itchyny/thumbnail.vim'           " Thumbnail-style buffer selector
  Plug 'junegunn/vim-easy-align'         " Alignment plugin
  Plug 'junegunn/vim-plug'               " Plugin manager
  Plug 'kana/vim-operator-replace'       " Operator to replace text
  Plug 'kana/vim-operator-user'          " Make it easy to define operators
  Plug 'kana/vim-textobj-indent'         " Textobjects for indented block
  Plug 'kana/vim-textobj-line'           " Textobjects for a portion of current line
  Plug 'kana/vim-textobj-user'           " Make it easy to define textobjects
  Plug 'lambdalisue/gina.vim'            " Git on Vim
  Plug 'machakann/vim-highlightedyank'   " Highlight the yanked text
  Plug 'machakann/vim-sandwich'          " Handle the sandwiched text easily
  Plug 'machakann/vim-swap'              " Reorder delimited items
  Plug 'machakann/vim-textobj-delimited' " Textobjects for delimited parts of string
  Plug 'machakann/vim-textobj-functioncall' " Textobjects for function-call regions
  Plug 'mattn/ctrlp-matchfuzzy'          " Fast CtrlP matcher
  Plug 'mattn/vim-lsp-settings'          " Auto configurations for vim-lsp
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
  Plug 'obcat/voyager.vim'               " Minimal file explorer
  Plug 'prabirshrestha/vim-lsp'          " Language Server Protocol
  Plug 'previm/previm'                   " Realtime markdown preview
  Plug 'rbtnn/vim-vimscript_lasterror'   " Jump to Vim script's last error
  Plug 'shougo/junkfile.vim'             " Create temporary file
  Plug 'thinca/vim-prettyprint'          " Prettyprint Vim variable for debug
  Plug 'thinca/vim-qfreplace'            " Perform the replacement in quickfix
  Plug 'thinca/vim-themis'               " Testing framework for Vim script
  Plug 'tpope/vim-repeat'                " Repeat some plugin commands by dot
  Plug 'tweekmonster/helpful.vim'        " Get version of Vim that has specific feature
  Plug 'tyru/capture.vim'                " Show Ex command output in a buffer
  Plug 'tyru/caw.vim'                    " Comment out
  Plug 'tyru/open-browser-github.vim'    " Opens GitHub URL of current file
  Plug 'tyru/open-browser.vim'           " Open URL with browser
  Plug 'vim-jp/syntax-vim-ex'            " Excellent Vim's syntax highlighting
  Plug 'vim-jp/vimdoc-ja'                " Japanese help
  call plug#end()
else
  augroup my-notify-noplugins
    autocmd!
    autocmd VimEnter * echomsg 'Plugins are not installed yet. See README.md.'
  augroup END
  command! PluginManagerInstall
    \ !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

packadd! cfilter
packadd! matchit
filetype plugin on

function s:has(plug) abort
  let dir = printf("g:plugs['%s']['dir']", a:plug)
  return exists(dir) ? isdirectory(eval(dir)) : 0
endfunction
" }}}

" Options {{{
" Appearance
set background=dark
set cmdheight=2
set display=lastline
set foldtext=my#foldtext#global()
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set nowrap
set number
set shortmess& shortmess+=a
set showtabline=2
set signcolumn=yes
set statusline=%!my#statusline#global()
set tabline=%!my#tabline#global()
set title
set titlestring=%{fnamemodify(getcwd(),\ ':t')}
set wildmenu
syntax enable

" Backup
set directory=~/.vim/data/swap
call mkdir(&directory, 'p')
set history=1000

" Completion
set pumheight=8
set wildignorecase

" Cursor
if has('vim_starting')
  let &t_EI .= "\e[2 q"
  let &t_SI .= "\e[6 q"
  let &t_SR .= "\e[4 q"
endif

" Editing
set backspace=indent,eol,start
set nrformats&
  \ nrformats-=octal
  \ nrformats+=unsigned
set virtualedit=block,onemore

" Indent
filetype indent on
set autoindent
set breakindent
set expandtab
set linebreak
set shiftwidth=0
set softtabstop=-1
set tabstop=2
let g:vim_indent_cont = 2

" Language
set helplang=ja
set spelllang=en,cjk
set spelloptions=camel

" Scroll
set scrolloff=7
set sidescroll=1
set sidescrolloff=1

" Search
set ignorecase
set incsearch
set smartcase

" Window
set splitbelow
set splitright

" Misc
set belloff=error
set clipboard=unnamed
set diffopt& diffopt+=vertical
set hidden
set lazyredraw
set mouse=a
set path=.,,
set report=0
set timeoutlen=5000
set ttimeoutlen=50
set updatetime=100
" }}}

" Key mappings {{{
" Normal
nnoremap - <Cmd>edit %:h<CR>
nnoremap g: g;
nnoremap <C-u> <Cmd>call my#smoothscroll#up()<CR>
nnoremap <C-d> <Cmd>call my#smoothscroll#down()<CR>
nnoremap Y y$
nnoremap <C-_>h     <Cmd>set hlsearch!<CR>
nnoremap <C-_><C-h> <Cmd>set hlsearch!<CR>
nnoremap <C-_>w     <Cmd>setlocal wrap!<CR>
nnoremap <C-_><C-w> <Cmd>setlocal wrap!<CR>
nnoremap <expr> [q printf('<Cmd>%d cprevious<CR>', v:count1)
nnoremap <expr> ]q printf('<Cmd>%d cnext<CR>',     v:count1)

" Insert
inoremap <C-u> <C-g>u<C-u>

" Command line
if has('patch-8.2.2221')
  cnoremap <C-n> <Down>
else
  cnoremap <C-n> <Cmd>call feedkeys("<Bslash><lt>Down>", 'nt')<CR>
endif
cnoremap <C-p> <Up>
cnoremap <expr> <C-o> wildmenumode() ? '<Left>' : my#util#get_parent_directory()
" }}}

" User-defined commands {{{
command! Tig terminal ++curwin tig --all
" }}}

" Autocommands {{{
augroup my-terminalopen
  autocmd!
  autocmd TerminalOpen * call setbufvar(+expand('<abuf>'), '&filetype', 'terminal')
augroup END

augroup my-filetype
  autocmd!
  autocmd FileType *         setlocal formatoptions-=o formatoptions+=j
  autocmd FileType *commit*  setlocal nofoldenable spell
  autocmd FileType diff      setlocal nofoldenable
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd FileType terminal  setlocal nonumber signcolumn=no
  autocmd FileType help,qf,vim source ~/.vim/filetype/<amatch>.vim
augroup END

augroup my-restore-curpos
  autocmd!
  autocmd BufReadPost *
    \ if 1 <= line("'\"") && line("'\"") <= line('$') && &filetype !~# 'commit'
    \|  execute 'normal! g`"'
    \|endif
augroup END

augroup my-vimresized
  autocmd!
  autocmd VimResized * wincmd =
augroup END
" }}}

" Plugin settings {{{
if s:has('caw.vim') "{{{
  let g:caw_no_default_keymappings = 1
  let g:caw_operator_keymappings   = 1
  nmap g/ <Plug>(caw:hatpos:toggle:operator)
  xmap g/ <Plug>(caw:hatpos:toggle)
endif "}}}

if s:has('capture.vim') "{{{
  let g:capture_open_command = 'botright new'
endif "}}}

if s:has('ctrlp.vim') "{{{
  let g:ctrlp_by_filename     = 1
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_show_hidden     = 1
  let g:ctrlp_line_prefix  = '▸ '
  let g:ctrlp_reuse_window = '.*'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

  if s:has('ctrlp_matchfuzzy.vim')
    let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
  endif

  augroup my-ctrlp
    autocmd!
    autocmd VimEnter,VimResized * call my#ctrlp#set_options()
  augroup END

  let g:ctrlp_cmd = 'CtrlPMRUFiles'
  let g:ctrlp_map = '<Space>'
  nnoremap g<Space> <Cmd>CtrlP<CR>
endif "}}}

if s:has('gina.vim') "{{{
  nnoremap <Bslash>b <Cmd>Gina branch -av<CR>
  nnoremap <Bslash>c <Cmd>Gina compare<CR>
  nnoremap <Bslash>d <Cmd>Gina diff<CR>
  nnoremap <Bslash>l <Cmd>Gina log --graph --all<CR>
  nnoremap <Bslash>s <Cmd>Gina status<CR>

  call gina#custom#mapping#map(
   \ 'status', 'i',
   \ '<Plug>(gina-index-stage)',
   \ {'nowait': 1}
   \ )
  call gina#custom#mapping#map(
   \ 'status', 'o',
   \ '<Plug>(gina-index-unstage)',
   \ {'nowait': 1}
   \ )
  call gina#custom#mapping#nmap(
    \ 'log', 'rr',
    \ '<Cmd>call my#gina#rebase_interactive()<CR>',
    \ {'noremap': 1},
    \)
  call gina#custom#action#shorten(
    \ 'branch',
    \ 'commit'
    \ )
  call gina#custom#command#option(
   \ 'status',
   \ '-b|--branch'
   \)
  call gina#custom#command#option(
   \ 'status',
   \ '-s|--short'
   \)

  augroup my-gina
    autocmd!
    autocmd FileType gina-log setlocal number signcolumn=no cursorline
  augroup END
endif "}}}

if s:has('junkfile.vim') "{{{
  let g:junkfile#directory = isdirectory(expand('~/Dropbox'))
    \ ? expand('~/Dropbox/junkfile')
    \ : expand('~/junkfile')
endif "}}}

if s:has('memolist.vim') "{{{
  let g:memolist_path = isdirectory(expand('~/Dropbox'))
    \ ? expand('~/Dropbox/memolist')
    \ : expand('~/memolist')
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = expand('~/.vim/template/memolist')
endif "}}}

if s:has('open-browser.vim') "{{{
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  xmap gx <Plug>(openbrowser-smart-search)
endif "}}}

if s:has('vim-asterisk') "{{{
  nmap * <Plug>(asterisk-z*)
  xmap * <Plug>(asterisk-z*)
  nmap g* <Plug>(asterisk-gz*)
  xmap g* <Plug>(asterisk-gz*)
endif "}}}

if s:has('vim-better-whitespace') "{{{
  let g:strip_whitespace_on_save = 1
  let g:better_whitespace_ctermcolor = 'NONE'
  let g:better_whitespace_guicolor   = 'NONE'
endif "}}}

if s:has('vim-easy-align') "{{{
  nmap g= <Plug>(EasyAlign)
  xmap g= <Plug>(EasyAlign)
endif "}}}

if s:has('vim-gitgutter') "{{{
  let g:gitgutter_sign_priority = 10
  let g:gitgutter_map_keys = 0
  nnoremap H <Nop>
  xnoremap H <Nop>
  nmap Hp <Plug>(GitGutterPreviewHunk)
  nmap Hs <Plug>(GitGutterStageHunk)
  xmap Hs <Plug>(GitGutterStageHunk)
  nmap Hu <Plug>(GitGutterUndoHunk)
  nmap [c <Plug>(GitGutterPrevHunk)
  nmap ]c <Plug>(GitGutterNextHunk)
endif "}}}

if s:has('vim-highlightedyank') "{{{
  let g:highlightedyank_highlight_duration = 500
endif "}}}

if s:has('vim-lsp') "{{{
  let g:lsp_diagnostics_echo_cursor    = 1
  let g:lsp_document_highlight_enabled = 0
  let g:lsp_signs_priority = 20
  let g:lsp_diagnostics_signs_error       = {'text': 'E'}
  let g:lsp_diagnostics_signs_warning     = {'text': 'W'}
  let g:lsp_diagnostics_signs_information = {'text': 'I'}
  let g:lsp_diagnostics_signs_hint        = {'text': 'H'}

  augroup my-lsp
    autocmd!
    autocmd User lsp_buffer_enabled call my#lsp#on_lsp_buffer_enabled()
    autocmd User lsp_float_opened   call my#lsp#on_lsp_float_opened()
  augroup END
endif "}}}

if s:has('vim-operator-replace') "{{{
  nmap _ <Plug>(operator-replace)
  xmap _ <Plug>(operator-replace)
endif "}}}

if s:has('vim-sandwich') "{{{
  nnoremap s <Nop>
  xnoremap s <Nop>
endif "}}}

if s:has('vim-swap') "{{{
  let g:swap_no_default_key_mappings = 1
  nnoremap s <Nop>
  xnoremap s <Nop>
  nmap sp <Plug>(swap-prev)
  nmap sn <Plug>(swap-next)
  nmap <C-\>s <Plug>(swap-interactive)
  xmap <C-\>s <Plug>(swap-interactive)
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
  let g:swap#keymappings = {
    \ '1': ['1', 'fix_nr'],
    \ '2': ['2', 'fix_nr'],
    \ '3': ['3', 'fix_nr'],
    \ '4': ['4', 'fix_nr'],
    \ '5': ['5', 'fix_nr'],
    \ '6': ['6', 'fix_nr'],
    \ '7': ['7', 'fix_nr'],
    \ '8': ['8', 'fix_nr'],
    \ '9': ['9', 'fix_nr'],
    \ 'u': ['undo'],
    \ "\<C-r>": ['redo'],
    \ 'p': ['swap_prev'],
    \ 'n': ['swap_next'],
    \ "\<C-p>": ['move_prev'],
    \ "\<C-n>": ['move_next'],
    \ 's': ['sort'],
    \ 'S': ['SORT'],
    \ 'g': ['group'],
    \ 'G': ['ungroup'],
    \ 'r': ['reverse'],
    \ "\<Esc>": ['Esc'],
    \ }
endif "}}}

if s:has('vim-textobj-comment') "{{{
  let g:textobj_comment_no_default_key_mappings = 1
  omap i/ <Plug>(textobj-comment-a)
  xmap i/ <Plug>(textobj-comment-a)
  omap a/ <Plug>(textobj-comment-big-a)
  xmap a/ <Plug>(textobj-comment-big-a)
endif "}}}

if s:has('voyager.vim') "{{{
  let g:voyager_keepalt = 1
  augroup my-voyager
    autocmd!
    autocmd FileType voyager setlocal cursorline signcolumn=no statusline=%!my#statusline#local('voyager')
  augroup END
endif "}}}
" }}}

" Color scheme {{{
augroup my-colorscheme
  autocmd!
  autocmd ColorScheme iceberg,slate source ~/.vim/colorscheme/<amatch>.vim
augroup END

if $COLORTERM is 'truecolor' || $COLORTERM is '24bit'
  set termguicolors
endif

if s:has('iceberg.vim')
  colorscheme iceberg
else
  colorscheme slate
endif
" }}}

" Local settings {{{
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
" }}}
