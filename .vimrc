"   __  __ _ _____ _________
"   \ \ | |_|     V  __/  __|
"    \ \| | | | | | |  | [__
" [_] \___|_|_|_|_|_|  \____|

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
  Plug 'junegunn/vim-plug'        " Plugin manager
  Plug 'lambdalisue/gina.vim'     " Git on Vim
  Plug 'vim-jp/vimdoc-ja'         " Japanese help
  call plug#end()
else
  echo 'Plugins are not installed yet. See README.md.'
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
set shiftround
set shiftwidth=4
set smarttab
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
set incsearch

" Backup
let s:swapdir = glob('~/.vim/swap')
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir
set history=200

" Misc
autocmd vimrc FileType vim setlocal foldmethod=marker
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
    hi Delimiter ctermfg=250 guifg=#aaadbb
    hi Normal ctermfg=250 guifg=#aaadbb
    hi Search guibg=#ddab88
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

" Move between the buffer list
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> ]b :bnext<CR>

" Move between the quickfix list
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]Q :clast<CR>
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
  \ 'right': ['<', ['ff', 'fenc', 'ft'], 'ruler'],
  \ }
  let g:shadeline.inactive = {
  \ 'left': ['fname', 'flags'],
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
