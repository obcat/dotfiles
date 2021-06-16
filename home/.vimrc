vim9script
#        _
#  _  __(_)_ _  ________
# | |/ / /  ' \/ __/ __/
# |___/_/_/_/_/_/  \__/

# Presettings {{{1
set encoding=utf-8
scriptencoding utf-8

# Plugins {{{1
if filereadable(expand('~/.vim/autoload/plug.vim'))
  plug#begin('~/.vim/plugins')
  Plug 'airblade/vim-gitgutter'          # Git diff on the sign column
  Plug 'cocopon/iceberg.vim'             # Color scheme
  Plug 'cocopon/inspecthi.vim'           # Show link structure of highlight groups
  Plug 'ctrlpvim/ctrlp.vim'              # Fuzzy finder
  Plug 'glidenote/memolist.vim'          # Create and manage memo
  Plug 'glts/vim-textobj-comment'        # Textobjects for comments
  Plug 'haya14busa/vim-asterisk'         # Provides improved * motion
  Plug 'itchyny/dictionary.vim'          # An interface for Dictionary.app
  Plug 'junegunn/vim-easy-align'         # Alignment plugin
  Plug 'junegunn/vim-plug'               # Plugin manager
  Plug 'kana/vim-operator-replace'       # Operator to replace text
  Plug 'kana/vim-operator-user'          # Make it easy to define operators
  Plug 'kana/vim-textobj-indent'         # Textobjects for indented block
  Plug 'kana/vim-textobj-line'           # Textobjects for a portion of current line
  Plug 'kana/vim-textobj-user'           # Make it easy to define textobjects
  Plug 'lambdalisue/gina.vim'            # Git on Vim
  Plug 'machakann/vim-highlightedyank'   # Highlight the yanked text
  Plug 'machakann/vim-sandwich'          # Handle the sandwiched text easily
  Plug 'machakann/vim-swap'              # Reorder delimited items
  Plug 'machakann/vim-textobj-delimited' # Textobjects for delimited parts of string
  Plug 'machakann/vim-textobj-functioncall' # Textobjects for function-call regions
  Plug 'mattn/ctrlp-matchfuzzy'          # Fast CtrlP matcher
  Plug 'mattn/vim-lsp-settings'          # Auto configurations for vim-lsp
  Plug 'ntpeters/vim-better-whitespace'  # Highlight the trailing white spaces
  Plug 'obcat/vim-histcase'              # A missing option for cmdline history search
  Plug 'obcat/vim-ipos'                  # Missing companions to '^ and gi
  Plug 'obcat/vim-ref-godoc'             # A vim-ref source for go doc
  Plug 'obcat/voyager.vim'               # Minimal file explorer
  Plug 'prabirshrestha/vim-lsp'          # Language Server Protocol
  Plug 'previm/previm'                   # Realtime markdown preview
  Plug 'rbtnn/vim-vimscript_lasterror'   # Jump to Vim script's last error
  Plug 'shougo/junkfile.vim'             # Create temporary file
  Plug 'thinca/vim-prettyprint'          # Prettyprint Vim variable for debug
  Plug 'thinca/vim-qfreplace'            # Perform the replacement in quickfix
  Plug 'thinca/vim-quickrun'             # Run a command quickly
  Plug 'thinca/vim-ref'                  # Integrated reference viewer
  Plug 'thinca/vim-themis'               # Testing framework for Vim script
  Plug 'tpope/vim-repeat'                # Repeat some plugin commands by dot
  Plug 'tweekmonster/helpful.vim'        # Get version of Vim that has specific feature
  Plug 'tyru/capture.vim'                # Show Ex command output in a buffer
  Plug 'tyru/caw.vim'                    # Comment out
  Plug 'tyru/open-browser.vim'           # Open URL with browser
  Plug 'vim-jp/autofmt'                  # Text formatting plugin
  Plug 'vim-jp/syntax-vim-ex'            # Excellent Vim's syntax highlighting
  Plug 'vim-jp/vimdoc-ja'                # Japanese help
  plug#end()
else
  augroup my-notify-noplugins
    autocmd!
    autocmd VimEnter * echomsg 'Plugins are not installed yet. See README.md.'
  augroup END
  command! PluginManagerInstall !curl -fLo ~/.vim/autoload/plug.vim
        \ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

packadd! cfilter
packadd! matchit
filetype plugin on

def Has(plug: string): bool
  const dir = printf('g:plugs[%s][''dir'']', string(plug))
  return exists(dir) ? isdirectory(eval(dir)) : false
enddef

# Options {{{1
# Appearance
set background=dark
set cmdheight=2
set display=lastline
set foldtext=my#foldtext#get()
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set nowrap
set number
set shortmess&
      \ shortmess+=a
set showtabline=2
set signcolumn=yes
set statusline=%!my#statusline#get('Global')
set tabline=%!my#tabline#get()
set title
set titlestring=%{fnamemodify(getcwd(),\ ':p')}
set wildmenu
syntax enable

# Backup
set directory=~/.vim/data/swap
mkdir(&directory, 'p')
set history=1000

# Completion
set pumheight=8
set wildignorecase

# Cursor
if has('vim_starting')
  &t_EI ..= "\e[2 q"
  &t_SI ..= "\e[6 q"
  &t_SR ..= "\e[4 q"
endif

# Editing
set backspace=indent,eol,start
set nrformats&
      \ nrformats-=octal
      \ nrformats+=unsigned
set virtualedit=block

# Indent
filetype indent on
set autoindent
set breakindent
set expandtab
set linebreak
set shiftwidth=0
set smartindent
set softtabstop=-1
set tabstop=2
g:vim_indent_cont = 0

# Language
set helplang=ja
set spelllang=en,cjk
set spelloptions=camel

# Scroll
set scrolloff=7
set sidescroll=1
set sidescrolloff=1

# Search
set ignorecase
set incsearch
set smartcase

# Window
set splitbelow
set splitright

# Misc
set belloff=error
set clipboard=unnamed
set diffopt&
      \ diffopt+=vertical
set formatoptions+=mB
set hidden
set lazyredraw
set mouse=a
set path=.,,
set report=0
set timeoutlen=5000
set ttimeoutlen=50
set updatetime=100

# Key mappings {{{1
g:mapleader = "\<S-F1>"
g:maplocalleader = "\<S-F2>"

# Normal
nnoremap - <Cmd>edit %:h<CR>
nnoremap g: g;
nnoremap Y y$
nnoremap <C-_>h <Cmd>set hlsearch!<CR>
nnoremap <C-_>w <Cmd>setlocal wrap!<CR>
nnoremap <expr> [c &diff ? '[c' : printf('<Cmd>%d cprevious<CR>', v:count1)
nnoremap <expr> ]c &diff ? ']c' : printf('<Cmd>%d cnext<CR>',     v:count1)
nnoremap <expr> [l printf('<Cmd>%d lprevious<CR>', v:count1)
nnoremap <expr> ]l printf('<Cmd>%d lnext<CR>',     v:count1)

# Insert
inoremap <C-u> <C-g>u<C-u>

# Command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <expr> <C-o> wildmenumode() ? '<Left>' : my#util#get_parent_directory()

# User-defined commands {{{1
command! Tig terminal ++curwin tig --all

# Autocommands {{{1
augroup my-terminalopen
  autocmd!
  autocmd TerminalOpen * setbufvar(str2nr(expand('<abuf>')), '&filetype', 'terminal')
augroup END

augroup my-filetype
  autocmd!
  autocmd FileType *         setlocal formatoptions-=o formatoptions+=j
  autocmd FileType *commit*  setlocal nofoldenable spell
  autocmd FileType diff      setlocal nofoldenable
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd FileType terminal  setlocal nonumber signcolumn=no
  autocmd FileType markdown,text setlocal wrap
  autocmd FileType help,qf,vim,go source ~/.vim/filetype/<amatch>.vim
augroup END

augroup my-cmdwin
  autocmd!
  autocmd CmdwinEnter * setlocal nonumber signcolumn=no
augroup END

augroup my-restore-curpos
  autocmd!
  autocmd BufReadPost * if 1 <= line('''"') && line('''"') <= line('$') && &filetype !~ 'commit'
  autocmd BufReadPost *   normal! g`"
  autocmd BufReadPost * endif
augroup END

augroup my-vimresized
  autocmd!
  autocmd VimResized * wincmd =
augroup END

# Plugin settings {{{1
if Has('autofmt') # {{{2
  g:autofmt_allow_over_tw = true
  set formatexpr=autofmt#japanese#formatexpr()
endif

if Has('caw.vim') # {{{2
  g:caw_no_default_keymappings = true
  g:caw_operator_keymappings   = true
  # vvvv     v
  # comment *a*ut operator (thanks @monaqa!)
  nmap , <Plug>(caw:hatpos:toggle:operator)
  omap , <Plug>(caw:hatpos:toggle:operator)
  xmap , <Plug>(caw:hatpos:toggle)
  augroup my-caw
    autocmd!
    autocmd FileType vim if getline(1) =~ '^vim9script'
    autocmd FileType vim   b:caw_oneline_comment = '#'
    autocmd FileType vim endif
  augroup END
endif

if Has('capture.vim') # {{{2
  g:capture_open_command = 'botright new'
  augroup my-capture
    autocmd!
    autocmd FileType capture setlocal nolist nonumber signcolumn=no
  augroup END
endif

if Has('ctrlp.vim') # {{{2
  g:ctrlp_by_filename     = true
  g:ctrlp_follow_symlinks = true
  g:ctrlp_show_hidden     = true
  g:ctrlp_line_prefix  = '▸ '
  g:ctrlp_reuse_window = '.*'
  g:ctrlp_match_window = 'order:ttb,min:7,max:7'
  g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

  if Has('ctrlp_matchfuzzy.vim')
    g:ctrlp_match_func = {match: 'ctrlp_matchfuzzy#matcher'}
  endif

  g:ctrlp_cmd = 'CtrlPMRUFiles'
  g:ctrlp_map = '<Space>'
  nnoremap g<Space> <Cmd>CtrlP<CR>
endif

if Has('dictionary.vim') # {{{2
  nnoremap <F1> <Cmd>Dictionary -cursor-word<CR>
endif

if Has('gina.vim') # {{{2
  nnoremap <Bslash>b <Cmd>Gina branch -av<CR>
  nnoremap <Bslash>c <Cmd>Gina compare<CR>
  nnoremap <Bslash>d <Cmd>Gina diff<CR>
  nnoremap <Bslash>l <Cmd>Gina log --graph --all<CR>
  nnoremap <Bslash>s <Cmd>Gina status<CR>

  gina#custom#mapping#map(
    'status', 'i',
    '<Plug>(gina-index-stage)',
    {nowait: 1}
  )
  gina#custom#mapping#map(
    'status', 'o',
    '<Plug>(gina-index-unstage)',
    {nowait: 1}
  )
  gina#custom#mapping#nmap(
    'log', 'rr',
    '<Cmd>call my#gina#rebase_interactive()<CR>',
    {noremap: 1},
  )
  gina#custom#action#shorten(
    'branch',
    'commit'
  )
  gina#custom#command#option(
    'status',
    '-b|--branch'
  )
  gina#custom#command#option(
    'status',
    '-s|--short'
  )

  augroup my-gina
    autocmd!
    autocmd FileType gina-log setlocal number signcolumn=no cursorline
  augroup END
endif

if Has('junkfile.vim') # {{{2
  g:junkfile#directory = isdirectory(expand('~/Dropbox'))
                        ? expand('~/Dropbox/junkfile')
                        : expand('~/junkfile')
endif

if Has('memolist.vim') # {{{2
  g:memolist_path = isdirectory(expand('~/Dropbox'))
                   ? expand('~/Dropbox/memolist')
                   : expand('~/memolist')
  g:memolist_memo_suffix = 'md'
  g:memolist_template_dir_path = expand('~/.vim/template/memolist')
endif

if Has('open-browser.vim') # {{{2
  g:netrw_nogx = true
  nmap gx <Plug>(openbrowser-smart-search)
  xmap gx <Plug>(openbrowser-smart-search)
endif

if Has('vim-asterisk') # {{{2
  nmap * <Plug>(asterisk-z*)
  xmap * <Plug>(asterisk-z*)
  nmap g* <Plug>(asterisk-gz*)
  xmap g* <Plug>(asterisk-gz*)
endif

if Has('vim-better-whitespace') # {{{2
  g:strip_whitespace_on_save = true
  g:better_whitespace_ctermcolor = 'NONE'
  g:better_whitespace_guicolor   = 'NONE'
endif

if Has('vim-easy-align') # {{{2
  nmap g= <Plug>(EasyAlign)
  xmap g= <Plug>(EasyAlign)
endif

if Has('vim-gitgutter') # {{{2
  g:gitgutter_sign_priority = 10
  g:gitgutter_map_keys = false
  nnoremap H <Nop>
  xnoremap H <Nop>
  nmap Hp <Plug>(GitGutterPreviewHunk)
  nmap Hs <Plug>(GitGutterStageHunk)
  xmap Hs <Plug>(GitGutterStageHunk)
  nmap Hu <Plug>(GitGutterUndoHunk)
  nmap [h <Plug>(GitGutterPrevHunk)
  nmap ]h <Plug>(GitGutterNextHunk)
endif

if Has('vim-highlightedyank') # {{{2
  g:highlightedyank_highlight_duration = 500
endif

if Has('vim-histcase') # {{{2
  cmap <Up>     <Plug>(histcase-Up)
  cmap <Down>   <Plug>(histcase-Down)
  cmap <S-Up>   <Plug>(histcase-S-Up)
  cmap <S-Down> <Plug>(histcase-S-Down)
  cmap <C-p>    <Plug>(histcase-C-p)
  cmap <C-n>    <Plug>(histcase-C-n)
endif

if Has('vim-ipos') # {{{2
  g:ipos#mark = 'i'
  nnoremap t <Nop>
  # ti <-> gi
  nmap ti <Plug>(ipos-startinsert)
endif 

if Has('vim-lsp') # {{{2
  g:lsp_diagnostics_echo_cursor            = true
  g:lsp_document_code_action_signs_enabled = false
  g:lsp_document_highlight_enabled         = false
  g:lsp_completion_documentation_enabled   = false
  g:lsp_signs_priority = 20
  g:lsp_diagnostics_signs_error         = {text: 'E'}
  g:lsp_diagnostics_signs_warning       = {text: 'W'}
  g:lsp_diagnostics_signs_information   = {text: 'I'}
  g:lsp_diagnostics_signs_hint          = {text: 'H'}
  g:lsp_document_code_action_signs_hint = {text: 'A'}

  augroup my-lsp
    autocmd!
    autocmd User lsp_buffer_enabled my#lsp#on_lsp_buffer_enabled()
    autocmd User lsp_float_opened my#lsp#on_lsp_float_opened()
  augroup END
endif

if Has('vim-operator-replace') # {{{2
  nmap _ <Plug>(operator-replace)
  xmap _ <Plug>(operator-replace)
endif

if Has('vim-quickrun') # {{{2
  g:quickrun_config = {}
  g:quickrun_config['_'] = {
    'runner': 'job',
    'outputter/buffer/split': 'botright 12',
  }
  g:quickrun_config['go/test'] = {
    'command': 'go',
    'exec': '%c test .',
    'hook/cd/directory': '%S:p:h',
    'hook/output_encode/encoding': 'utf-8',
    'tempfile': '%{tempname()}.go',
  }
  nmap Q <Plug>(quickrun)
  augroup my-quickrun
    autocmd!
    autocmd FileType quickrun setlocal nonumber signcolumn=no
    autocmd BufReadPost,BufNewFile *_test.go b:quickrun_config = {type: 'go/test'}
  augroup END
endif

if Has('vim-ref') # {{{2
  g:ref_man_cmd = 'man -P cat'
  augroup my-vim-ref
    autocmd!
    autocmd FileType ref setlocal nolist signcolumn=no
  augroup END
endif

if Has('vim-sandwich') # {{{2
  nnoremap s <Nop>
  xnoremap s <Nop>
endif

if Has('vim-swap') # {{{2
  g:swap_no_default_key_mappings = true
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
  g:swap#keymappings = {
    "1": ['1', 'fix_nr'],
    "2": ['2', 'fix_nr'],
    "3": ['3', 'fix_nr'],
    "4": ['4', 'fix_nr'],
    "5": ['5', 'fix_nr'],
    "6": ['6', 'fix_nr'],
    "7": ['7', 'fix_nr'],
    "8": ['8', 'fix_nr'],
    "9": ['9', 'fix_nr'],
    "u": ['undo'],
    "\<C-r>": ['redo'],
    "p": ['swap_prev'],
    "n": ['swap_next'],
    "\<C-p>": ['move_prev'],
    "\<C-n>": ['move_next'],
    "s": ['sort'],
    "S": ['SORT'],
    "g": ['group'],
    "G": ['ungroup'],
    "r": ['reverse'],
    "\<Esc>": ['Esc'],
  }
endif

if Has('vim-textobj-comment') # {{{2
  g:textobj_comment_no_default_key_mappings = true
  omap i/ <Plug>(textobj-comment-a)
  xmap i/ <Plug>(textobj-comment-a)
  omap a/ <Plug>(textobj-comment-big-a)
  xmap a/ <Plug>(textobj-comment-big-a)
endif

if Has('voyager.vim') # {{{2
  g:voyager_keepalt = true
  augroup my-voyager
    autocmd!
    autocmd FileType voyager setlocal cursorline signcolumn=no statusline=%!my#statusline#get('Voyager')
  augroup END
endif

# Color scheme {{{1
augroup my-colorscheme
  autocmd!
  autocmd ColorScheme iceberg,slate source ~/.vim/colorscheme/<amatch>.vim
augroup END

if $COLORTERM == 'truecolor' || $COLORTERM == '24bit'
  set termguicolors
endif

if Has('iceberg.vim')
  colorscheme iceberg
else
  colorscheme slate
endif

# Local settings {{{1
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
