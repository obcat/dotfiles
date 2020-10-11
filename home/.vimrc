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
  Plug 'airblade/vim-gitgutter'          " Git diff on the sign column
  Plug 'cocopon/colorswatch.vim'         " Generate beautiful color swatch
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Inspects a link structure of hi-groups
  Plug 'cocopon/shadeline.vim'           " Minimal status line
  Plug 'junegunn/vim-plug'               " Plugin manager
  Plug 'lambdalisue/gina.vim'            " Git on Vim
  Plug 'machakann/vim-highlightedyank'   " Highlight the yanked text
  Plug 'mattn/vim-sonictemplate'         " Easy and high speed coding method
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
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
function! s:IsInstalled(plugin) abort
  return !empty(glob('~/.vim/plugged/' . a:plugin))
endfunction
" }}}

" Options {{{
" Appearance
set ambiwidth=double
set background=dark
set cursorline
set cursorlineopt=number
set display=lastline
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set number
set numberwidth=1
set showcmd
set signcolumn=yes
set wildmenu
syntax enable

" Cursor
if has('vim_starting')
  let &t_EI .= "\e[1 q"
  let &t_SI .= "\e[5 q"
  let &t_SR .= "\e[3 q"
endif

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
set virtualedit=block

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
set spelloptions=camel

" Backup
let s:swapdir = expand('~/.vim/swap')
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir
set history=10000

" Misc
set belloff=all
set hidden
set ttimeoutlen=50
" }}}

" Color scheme {{{
function! s:OverrideColorScheme() abort
  if g:colors_name == 'iceberg' && &background == 'dark'
    hi CursorLineNr ctermfg=251 ctermbg=235 guifg=#aab1d4 guibg=#1e2132
    hi Delimiter ctermfg=250 guifg=#aaadbb
    hi Normal ctermfg=250 guifg=#aaadbb
    hi StatusLine ctermbg=232 guibg=#000000
    hi StatusLineTerm ctermbg=232 guibg=#000000
    hi link ExtraWhitespace ZenSpace
  endif

  hi link HighlightedyankRegion Visual
endfunction

function! s:SwitchTermColors() abort
  if g:colors_name == 'iceberg'
    call s:Use24bitColorsIfPossible()
  else
    set notermguicolors
  endif
endfunction

function! s:Use24bitColorsIfPossible() abort
  if $COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit'
    set termguicolors
  endif
endfunction

autocmd vimrc ColorScheme * call s:OverrideColorScheme()
                          \|call s:SwitchTermColors()

if s:IsInstalled('iceberg.vim')
  colorscheme iceberg
endif
" }}}

" Key mappings {{{
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
" }}}

" File types {{{
augroup vimrc_filetype
  autocmd!
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd FileType help      setlocal signcolumn=no
                           \|nnoremap <buffer> q <C-w>c
  autocmd FileType netrw     setlocal signcolumn=no
  autocmd FileType sh        setlocal tabstop=2
  autocmd FileType vim       setlocal tabstop=2 foldmethod=marker
  autocmd FileType zsh       setlocal tabstop=2
augroup END
" }}}

" Plugin settings {{{
" better-whitespace {{{
if s:IsInstalled('vim-better-whitespace')
  let g:strip_whitespace_on_save=1
endif
" }}}

" gitgutter {{{
if s:IsInstalled('vim-gitgutter')
  set updatetime=100
endif
" }}}

" highlightedyank {{{
if s:IsInstalled('vim-highlightedyank')
  let g:highlightedyank_highlight_duration = 500
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

" Local settings {{{
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
" }}}
