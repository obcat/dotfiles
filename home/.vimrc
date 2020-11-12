"        _
"  _  __(_)_ _  ________
" | |/ / /  ' \/ __/ __/
" |___/_/_/_/_/_/  \__/

" Presettings {{{
set encoding=utf-8
scriptencoding utf-8
augroup vimrc | autocmd! | augroup END
" }}}

" Plugins {{{
if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'          " Git diff on the sign column
  Plug 'andymass/vim-matchup'            " Modern matching words
  Plug 'cocopon/colorswatch.vim'         " Generate beautiful color swatch
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Inspects a link structure of hi-groups
  Plug 'cocopon/shadeline.vim'           " Minimal status line
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
  Plug 'ghifarit53/tokyonight-vim'       " Color scheme
  Plug 'glidenote/memolist.vim'          " Create and manage memo
  Plug 'haya14busa/vim-asterisk'         " Provides improved * motion
  Plug 'hrsh7th/vim-vsnip'               " VSCode Snippet like plugin
  Plug 'hrsh7th/vim-vsnip-integ'         " vsnip integrations
  Plug 'junegunn/vim-plug'               " Plugin manager
  Plug 'lambdalisue/gina.vim'            " Git on Vim
  Plug 'machakann/vim-highlightedyank'   " Highlight the yanked text
  Plug 'machakann/vim-sandwich'          " Handle the sandwiched text easily
  Plug 'mattn/ctrlp-matchfuzzy'          " Fast CtrlP matcher
  Plug 'mattn/vim-lsp-settings'          " Auto configurations for vim-lsp
  Plug 'mattn/vim-molder'                " Minimal file explorer
  Plug 'mattn/vim-sonictemplate'         " Easy and high speed coding method
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
  Plug 'obcat/tlr.vim'                   " Tmux-like window Resizer
  Plug 'prabirshrestha/asyncomplete-lsp.vim' " LSP source for asyncomplete.vim and vim-lsp
  Plug 'prabirshrestha/asyncomplete.vim' " Async autocompletion
  Plug 'prabirshrestha/vim-lsp'          " Language Server Protocol
  Plug 'previm/previm'                   " Realtime markdown preview
  Plug 'tpope/vim-repeat'                " Repeat some plugin commands by dot
  Plug 'tyru/capture.vim'                " Show Ex command output in a buffer
  Plug 'tyru/caw.vim'                    " Comment out
  Plug 'tyru/open-browser-github.vim'    " Opens GitHub URL of current file
  Plug 'tyru/open-browser.vim'           " Open URL with browser
  Plug 'vim-jp/vimdoc-ja'                " Japanese help
  call plug#end()
else
  autocmd vimrc VimEnter *
    \ echohl Todo
    \|echomsg 'Plugins are not installed yet. See README.md.'
    \|echohl None

  function! g:PluginManagerInstall() abort
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endfunction
endif

filetype plugin on

" Check if a plugin exists
function! s:IsPlugged(name) abort
  return exists(printf("g:plugs['%s'].dir", a:name))
    \ ? isdirectory(g:plugs[a:name].dir)
    \ : 0
endfunction
" }}}

" Options {{{
" Appearance
set background=dark
set cmdheight=2
set cursorline
set cursorlineopt=number
set display=lastline
set fillchars=vert:│,fold:-
set foldlevel=99
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set number
set numberwidth=1
set shortmess& shortmess+=mrI
set showcmd
set signcolumn=yes
set wildmenu
syntax enable

" Completion
set completeopt=menuone,noinsert,noselect
set pumheight=8

" Cursor
if has('vim_starting')
  let &t_EI .= "\e[1 q"
  let &t_SI .= "\e[5 q"
  let &t_SR .= "\e[3 q"
endif

" Editing
set backspace=indent,eol,start
set formatoptions& formatoptions+=j
set virtualedit=block

" Indent
filetype indent on
set autoindent
set breakindent
set breakindentopt=min:20,shift:-2
set expandtab
set linebreak
set shiftwidth=0
set softtabstop=-1
set tabstop=2
let &showbreak = '+ '
let g:vim_indent_cont = &tabstop

" Scroll
set sidescroll=1
set scrolloff=7

" Search
if v:hlsearch == 0
  set hlsearch
  nohlsearch
endif
set ignorecase
set incsearch
set smartcase

" Language
set helplang=ja
set spelllang=en,cjk
if exists('+spelloptions')
  set spelloptions=camel
endif

" Backup
let s:swapdir = expand('~/.vim/swap')
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir
set history=10000

" Misc
set belloff=all
set clipboard=unnamed
set hidden
set mouse=a
set splitbelow
set splitright
set ttimeoutlen=50
" }}}

" Color scheme {{{
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1

function! s:OverrideHiColors(name, bg) abort
  let l:dir = expand('~/.vim/highlight')
  let l:file = printf('%s/%s/%s.vim', l:dir, a:name, a:bg)
  if filereadable(l:file)
    exe 'source' l:file
  else
    exe 'source' l:dir . '/others.vim'
  endif
  exe 'source' l:dir . '/common.vim'
endfunction

autocmd vimrc ColorScheme *
  \ call s:OverrideHiColors(expand('<amatch>'), &background)

if s:IsPlugged('iceberg.vim')
  colorscheme iceberg
else
  colorscheme slate
endif

if $COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit'
  set termguicolors
endif
" }}}

" Key mappings {{{
let g:mapleader = "\<Space>"
map <Space> <Nop>

" Normal {{{
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap Y y$

nnoremap <silent> <Leader>l :<C-u>let v:hlsearch = !v:hlsearch<CR>

nnoremap <silent> [b :<C-u>bprevious<CR>
nnoremap <silent> ]b :<C-u>bnext<CR>
nnoremap <silent> [q :<C-u>cprevious<CR>
nnoremap <silent> ]q :<C-u>cnext<CR>

nnoremap <silent> - :<C-u>call <SID>ExploreHead()<CR>

function! s:ExploreHead() abort
  let l:dir = expand('%:h')
  if !isdirectory(l:dir)
    return
  endif
  exe 'edit' l:dir
endfunction
" }}}

" Insert {{{
inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>
inoremap <expr> <C-a> <SID>i_ctrl_a()
inoremap <expr> <C-e> <SID>i_ctrl_e()
inoremap <C-d> <Del>

inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

function! s:i_ctrl_a() abort
  let l:chars = getline('.')
  let l:ind_len  = strchars(matchstr(l:chars, '^\s*'))
  let l:pres_len = strchars(strpart(l:chars, 0, col('.') - 1))
  if  l:ind_len < l:pres_len
    return repeat("\<C-g>U\<Left>", l:pres_len - l:ind_len)
  else
    return repeat("\<C-g>U\<Left>", l:pres_len)
  endif
endfunction

function! s:i_ctrl_e() abort
  return repeat("\<C-g>U\<Right>", strchars(strpart(getline('.'), col('.') - 1)))
endfunction
" }}}

" Command line {{{
cnoremap <C-b> <Left>
cnoremap <expr> <C-f> <SID>c_ctrl_f()
cnoremap <C-a> <Home>
cnoremap <expr> <C-d> <SID>c_ctrl_d()

cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

function! s:c_ctrl_f() abort
  if getcmdpos() - 1 < strlen(getcmdline())
    return "\<Right>"
  else
    return &cedit
  endif
endfunction

function! s:c_ctrl_d() abort
  if getcmdpos() - 1 < strlen(getcmdline())
    return "\<Del>"
  else
    return "\<C-d>"
  endif
endfunction
" }}}
" }}}

" Aliases {{{
" Alias() {{{
function! s:Alias(key, val) abort
  exe printf(
    \ 'cnoreabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() == %d) ? %s : %s',
    \ a:key, 1 + len(a:key), string(a:val), string(a:key)
    \ )
endfunction
" }}}

call s:Alias('cap', 'Capture')
call s:Alias('gina', 'Gina')
call s:Alias('hc', 'helpc')
" }}}

" File types {{{
augroup vimrc_filetype
  autocmd!
  autocmd FileType gina-commit setlocal spell
  autocmd FileType gitcommit   setlocal spell
  autocmd FileType gitconfig   setlocal noexpandtab
  autocmd FileType help        nnoremap <buffer> q <C-w>c
  autocmd FileType molder      setlocal nonumber
  autocmd FileType qf          nnoremap <buffer> q <C-w>c
  autocmd FileType qf          setlocal nowrap
  autocmd FileType vim         setlocal foldmethod=marker
augroup END
" }}}

" Plugin settings {{{
" asterisk {{{
if s:IsPlugged('vim-asterisk')
  map *  <Plug>(asterisk-z*)
  map g* <Plug>(asterisk-gz*)
endif
" }}}

" better-whitespace {{{
if s:IsPlugged('vim-better-whitespace')
  let g:strip_whitespace_on_save = 1
  let g:better_whitespace_ctermcolor = 'NONE'
  let g:better_whitespace_guicolor   = 'NONE'
  nnoremap <silent> [w :<C-u>PrevTrailingWhitespace<CR>
  nnoremap <silent> ]w :<C-u>NextTrailingWhitespace<CR>
endif
" }}}

" CtrlP {{{
if s:IsPlugged('ctrlp.vim')
  let g:ctrlp_show_hidden = 1
  if s:IsPlugged('ctrlp_matchfuzzy.vim')
    let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
  endif
endif
" }}}

" gitgutter {{{
if s:IsPlugged('vim-gitgutter')
  set updatetime=100
  let g:gitgutter_sign_priority = 10
  let g:gitgutter_sign_added              = '┃'
  let g:gitgutter_sign_modified           = '┃'
  let g:gitgutter_sign_removed            = '_'
  let g:gitgutter_sign_removed_first_line = '‾'
  let g:gitgutter_sign_removed_above_and_below = '_¯'
  let g:gitgutter_sign_modified_removed   = '┃_'
endif
" }}}

" highlightedyank {{{
if s:IsPlugged('vim-highlightedyank')
  let g:highlightedyank_highlight_duration = 500
endif
" }}}

" lsp {{{
if s:IsPlugged('vim-lsp')
  \ && s:IsPlugged('asyncomplete.vim')
  \ && s:IsPlugged('asyncomplete-lsp.vim')
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_signs_priority = 20
  let g:asyncomplete_auto_completeopt = 0

  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gr <Plug>(lsp-references)
  endfunction

  autocmd vimrc User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  autocmd vimrc User lsp_float_opened
    \ call popup_setoptions(lsp#ui#vim#output#getpreviewwinid(), #{
    \   padding: [0, 1, 0, 1],
    \   maxheight: 16,
    \   highlight: 'LspPreviewPopup',
    \ })
endif
" }}}

" matchup {{{
if s:IsPlugged('vim-matchup')
  let g:matchup_matchparen_offscreen = #{
    \ method:    'popup',
    \ highlight: 'MatchUpOffScreenPopup',
    \ }
endif
" }}}

" memolist {{{
if s:IsPlugged('memolist.vim')
  " NOTE: memolist creates directories if needed
  let g:memolist_path = isdirectory(expand('~/Dropbox'))
    \ ? expand('~/Dropbox/memolist')
    \ : expand('~/memolist')
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = expand('~/.vim/template/memolist')
endif
" }}}

" molder {{{
if s:IsPlugged('vim-molder')
  let g:molder_show_hidden = 1
  let g:loaded_netrw             = 1
  let g:loaded_netrwFileHandlers = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
endif
" }}}

" open browser {{{
if s:IsPlugged('open-browser.vim')
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif
" }}}

" sandwich {{{
if s:IsPlugged('vim-sandwich')
  " NOTE: s can be replaced by cl or xi
  nmap s <Nop>
  xmap s <Nop>
endif
" }}}

" shadeline {{{
if s:IsPlugged('shadeline.vim')
  let g:shadeline = #{active: {}, inactive: {}}
  let g:shadeline.active.left = [
    \ '%1*%{ShadelineItemGitGutterSign()}%*',
    \ 'fname',
    \ 'flags',
    \ 'ShadelineItemGitBranch'
    \ ]
  let g:shadeline.active.right = [
    \ '<',
    \ 'ShadelineItemFileInfoOrSearchCount',
    \ '%3p%%:%-2c'
    \ ]
  let g:shadeline.inactive.left = ['fname', 'flags']

  " FileInfoOrSearchCount {{{
  function! g:ShadelineItemFileInfoOrSearchCount() abort
    if v:hlsearch == 0
      return s:ShadelineUtilGetFileInfo()
    else
      return s:ShadelineUtilGetSearchCount()
    endif
  endfunction

  function! s:ShadelineUtilGetFileInfo() abort
    return shadeline#functions#fileformat()
      \ . ' | ' . shadeline#functions#fileencoding()
      \ . ' | ' . shadeline#functions#filetype()
  endfunction

  function! s:ShadelineUtilGetSearchCount() abort
    let l:result = searchcount(#{maxcount: 0, timeout: 30})
    if empty(l:result) | return '' | endif
    if l:result.incomplete == 1
      return printf('%s (?/??)', @/)
    endif
    return printf('%s (%d/%d)', @/, l:result.current, l:result.total)
  endfunction
  " }}}

  " GitGutterSign {{{
  function! g:ShadelineItemGitGutterSign() abort
    try
      let [l:a, l:m, l:r] = GitGutterGetHunkSummary()
      return l:a + l:m + l:r == 0 ? ' ' : '*'
    catch /:E117:/
      return ' '
    endtry
  endfunction
  " }}}

  " GitBranch {{{
  function! g:ShadelineItemGitBranch() abort
    try
      let l:name = gina#component#repo#branch()
      return empty(l:name) ? '' : printf('(%s)', l:name)
    catch /:E117:/
      return ''
    endtry
  endfunction
  " }}}
endif
" }}}

" sonictemplate {{{
if s:IsPlugged('vim-sonictemplate')
  let g:loaded_sonictemplate_vim = 1  " Disable default key mappings
  let g:sonictemplate_vim_template_dir = expand('~/.vim/template/sonictemplate')
  let g:sonictemplate_maintainer = 'obcat <obcat@icloud.com>'
  let g:sonictemplate_license    = 'MIT License'

  command! -nargs=1 -complete=customlist,sonictemplate#complete
    \ Template call sonictemplate#apply(<f-args>, 'n')
endif
" }}}

" tlr {{{
if s:IsPlugged('tlr.vim')
  let g:tlr_num_of_cells_for_res = 2
  nmap <C-Down>  <Plug>(tlr-down)
  nmap <C-Up>    <Plug>(tlr-up)
  nmap <C-Left>  <Plug>(tlr-left)
  nmap <C-Right> <Plug>(tlr-right)
endif
" }}}

" vsnip {{{
if s:IsPlugged('vim-vsnip')
  let g:vsnip_snippet_dir = expand('~/.vim/snippet/vsnip')
  imap <expr> <C-i> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-i>'
  smap <expr> <C-i> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-i>'
endif
" }}}
" }}}

" Local settings {{{
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
" }}}
