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
  Plug 'cocopon/colorswatch.vim'         " Generate beautiful color swatch
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Inspects a link structure of hi-groups
  Plug 'cocopon/shadeline.vim'           " Minimal status line
  Plug 'junegunn/vim-plug'               " Plugin manager
  Plug 'lambdalisue/gina.vim'            " Git on Vim
  Plug 'machakann/vim-highlightedyank'   " Highlight the yanked text
  Plug 'mattn/vim-sonictemplate'         " Easy and high speed coding method
  Plug 'mattn/vim-molder'                " Minimal file explorer
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
  Plug 'tpope/vim-repeat'                " Repeat some plugin commands by dot
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
  if !has_key(g:plugs, a:name) | return 0 | endif
  return isdirectory(g:plugs[a:name].dir)
endfunction
" }}}

" Options {{{
" Appearance
set background=dark
set cursorline
set cursorlineopt=number
set display=lastline
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set number
set numberwidth=1
set shortmess& shortmess-=S
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
let &showbreak = '+ '
set autoindent
set breakindent
set breakindentopt=min:20,shift:-2
set expandtab
set linebreak
set shiftwidth=0
set softtabstop=-1
set tabstop=2

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
set hidden
set splitbelow
set splitright
set ttimeoutlen=50
" }}}

" Color scheme {{{
function! s:OverrideHiColors() abort
  if g:colors_name == 'iceberg' && &background == 'dark'
    hi Delimiter    ctermfg=250 guifg=#aaadbb
    hi Directory    ctermfg=110 guifg=#84a0c6
    hi EndOfBuffer  ctermfg=239 guifg=#444b71
    hi Normal       ctermfg=250 guifg=#aaadbb
    hi netrwExe     ctermfg=234 guifg=#e27878
    hi netrwSymlink ctermfg=140 guifg=#a093c7
    hi CursorLineNr ctermfg=251 ctermbg=235 guifg=#aab1d4 guibg=#1e2132
    hi Search       ctermfg=217 ctermbg=95  guifg=#ffc29a guibg=#64564e
    hi IncSearch  cterm=bold ctermfg=52  ctermbg=168 gui=NONE guifg=#392313 guibg=#e4aa80
    hi StatusLine cterm=NONE ctermfg=248 ctermbg=236 gui=NONE guifg=#9198b6 guibg=#272c42
    hi VertSplit term=NONE ctermfg=234 ctermbg=NONE guifg=#161821 guibg=NONE
    hi! link StatusLineTerm StatusLine
    hi! link netrwClassify  netrwPlain
    hi! link netrwLink      netrwPlain
    hi! link netrwTreeBar   netrwPlain
  endif
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

autocmd vimrc ColorScheme *
  \ call s:OverrideHiColors()
  \|call s:SwitchTermColors()

if s:IsPlugged('iceberg.vim')
  colorscheme iceberg
else
  colorscheme default
end
" }}}

" Key mappings {{{
" Normal {{{
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap Y y$

nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

nnoremap <silent> [b :<C-u>bprevious<CR>
nnoremap <silent> ]b :<C-u>bnext<CR>
nnoremap <silent> [q :<C-u>cprevious<CR>
nnoremap <silent> ]q :<C-u>cnext<CR>
" }}}

" Visual {{{
" }}}

" Command {{{
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
" }}}
" }}}

" Commands {{{
command! -nargs=? -complete=help H vertical help <args>
command! -nargs=1 Helpg vertical helpgrep <args>

command! Deco
  \ setlocal list
  \|setlocal number
  \|setlocal signcolumn=yes

command! NoDeco
  \ setlocal nolist
  \|setlocal nonumber
  \|setlocal signcolumn=no
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
  autocmd FileType vim         setlocal foldmethod=marker
augroup END
" }}}

" Plugin settings {{{
" better-whitespace {{{
if s:IsPlugged('vim-better-whitespace')
  let g:better_whitespace_ctermcolor = 'NONE'
  let g:better_whitespace_guicolor = 'NONE'
  let g:strip_whitespace_on_save = 1
  nnoremap <silent> [w :<C-u>PrevTrailingWhitespace<CR>
  nnoremap <silent> ]w :<C-u>NextTrailingWhitespace<CR>
endif
" }}}

" gitgutter {{{
if s:IsPlugged('vim-gitgutter')
  set updatetime=100
endif
" }}}

" highlightedyank {{{
if s:IsPlugged('vim-highlightedyank')
  let g:highlightedyank_highlight_duration = 500
  autocmd vimrc ColorScheme * hi! link HighlightedyankRegion Visual
  hi! link HighlightedyankRegion Visual
endif
" }}}

" molder {{{
if s:IsPlugged('vim-molder')
  let g:molder_show_hidden = 1

  let g:loaded_netrw = 1
  let g:loaded_netrwFileHandlers = 1
  let g:loaded_netrwPlugin = 1
  let g:loaded_netrwSettings = 1
endif
" }}}

" shadeline {{{
if s:IsPlugged('shadeline.vim')
  let g:shadeline = {}
  let g:shadeline.active = {
    \ 'left': ['ShadelineItemGitGutterSign', 'fname', 'flags', 'ShadelineItemGitBranch'],
    \ 'right': ['<', ['ff', 'fenc', 'ft'], 'ruler']
    \ }
  let g:shadeline.inactive = {
    \ 'left': ['fname', 'flags']
    \ }

  function! g:ShadelineItemGitGutterSign() abort
    try
      let [a, m, r] = GitGutterGetHunkSummary()
      return a + m + r == 0 ? ' ' : '*'
    catch /:E117:/
      " E117: Unknown function
      return ' '
    endtry
  endfunction

  function! g:ShadelineItemGitBranch() abort
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
