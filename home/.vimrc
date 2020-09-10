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
  call plug#begin()
  Plug 'airblade/vim-gitgutter'   " Git diff on the sign column
  Plug 'arcticicestudio/nord-vim' " Color scheme
  Plug 'cocopon/iceberg.vim'      " Color scheme
  Plug 'cocopon/shadeline.vim'    " Minimal status line
  Plug 'cocopon/pgmnt.vim'        " Template engine for color scheme
  Plug 'cocopon/inspecthi.vim'    " Inspects a link structure of hi-groups
  Plug 'cocopon/colorswatch.vim'  " Generate beautiful color swatch
  Plug 'junegunn/vim-plug'        " Plugin manager
  Plug 'lambdalisue/gina.vim'     " Git on Vim
  Plug 'vim-jp/vimdoc-ja'         " Japanese help
  call plug#end()
else
  echomsg 'Plugins are not installed yet. See README.md.'

  function! g:PluginManagerInstall() abort
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endfunction
endif

filetype plugin on

" Check if a plugin exists
function! s:IsInstalled(plugin) abort
  return !empty(glob('~/.vim/plugged/' . a:plugin))
endfunction
" }}}

" Options {{{
" Appearance
set ambiwidth=double
set background=dark
set cursorline
set display=lastline
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set number
set showcmd
set wildmenu
syntax on

" Indent
filetype indent on
set autoindent
set breakindent
set expandtab
set shiftwidth=0
set softtabstop=-1
set tabstop=4

" Edit
set backspace=indent,eol,start
set showmatch
set virtualedit=block

" Search
if v:hlsearch == 0
  set hlsearch
  nohlsearch
endif
set ignorecase
set incsearch
set smartcase

" Backup
let s:swapdir = expand('~/.vim/swap')
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir
set history=200

" Misc
set belloff=all
set helplang=ja
set hidden
set sidescroll=1
set ttimeoutlen=100
" }}}

" Color scheme {{{
function! s:OverrideColorScheme() abort
  if g:colors_name == 'iceberg' && &background == 'dark'
    hi CursorLineNr ctermfg=251 guifg=#aab1d4
    hi Delimiter ctermfg=250 guifg=#979aaa
    hi Normal ctermfg=250 guifg=#979aaa
  endif
endfunction

" Override after a color scheme is loaded
autocmd vimrc ColorScheme * call s:OverrideColorScheme()

if s:IsInstalled('iceberg.vim')
  colorscheme iceberg
endif

if $COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit'
  set termguicolors
endif
" }}}

" Key mappings {{{
" Traverse the command-line history with match of beginning
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Traverse Vim's list
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Stop the highlighting
nnoremap <silent> <C-l> :nohlsearch<CR>

" Don't use the BS key
map <BS> <Nop>
map! <BS> <Nop>
" }}}

" Plugin settings {{{
" gitgutter {{{
if s:IsInstalled('vim-gitgutter')
  set updatetime=100
endif
" }}}

" shadeline {{{
if s:IsInstalled('shadeline.vim')
  let g:shadeline = {}
  let g:shadeline.active = {
    \ 'left': ['fname', 'flags', 'ShadelineItemGitBranch'],
    \ 'right': ['<', ['ff', 'fenc', 'ft'], 'ruler']
    \ }
  let g:shadeline.inactive = {
    \ 'left': ['fname', 'flags']
    \ }

  function! ShadelineItemGitBranch() abort
    try
      let name = gina#component#repo#branch()
      return empty(name) ? '' : printf('(%s)', name)
    catch /:E117:/
      " E117: Unknown function
      return ''
    endtry
  endfunction
endif
" }}}
" }}}
