"        _
"  _  __(_)_ _  ________
" | |/ / /  ' \/ __/ __/
" |___/_/_/_/_/_/  \__/

" Presettings {{{
set encoding=utf-8
scriptencoding utf-8
" }}}

" Plugins {{{
if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'          " Git diff on the sign column
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Show link structure of highlight groups
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
  Plug 'glidenote/memolist.vim'          " Create and manage memo
  Plug 'glts/vim-textobj-comment'        " Textobjects for comments
  Plug 'haya14busa/vim-asterisk'         " Provides improved * motion
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
  Plug 'machakann/vim-swap'              " Reorder delimited items.
  Plug 'machakann/vim-textobj-delimited' " Textobjects for delimited parts of string
  Plug 'machakann/vim-textobj-functioncall' " Textobjects for function-call regions
  Plug 'mattn/ctrlp-matchfuzzy'          " Fast CtrlP matcher
  Plug 'mattn/vim-lsp-settings'          " Auto configurations for vim-lsp
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
  Plug 'obcat/tlr.vim'                   " Tmux-Like window Resizer
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
  function PluginManagerInstall() abort
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endfunction
endif

packadd! cfilter
packadd! matchit
filetype plugin on

function s:has(plug) abort
  let dir = printf('g:plugs[''%s''][''dir'']', a:plug)
  return exists(dir) ? isdirectory(eval(dir)) : 0
endfunction
" }}}

" Options {{{
" Appearance
set background=dark
set cmdheight=2
set display=lastline
set foldtext=foldtext#global()
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set nowrap
set number
set shortmess& shortmess+=a
set showtabline=2
set signcolumn=yes
set statusline=%!statusline#global()
set tabline=%!tabline#global()
set wildmenu
syntax enable

" Backup
let &directory = expand('~/.vim/swap')
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif
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
set virtualedit=block

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
if !v:hlsearch
  set hlsearch
  nohlsearch
endif
set ignorecase
set incsearch
set smartcase

" Misc
set belloff=all
set clipboard=unnamed
set diffopt& diffopt+=vertical
set hidden
set lazyredraw
set mouse=a
set nostartofline
set nrformats&
  \ nrformats-=octal
  \ nrformats+=unsigned
set report=0
set splitbelow
set splitright
set timeoutlen=5000
set ttimeoutlen=50
set updatetime=100
" }}}

" Key mappings {{{
let g:mapleader = "\<Space>"
noremap <Space> <Nop>
noremap -       <Nop>

" Normal {{{
" File
nnoremap # <C-^>
nnoremap <Leader>w <Cmd>silent update<CR>
nnoremap -. <Cmd>edit .<CR>
nnoremap -- <Cmd>call <SID>browse(expand('%:p:h'))<CR>
nnoremap -d <Cmd>call <SID>browse(expand('~/dotfiles/home'))<CR>
nnoremap -p <Cmd>call <SID>browse(expand('~/.vim/plugged'))<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Motion
nnoremap g: g;

" Scroll
nmap <C-u> <SID>(smooth-scroll-up)
nmap <C-d> <SID>(smooth-scroll-down)

" Change
nnoremap Y y$

" Script
nnoremap <Leader>s <Cmd>source % <Bar> echo 'sourced'<CR>

" Search
nnoremap <C-h> <Cmd>nohlsearch<CR>

" Window
nnoremap <Leader>q <C-w>c
nmap     <Leader>z <SID>(win-zoom)

" Tabpage
nnoremap H <Cmd>exe 'tabprevious' v:count1<CR>
nnoremap L <Cmd>exe 'tabnext' (tabpagenr() + v:count1 - 1) % tabpagenr('$') + 1<CR>
nnoremap Q <Cmd>exe 'tabclose' v:count ?? ''<CR>
nnoremap S <Cmd>exe v:count ?? '' 'tab split'<CR>

" QuickFix
nnoremap [q <Cmd>exe v:count1 'cprevious'<CR>
nnoremap ]q <Cmd>exe v:count1 'cnext'<CR>

" Terminal
nnoremap <Leader>t <Cmd>call <SID>run_shell()<CR>

" <SID>s
nnoremap <SID>(smooth-scroll-up)   <Cmd>call <SID>smooth_scroll(1)<CR>
nnoremap <SID>(smooth-scroll-down) <Cmd>call <SID>smooth_scroll(0)<CR>
nnoremap <SID>(win-zoom)           <Cmd>call <SID>toggle_win_zoom()<CR>

function s:browse(dir, opener = 'edit') abort
  if isdirectory(a:dir)
    exe a:opener fnameescape(a:dir)
  else
    echo a:dir 'is not directory'
  endif
endfunction

" Thank you aonemd
function s:smooth_scroll(up)
  let key = a:up ? "\<C-y>" : "\<C-e>"
  exe 'normal!' key
  redraw
  for i in range(1, winheight(0), 4)
    sleep 7m
    exe 'normal!' key
    redraw
  endfor
endfunction

" Thank you lambdalisue
function s:toggle_win_zoom() abort
  if exists('t:zoom_winrestcmd')
    exe t:zoom_winrestcmd
    unlet t:zoom_winrestcmd
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
  endif
endfunction

function s:run_shell() abort
  let file = expand('%:p')
  let wd = isdirectory(file) ? file : getcwd()
  call term_start(&shell, #{
    \ cwd: wd,
    \ term_finish: 'close',
    \ })
endfunction
" }}}

" Visual {{{
xnoremap <silent> . :normal! .<CR>
" }}}

" Insert {{{
inoremap <C-u> <C-g>u<C-u>
" }}}

" Command line {{{
if has('patch-8.2.2221')
  cnoremap <C-n> <Down>
else
  cnoremap <C-n> <Cmd>call feedkeys("\<lt>Down>", 'nt')<CR>
endif
cnoremap <C-p> <Up>
cnoremap <expr> <C-o> wildmenumode() ? '<Left>' : '<C-o>'
" }}}
" }}}

" User-defined commands {{{
command! -bang   Spell setlocal   spell<bang>
command! -bang NoSpell setlocal nospell<bang>
command! -bang    Wrap setlocal    wrap<bang>
command! -bang  NoWrap setlocal  nowrap<bang>
command! -bang   Conceal let &l:conceallevel = <bang>0 ? (&l:conceallevel ? 0 : 3) : 3
command! -bang NoConceal let &l:conceallevel = <bang>0 ? (&l:conceallevel ? 0 : 3) : 0
" }}}

" Abbreviations {{{
cnoreabbrev <expr> hc (getcmdtype() is# ':' && getcmdline() is# 'hc') ? 'helpclose' : 'hc'
" }}}

" Autocommands {{{
augroup my-terminalopen
  autocmd!
  autocmd TerminalOpen * call setbufvar(+expand('<abuf>'), '&filetype', 'terminal')
augroup END

augroup my-filetype
  autocmd!
  autocmd FileType *         setlocal formatoptions-=o formatoptions+=j
  autocmd FileType *commit*  setlocal spell
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd FileType terminal  setlocal nonumber signcolumn=no
  autocmd FileType help,qf,vim call <SID>on_filetype_{&filetype}()
augroup END

function s:on_filetype_help() abort
  setlocal conceallevel=0
  if !&modifiable
    nmap     <buffer> u <SID>(smooth-scroll-up)
    nmap     <buffer> d <SID>(smooth-scroll-down)
    nnoremap <buffer> C <Cmd>exe 'help' expand('<cword>') . '@en'<CR>
    nnoremap <buffer> J <Cmd>exe 'help' expand('<cword>') . '@ja'<CR>
  endif
endfunction

function s:on_filetype_qf() abort
  exe 'resize' min([line('$') + 2, 10])
  setlocal cursorline statusline=%!statusline#local('qf')
endfunction

function s:on_filetype_vim() abort
  setlocal foldmethod=marker
  " Experimental
  inoremap <buffer> <C-]> 💥<C-]>
  inoreabbrev <buffer> aug💥
    \ augroup <CR>
    \autocmd!<CR>
    \autocmd <CR>
    \augroup END
    \<Up><Up><Up><End>
  inoreabbrev <buffer> fu💥
    \ function  abort<CR>
    \endfunction
    \<Up><End><S-Left><Left>
  inoreabbrev <buffer> if💥
    \ if <CR>
    \endif
    \<Up><End>
endfunction

augroup my-restore-curpos
  autocmd!
  autocmd BufReadPost * call <SID>restore_curpos()
augroup END

function s:restore_curpos() abort
  if 1 <= line('''"') && line('''"') <= line('$') && &filetype !~# 'commit'
    exe 'normal! g`"'
  endif
endfunction

augroup my-vimresized
  autocmd!
  autocmd VimResized * wincmd =
augroup END
" }}}

" Plugin settings {{{
if s:has('caw.vim') "{{{
  let g:caw_no_default_keymappings = 1
  let g:caw_operator_keymappings   = 1
  nmap <Leader>k <Plug>(caw:hatpos:toggle:operator)
  vmap <Leader>k <Plug>(caw:hatpos:toggle)
endif "}}}

if s:has('capture.vim') "{{{
  command! -bang -count Messages exe 'Capture<bang>' <count> ?? '' 'messages'
endif "}}}

if s:has('ctrlp.vim') "{{{
  let g:ctrlp_line_prefix  = '▸ '
  let g:ctrlp_reuse_window = '\v.*'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
  let g:ctrlp_by_filename     = 1
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_show_hidden     = 1

  if s:has('ctrlp_matchfuzzy.vim')
    let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
  endif

  augroup my-ctrlp
    autocmd!
    autocmd VimEnter,VimResized * call s:ctrlp_set_options()
  augroup END

  function s:ctrlp_set_options() abort
    let half = &lines / 2
    let g:ctrlp_match_window = printf('order:ttb,min:%d,max:%d', half, half)
  endfunction

  let g:ctrlp_map = '<Leader>p'
  nnoremap <Leader>u <Cmd>CtrlPMRU<CR>
endif "}}}

if s:has('gina.vim') "{{{
  nnoremap <Bslash>. <Cmd>Gina cd<CR>
  nnoremap <Bslash>b <Cmd>Gina branch -av<CR>
  nnoremap <Bslash>c <Cmd>Gina compare<CR>
  nnoremap <Bslash>d <Cmd>Gina diff<CR>
  nnoremap <Bslash>l <Cmd>Gina log --graph --all<CR>
  nnoremap <Bslash>s <Cmd>Gina status<CR>
  nnoremap <Bslash>m <Cmd>call <SID>gina_main()<CR>
  command! Amend  Gina commit --amend
  command! Blame  Gina blame
  command! Commit Gina commit
  command! -nargs=* Stash Gina stash <args>

  function s:gina_main() abort
    tab split
    Gina status
    vertical rightbelow split
    Gina log --graph --all
    wincmd p
    belowright split
    Gina branch -av
    wincmd p
  endfunction

  call gina#custom#mapping#map(
   \ 'status', 'i',
   \ '<Plug>(gina-index-toggle)',
   \ {'nowait': 1}
   \ )
  call gina#custom#mapping#map(
   \ 'status', 'o',
   \ '<Plug>(gina-index-unstage)',
   \ {'nowait': 1}
   \ )
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
  nnoremap -m <Cmd>MemoList<CR>
endif "}}}

if s:has('open-browser.vim') "{{{
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif "}}}

if s:has('tlr.vim') "{{{
  let g:tlr_resize_steps = 8
  nmap <C-Down>  <Plug>(tlr-down)
  nmap <C-Up>    <Plug>(tlr-up)
  nmap <C-Left>  <Plug>(tlr-left)
  nmap <C-Right> <Plug>(tlr-right)
endif "}}}

if s:has('vim-asterisk') "{{{
  map *  <Plug>(asterisk-z*)
  map g* <Plug>(asterisk-gz*)
endif "}}}

if s:has('vim-better-whitespace') "{{{
  let g:strip_whitespace_on_save = 1
  let g:better_whitespace_ctermcolor = 'NONE'
  let g:better_whitespace_guicolor   = 'NONE'
endif "}}}

if s:has('vim-easy-align') "{{{
  nmap <Leader>= <Plug>(EasyAlign)
  xmap <Leader>= <Plug>(EasyAlign)
endif "}}}

if s:has('vim-gitgutter') "{{{
  let g:gitgutter_sign_priority = 10
endif "}}}

if s:has('vim-highlightedyank') "{{{
  let g:highlightedyank_highlight_duration = 500
endif "}}}

if s:has('vim-lsp') "{{{
  let g:lsp_diagnostics_echo_cursor    = 1
  let g:lsp_document_highlight_enabled = 0
  let g:lsp_signs_priority = 20
  let g:lsp_diagnostics_signs_error   = {'text': 'E'}
  let g:lsp_diagnostics_signs_warning = {'text': 'W'}
  let g:lsp_diagnostics_signs_hint    = {'text': 'H'}

  function s:on_lsp_buffer_enabled() abort
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gr <Plug>(lsp-references)
  endfunction

  function s:on_lsp_float_opened() abort
    let winid = lsp#ui#vim#output#getpreviewwinid()
    let lines = getbufline(winbufnr(winid), 1, '$')
    let maxwidth = max(map(lines, 'strwidth(v:val)'))
    call popup_setoptions(winid, #{
      \ maxheight: &lines / 3,
      \ minwidth: maxwidth,
      \ highlight: 'LspPreviewPopup',
      \ padding: [0, 1, 0, 1],
      \ borderhighlight: ['LspPreviewPopupBorder'],
      \ borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
      \ scrollbar: 0,
      \ })
  endfunction

  augroup my-lsp
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    autocmd User lsp_float_opened   call s:on_lsp_float_opened()
  augroup END
endif "}}}

if s:has('vim-operator-replace') "{{{
  map <Leader>r <Plug>(operator-replace)
endif "}}}

if s:has('vim-sandwich') "{{{
  " NOTE: s can be replaced by cl
  nmap s <Nop>
  xmap s <Nop>
endif "}}}

if s:has('vim-swap') "{{{
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
endif "}}}

if s:has('vim-textobj-comment') "{{{
  let g:textobj_comment_no_default_key_mappings = 1
  xmap ak <Plug>(textobj-comment-a)
  omap ak <Plug>(textobj-comment-a)
  xmap ik <Plug>(textobj-comment-i)
  omap ik <Plug>(textobj-comment-i)
  xmap aK <Plug>(textobj-comment-big-a)
  omap aK <Plug>(textobj-comment-big-a)
endif "}}}

if s:has('voyager.vim') "{{{
  let g:voyager_keepalt   = 1
  let g:loaded_netrw             = 1
  let g:loaded_netrwFileHandlers = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  augroup my-voyager
    autocmd!
    autocmd FileType voyager setlocal cursorline statusline=%!statusline#local('voyager')
  augroup END
endif "}}}
" }}}

" Color scheme {{{
augroup my-colorscheme
  autocmd!
  autocmd ColorScheme * call s:on_colorscheme(expand('<amatch>'), &background)
augroup END

function s:on_colorscheme(colorscheme, background) abort
  let dir  = expand('~/.vim/highlight')
  let file = printf('%s/%s/%s.vim', dir, a:colorscheme, a:background)
  if !filereadable(file)
    let file = dir . '/others.vim'
  endif
  exe 'source' fnameescape(file)
endfunction

if $COLORTERM is# 'truecolor' || $COLORTERM is# '24bit'
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
