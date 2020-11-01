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
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
  Plug 'glidenote/memolist.vim'          " Create and manage memo
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
  Plug 'tyru/caw.vim'                    " Comment out
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
set completeopt=menuone,noinsert,noselect
set hidden
set splitbelow
set splitright
set ttimeoutlen=50
" }}}

" Color scheme {{{
function! s:OverrideHiColors() abort
  if g:colors_name == 'iceberg' && &background == 'dark'
    hi GitGutterChangeDelete cterm=bold
    hi GitGutterDelete       cterm=bold
    hi GitGutterAdd    cterm=bold guifg=#a5b368
    hi GitGutterChange cterm=bold guifg=#728dbb
    hi Delimiter    ctermfg=250 guifg=fg
    hi Directory    ctermfg=110 guifg=#84a0c6
    hi EndOfBuffer  ctermfg=239 guifg=#444b71
    hi Normal       ctermfg=250 guifg=#aaadbb
    hi netrwExe     ctermfg=234 guifg=#e27878
    hi netrwSymlink ctermfg=140 guifg=#a093c7
    hi CursorLineNr   ctermfg=251 ctermbg=235 guifg=#aab1d4 guibg=#1e2132
    hi HitsPopPopup   ctermfg=250 ctermbg=236 guifg=#aaadbb guibg=#272c42
    hi LspErrorText   ctermfg=203 ctermbg=235 guifg=#e27878 guibg=#1e2132
    hi LspHintText    ctermfg=150 ctermbg=235 guifg=#b4be82 guibg=#1e2132
    hi LspWarningText ctermfg=216 ctermbg=235 guifg=#e2a478 guibg=#1e2132
    hi Search         ctermfg=252 ctermbg=95  guifg=#ebc3ad guibg=#5e4a40
    hi IncSearch    cterm=NONE ctermfg=234 ctermbg=216 gui=NONE guifg=#392313 guibg=#e4aa80
    hi StatusLine   cterm=NONE ctermfg=249 ctermbg=236 gui=NONE guifg=#9ca0b0 guibg=#272c42
    hi StatusLineNC cterm=NONE ctermfg=238 ctermbg=233 gui=NONE guifg=#3e445e guibg=#0f1117
    hi User1     term=reverse ctermfg=216 ctermbg=236  guifg=#e2a478 guibg=#272c42
    hi VertSplit term=NONE    ctermfg=234 ctermbg=NONE guifg=bg      guibg=NONE
    hi! link StatusLineTerm StatusLine
    hi! link netrwClassify  netrwPlain
    hi! link netrwLink      netrwPlain
    hi! link netrwTreeBar   netrwPlain
  else
    hi! link User1 StatusLine
  endif
endfunction

" Misc {{{
function! s:SwitchTermColors() abort
  if index(['iceberg'], g:colors_name) != -1
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
" }}}

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

nnoremap <silent> - :<C-u>call <SID>ExploreHead()<CR>

function! s:ExploreHead() abort
  let l:dir = expand('%:h')
  if !isdirectory(l:dir)
    return
  endif
  exe 'edit' l:dir
endfunction
" }}}

" Visual {{{
" }}}

" Insert {{{
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
" }}}

" Command {{{
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
" }}}
" }}}

" Commands {{{
command! -nargs=1 -complete=command Redir call s:Redir(<f-args>)

function! s:Redir(cmd) abort
  if a:cmd =~ '^!'
    return
  endif
  redir => l:output
  try
    silent execute a:cmd
  catch /^Vim\%((\a\+)\)\=:E/
    echomsg substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
  endtry
  redir END
  tabnew
  setlocal nobuflisted noswapfile bufhidden=wipe buftype=nofile
  call setline(1, split(l:output, "\n"))
  1put! = repeat('-', 1 + strlen(a:cmd) + 1)
  2put! = ':' . a:cmd
  3put! = repeat('-', 1 + strlen(a:cmd) + 1)
endfunction
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

call s:Alias('gina', 'Gina')
call s:Alias('hc', 'helpc')
call s:Alias('redir', 'Redir')
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
" CtrlP {{{
if s:IsPlugged('ctrlp.vim')
  let g:ctrlp_show_hidden = 1
  if s:IsPlugged('ctrlp_matchfuzzy.vim')
    let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
  endif
endif
" }}}

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
  let g:gitgutter_sign_priority = 10
  let g:gitgutter_sign_added              = '┃'
  let g:gitgutter_sign_modified           = '┃'
  let g:gitgutter_sign_removed            = '_'
  let g:gitgutter_sign_removed_first_line = '‾'
  let g:gitgutter_sign_removed_above_and_below = '_¯'
  let g:gitgutter_sign_modified_removed   = '┃_'

  nnoremap <silent> ]c :<C-u>call <SID>gitgutter_next_hunk_with_echo(v:count1)<CR>
  nnoremap <silent> [c :<C-u>call <SID>gitgutter_prev_hunk_with_echo(v:count1)<CR>

  " functions {{{
  function! s:gitgutter_next_hunk_with_echo(count) abort
    let bufnr = bufnr('')
    if !gitgutter#utility#is_active(bufnr) | return | endif

    let hunks = gitgutter#hunk#hunks(bufnr)
    if empty(hunks)
      call gitgutter#utility#warn('No hunks in file')
      return
    endif

    let current_line = line('.')
    let hunk_count = 0
    for hunk in hunks
      if hunk[2] > current_line
        let hunk_count += 1
        if hunk_count == a:count
          execute 'normal!' hunk[2] . 'Gzv'
          redraw | echo printf('(hunk %d of %d)', index(hunks, hunk) + 1, len(hunks))
          return
        endif
      endif
    endfor
    call gitgutter#utility#warn('No more hunks')
  endfunction

  function! s:gitgutter_prev_hunk_with_echo(count) abort
    let bufnr = bufnr('')
    if !gitgutter#utility#is_active(bufnr) | return | endif

    let hunks = gitgutter#hunk#hunks(bufnr)
    if empty(hunks)
      call gitgutter#utility#warn('No hunks in file')
      return
    endif

    let current_line = line('.')
    let hunk_count = 0
    for hunk in reverse(copy(hunks))
      if hunk[2] < current_line
        let hunk_count += 1
        if hunk_count == a:count
          let target = hunk[2] == 0 ? 1 : hunk[2]
          execute 'normal!' target . 'Gzv'
          redraw | echo printf('(hunk %d of %d)', index(hunks, hunk) + 1, len(hunks))
          return
        endif
      endif
    endfor
    call gitgutter#utility#warn('No previous hunks')
  endfunction
  " }}}
endif
" }}}

" highlightedyank {{{
if s:IsPlugged('vim-highlightedyank')
  let g:highlightedyank_highlight_duration = 500
  autocmd vimrc ColorScheme * hi! link HighlightedyankRegion Visual
  hi! link HighlightedyankRegion Visual
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
  endfunction

  autocmd vimrc User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

  " Don't know how to configure this using g:lsp_settings ;(
  augroup vimrc_lsp_filetype
    autocmd!
    autocmd FileType vim let b:asyncomplete_refresh_pattern = '\([bwtglsav]:\)\?\k*$'
  augroup END
endif
" }}}

" memolist {{{
if s:IsPlugged('memolist.vim')
  let g:memolist_path = isdirectory(expand('~/Dropbox/memolist'))
    \ ? expand('~/Dropbox/memolist')
    \ : expand('~/memolist')
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = expand('~/.vim/template/memolist')
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
    let l:fileinfo = []
    call add(l:fileinfo, shadeline#functions#fileformat())
    call add(l:fileinfo, shadeline#functions#fileencoding())
    call add(l:fileinfo, shadeline#functions#filetype())
    return join(l:fileinfo, ' | ')
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
      " E117: Unknown function
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
      " E117: Unknown function
      return ''
    endtry
  endfunction
  " }}}
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
" }}}

" Local settings {{{
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
" }}}
