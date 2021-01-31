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
  Plug 'airblade/vim-rooter'             " Change the working directory
  Plug 'cocopon/colorswatch.vim'         " Generate beautiful color swatch
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Inspects a link structure of hi-groups
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
  Plug 'glidenote/memolist.vim'          " Create and manage memo
  Plug 'haya14busa/vim-asterisk'         " Provides improved * motion
  Plug 'hrsh7th/vim-vsnip'               " VSCode Snippet like plugin
  Plug 'hrsh7th/vim-vsnip-integ'         " vsnip integrations
  Plug 'inkarkat/vim-cursorlinecurrentwindow' " Set cursorline only to current window
  Plug 'junegunn/vim-easy-align'         " Alignment plugin
  Plug 'junegunn/vim-plug'               " Plugin manager
  Plug 'kana/vim-operator-replace'       " Operator to replace text
  Plug 'kana/vim-operator-user'          " Make it easy to define operators
  Plug 'kana/vim-textobj-indent'         " Textobjects for indented block
  Plug 'kana/vim-textobj-line'           " Textobjects for a portion of current line
  Plug 'kana/vim-textobj-user'           " Make it easy to define textobjects
  Plug 'kuuote/vim-fuzzyhistory'         " Command line window matcher
  Plug 'lambdalisue/gina.vim'            " Git on Vim
  Plug 'machakann/vim-highlightedyank'   " Highlight the yanked text
  Plug 'machakann/vim-sandwich'          " Handle the sandwiched text easily
  Plug 'machakann/vim-swap'              " Reorder delimited items.
  Plug 'machakann/vim-textobj-delimited' " Textobjects for delimited parts of string
  Plug 'machakann/vim-textobj-functioncall' " Textobjects for function-call regions
  Plug 'mattn/ctrlp-matchfuzzy'          " Fast CtrlP matcher
  Plug 'mattn/vim-lsp-settings'          " Auto configurations for vim-lsp
  Plug 'mattn/vim-sonictemplate'         " Easy and high speed coding method
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
  Plug 'obcat/tlr.vim'                   " Tmux-Like window Resizer
  Plug 'obcat/vim-hitspop'               " Popup the number of search results
  Plug 'obcat/voyager.vim'               " Minimal file explorer
  Plug 'prabirshrestha/asyncomplete-lsp.vim' " LSP source for asyncomplete.vim and vim-lsp
  Plug 'prabirshrestha/asyncomplete.vim' " Async autocompletion
  Plug 'prabirshrestha/vim-lsp'          " Language Server Protocol
  Plug 'previm/previm'                   " Realtime markdown preview
  Plug 'rbtnn/vim-vimscript_lasterror'   " Jump to Vim script's last error
  Plug 'rhysd/clever-f.vim'              " Make f, F, t and T cleverer
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
  if has('gui_running')
    Plug 'obcat/vim-sclow'               " Text-based scrollbar
  endif
  call plug#end()
else
  augroup vimrc-notify-noplugins
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

function s:isplugged(plugname) abort
  let item = 'g:plugs[''' . a:plugname . '''].dir'
  return exists(item) ? isdirectory(eval(item)) : 0
endfunction
" }}}

" Options {{{
" Appearance
set background=dark
set cmdheight=2
set cursorline
set display=lastline
set fillchars=vert:│,fold:-
set foldtext=foldtext#global()
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set nowrap
set number
set ruler
set shortmess& shortmess+=aIF
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
set completeopt=menuone
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
set formatoptions& formatoptions+=j
set virtualedit=all

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
set mouse=a
set nrformats& nrformats-=octal
set report=0
set splitbelow
set splitright
set ttimeoutlen=50
set updatetime=100
" }}}

" Key mappings {{{
let g:mapleader = "\<Space>"
noremap <Space> <Nop>
noremap ' <Nop>
noremap m <Nop>
noremap \' '
noremap \m m

" Normal {{{
" File
nnoremap # <C-^>
nnoremap - <Cmd>call <SID>explore_head()<CR>
nnoremap <Leader>w <Cmd>update<CR>

" Motion
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap g: g;

" Scroll
nmap <C-u> <SID>(smooth-scroll-up)
nmap <C-d> <SID>(smooth-scroll-down)
nnoremap z<CR> zt
nnoremap zt z<CR>

" Change
nnoremap Y y$

" Script
nnoremap <Leader>s <Cmd>source % <Bar> echo 'sourced'<CR>

" Search
nnoremap <Leader>l <Cmd>let v:hlsearch = !v:hlsearch<CR>

" Window
nnoremap <Leader>q <C-w>c
nmap <C-w>o     <C-w>o<SID>(win-resized)
nmap <C-w><C-o> <C-w><C-o><SID>(win-resized)
nmap <Leader>z  <SID>(win-zoom)<SID>(win-resized)

" Tabpage
nnoremap Q <Cmd>tabclose<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT

" QuickFix
nnoremap [q <Cmd>cprevious<CR>
nnoremap ]q <Cmd>cnext<CR>

" Terminal
nnoremap <Leader>t <Cmd>call <SID>run_shell()<CR>

" <SID>s
nnoremap <SID>(smooth-scroll-up)   <Cmd>call <SID>smooth_scroll(1)<CR>
nnoremap <SID>(smooth-scroll-down) <Cmd>call <SID>smooth_scroll(0)<CR>
nnoremap <SID>(win-resized) <Cmd>call <SID>doau_user('WinResized')<CR>
nnoremap <SID>(win-zoom)    <Cmd>call <SID>toggle_win_zoom()<CR>

function s:explore_head() abort
  let file = expand('%:p:h')
  if isdirectory(file)
    exe 'edit' fnameescape(file)
  endif
endfunction

" Thank you aonemd
function s:smooth_scroll(up)
  let key = a:up ? "\<C-y>" : "\<C-e>"
  exe 'normal!' key
  redraw
  for i in range(1, &scroll, 2)
    sleep 7m
    exe 'normal!' key
    redraw
  endfor
  keepjumps normal! M
endfunction

function s:doau_user(event) abort
  if exists(printf('#User#%s', a:event))
    exe 'doautocmd User' a:event
  endif
endfunction

" Thank you lambdalisue.
function s:toggle_win_zoom() abort
  if exists('t:zoom_winrestcmd')
    execute t:zoom_winrestcmd
    unlet t:zoom_winrestcmd
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
  endif
endfunction

function s:run_shell() abort
  let file = expand('%:p')
  let wd   = isdirectory(file) ? file : getcwd()
  call term_start(&shell, #{
    \ cwd: wd,
    \ term_finish: 'close',
    \ })
endfunction
" }}}

" Visual {{{
xnoremap y ygv<ESC>
xnoremap Y Ygv<ESC>
xnoremap a" 2i"
xnoremap a' 2i'
xnoremap a` 2i`
xnoremap . :normal! .<CR>
" }}}

" Operator pending {{{
onoremap a" 2i"
onoremap a' 2i'
onoremap a` 2i`
" }}}

" Insert {{{
inoremap <C-d> <Del>
inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>
inoremap <C-u> <C-g>u<C-u>
" NOTE: <C-a> can be replaced with <C-r>.<CR>
inoremap <expr> <C-a> <SID>i_ctrl_a()
inoremap <expr> <C-e> <SID>i_ctrl_e()
inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

function s:i_ctrl_a() abort
  let line = getline('.')
  let indent = strchars(matchstr(line, '^\s*'))
  let prefix = strchars(strpart(line, 0, col('.') - 1))
  return "\<C-g>U\<Left>" ->repeat(indent < prefix ? prefix - indent : prefix)
endfunction

function s:i_ctrl_e() abort
  let cursor = col('.')
  let eol    = col('$')
  return cursor < eol
    \ ? "\<C-g>U\<Right>" ->repeat(strchars(strpart(getline('.'), cursor - 1)))
    \ : "\<C-e>"
endfunction
" }}}

" Command line {{{
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <expr> <C-d> getcmdpos() <= strlen(getcmdline()) ? '<Del>' : '<C-d>'
cnoremap <expr> <C-f> getcmdpos() <= strlen(getcmdline()) ? '<Right>' : &cedit
cnoremap <expr> <C-o> wildmenumode() ? '<Left>' : '<C-o>'
cnoremap <expr> <C-x> expand('%:p')
" https://github.com/vim/vim/issues/7552
cnoremap <C-n> <Cmd>call feedkeys("\<lt>Down>", 'nt')<CR>
cnoremap <C-p> <Up>
" }}}
" }}}

" Aliases {{{
let s:alias_config = [
  \ ['cap',   'Capture'],
  \ ['gina',  'Gina'],
  \ ['h',     'H'],
  \ ['hc',    'helpc'],
  \ ['helpg', 'Helpg'],
  \ ]

function s:define_alias(pairs) abort
  for pair in a:pairs
    exe printf('cnoreabbrev <expr> %s (getcmdtype() is# '':'' && getcmdline() is# %s) ? %s : %s',
      \ pair[0], string(pair[0]), string(pair[1]), string(pair[0])
      \ )
  endfor
endfunction
call s:define_alias(s:alias_config)
" }}}

" User-defined commands {{{
command! -nargs=? -complete=help H
  \ exe (max([80 * 2, winheight(0)]) <= winwidth(0) ? 'vertical' : '') 'help' <q-args>
command! -nargs=1 Helpg
  \ exe (max([80 * 2, winheight(0)]) <= winwidth(0) ? 'vertical' : '') 'helpgrep' <q-args>
" }}}

" Autocommands {{{
augroup vimrc-filetype
  autocmd!
  autocmd FileType *         setlocal formatoptions-=o
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd FileType vim       setlocal foldmethod=marker
  autocmd FileType help      call <SID>on_filetype_help()
  autocmd FileType qf        call <SID>on_filetype_qf()
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
  nnoremap <buffer> p <Cmd>call <SID>qf_preview()<CR>
  setlocal statusline=%!statusline#local('qf')
endfunction

function s:qf_preview() abort
  " :normal avoids redrawing
  exe "normal! \<CR>zz\<C-w>p"
endfunction

augroup vimrc-terminalopen
  autocmd!
  autocmd TerminalOpen * call <SID>on_terminalopen(+expand('<abuf>'))
augroup END

function s:on_terminalopen(bufnr) abort
  call setbufvar(a:bufnr, '&number', 0)
  call setbufvar(a:bufnr, '&signcolumn', 'no')
endfunction

augroup vimrc-restore-curpos
  autocmd!
  autocmd BufReadPost * call <SID>restore_curpos()
augroup END

function s:restore_curpos() abort
  if 1 <= line('''"') && line('''"') <= line('$') && &filetype !~# 'commit'
    exe 'normal! g`"'
  endif
endfunction
" }}}

" Plugin settings {{{
if s:isplugged('caw.vim') "{{{
  let g:caw_no_default_keymappings = 1
  let g:caw_operator_keymappings   = 1
  nmap <Leader>k <Plug>(caw:hatpos:toggle:operator)
  vmap <Leader>k <Plug>(caw:hatpos:toggle)
endif "}}}

if s:isplugged('clever-f.vim') "{{{
  let g:clever_f_across_no_line = 1
endif "}}}

if s:isplugged('ctrlp.vim') "{{{
  let g:ctrlp_show_hidden     = 1
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_line_prefix  = '▸ '
  let g:ctrlp_reuse_window = '\v.*'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
  if s:isplugged('ctrlp_matchfuzzy.vim')
    let g:ctrlp_match_func = #{match: 'ctrlp_matchfuzzy#matcher'}
  endif

  let g:ctrlp_map = '<Leader>p'
  nnoremap <Leader>u <Cmd>CtrlPMRU<CR>

  augroup vimrc-ctrlp
    autocmd!
    autocmd VimEnter,VimResized * call s:ctrlp_set_options()
  augroup END

  function s:ctrlp_set_options() abort
    let half = &lines / 2
    let g:ctrlp_match_window = printf('bottom,order:top,min:%d,max:%d,result:%d', half, half, half)
  endfunction
endif "}}}

if s:isplugged('gina.vim') "{{{
  nnoremap 'a <Cmd>Gina status<CR>
  nnoremap 'c <Cmd>Gina commit<CR>
  nnoremap 'C <Cmd>Gina commit --amend<CR>
  nnoremap 'b <Cmd>Gina branch -av<CR>
  nnoremap 'l <Cmd>Gina log --graph --all<CR>
  nnoremap 'f <Cmd>Gina ls<CR>
  nnoremap 'r :<C-u>terminal git rebase -i<Space>

  call gina#custom#command#option(
    \ 'status',
    \ '-b|--branch'
    \)
  call gina#custom#command#option(
    \ 'status',
    \ '-s|--short'
    \)
  call gina#custom#action#shorten(
    \ 'branch',
    \ 'branch'
    \ )
  call gina#custom#action#shorten(
    \ 'branch',
    \ 'commit'
    \ )
  call gina#custom#mapping#map(
   \ 'status', '<',
   \ '<Plug>(gina-index-stage)',
   \ {'nowait': 1}
   \ )
  call gina#custom#mapping#map(
   \ 'status', '>',
   \ '<Plug>(gina-index-unstage)',
   \ {'nowait': 1}
   \ )
  call gina#custom#mapping#map(
   \ 'status', '-',
   \ '<Plug>(gina-index-toggle)',
   \ {'nowait': 1}
   \ )
  augroup vimrc-gina
    autocmd!
    autocmd FileType gina-commit setlocal spell
  augroup END
endif "}}}

if s:isplugged('junkfile.vim') "{{{
  let g:junkfile#directory = isdirectory(expand('~/Dropbox'))
    \ ? expand('~/Dropbox/junkfile')
    \ : expand('~/junkfile')
endif "}}}

if s:isplugged('memolist.vim') "{{{
  let g:memolist_path = isdirectory(expand('~/Dropbox'))
    \ ? expand('~/Dropbox/memolist')
    \ : expand('~/memolist')
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = expand('~/.vim/template/memolist')
endif "}}}

if s:isplugged('open-browser.vim') "{{{
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif "}}}

if s:isplugged('tlr.vim') "{{{
  let g:tlr_resize_steps = 8
  nmap <C-Down>  <Plug>(tlr-down)<SID>(win-resized)
  nmap <C-Up>    <Plug>(tlr-up)<SID>(win-resized)
  nmap <C-Left>  <Plug>(tlr-left)<SID>(win-resized)
  nmap <C-Right> <Plug>(tlr-right)<SID>(win-resized)
endif "}}}

if s:isplugged('vim-asterisk') "{{{
  map *  <Plug>(asterisk-z*)
  map g* <Plug>(asterisk-gz*)
endif "}}}

if s:isplugged('vim-better-whitespace') "{{{
  let g:strip_whitespace_on_save = 1
  let g:better_whitespace_ctermcolor = 'NONE'
  let g:better_whitespace_guicolor   = 'NONE'
endif "}}}

if s:isplugged('vim-easy-align') "{{{
  " NOTE: ga can be replaced by :ascii<CR>
  nmap ga <Plug>(EasyAlign)
  xmap ga <Plug>(EasyAlign)
endif "}}}

if s:isplugged('vim-fuzzyhistory') "{{{
  augroup vimrc-fuzzyhistory
    autocmd!
    autocmd CmdwinEnter * nmap <buffer> <Leader>f <Plug>(fuzzy-history)
  augroup END
endif "}}}

if s:isplugged('vim-gitgutter') "{{{
  let g:gitgutter_sign_priority = 10
endif "}}}

if s:isplugged('vim-highlightedyank') "{{{
  let g:highlightedyank_highlight_duration = 500
endif "}}}

if s:isplugged('vim-hitspop') "{{{
  let g:hitspop_line = 'winbot'
  augroup vimrc-hitspop
    autocmd!
    autocmd User WinResized call hitspop#main()
  augroup END
endif "}}}

if s:isplugged('vim-lsp') "{{{
  \ && s:isplugged('asyncomplete.vim')
  \ && s:isplugged('asyncomplete-lsp.vim')
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_documentation_float     = 0
  let g:lsp_signs_priority          = 20
  let g:asyncomplete_auto_completeopt = 0
  let g:asyncomplete_auto_popup       = 0

  function s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gr <Plug>(lsp-references)
  endfunction

  function s:on_lsp_float_opened() abort
    let winid = lsp#ui#vim#output#getpreviewwinid()
    let width = winbufnr(winid)
      \ ->getbufline(1, '$')
      \ ->map('strwidth(v:val)')
      \ ->max()
    call popup_setoptions(winid, #{
      \ maxheight: &lines / 3,
      \ minwidth: width,
      \ highlight: 'LspPreviewPopup',
      \ padding: [0, 1, 0, 1],
      \ borderhighlight: ['LspPreviewPopupBorder'],
      \ borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
      \ scrollbar: 0,
      \ })
  endfunction
  augroup vimrc-lsp
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    autocmd User lsp_float_opened   call s:on_lsp_float_opened()
  augroup END
endif "}}}

if s:isplugged('vim-operator-replace') "{{{
  map  <Leader>r  <Plug>(operator-replace)
  nmap <Leader>rr <Plug>(operator-replace)<Plug>(operator-replace)
endif "}}}

if s:isplugged('vim-rooter') "{{{
  let g:rooter_cd_cmd = 'lcd'
  let g:rooter_silent_chdir = 1
endif "}}}

if s:isplugged('vim-sandwich') "{{{
  " NOTE: s can be replaced by cl
  nmap s <Nop>
  xmap s <Nop>
endif "}}}

if s:isplugged('vim-sclow') "{{{
  let g:sclow_hide_full_length = 1
  let g:sclow_sbar_right_offset = -1
  augroup vimrc-sclow
    autocmd!
    autocmd User WinResized call sclow#update()
  augroup END
endif "}}}

if s:isplugged('vim-sonictemplate') "{{{
  let g:sonictemplate_key             = 0
  let g:sonictemplate_intelligent_key = 0
  let g:sonictemplate_postfix_key     = 0
  let g:sonictemplate_vim_template_dir = expand('~/.vim/template/sonictemplate')
  let g:sonictemplate_maintainer = 'obcat <obcat@icloud.com>'
  let g:sonictemplate_license    = 'MIT License'
  augroup vimrc-sonictemplate
    autocmd!
    autocmd FileType stpl setlocal noexpandtab
  augroup END
endif "}}}

if s:isplugged('vim-swap') "{{{
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
endif "}}}

if s:isplugged('vim-tokyonight') "{{{
  let g:tokyonight_enable_italic          = 0
  let g:tokyonight_disable_italic_comment = 1
endif "}}}

if s:isplugged('vim-vsnip') "{{{
  let g:vsnip_snippet_dir = expand('~/.vim/snippet/vsnip')
  imap <expr> <C-i> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-i>'
  smap <expr> <C-i> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-i>'
endif "}}}

if s:isplugged('voyager.vim') "{{{
  let g:voyager_keepalt = 1
  let g:loaded_netrw             = 1
  let g:loaded_netrwFileHandlers = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  augroup vimrc-voyager
    autocmd!
    autocmd FileType voyager setlocal statusline=%!statusline#local('voyager')
  augroup END
endif "}}}
" }}}

" Color scheme {{{
function s:override_highlights(colorscheme, background) abort
  let dir  = expand('~/.vim/highlight')
  let file = printf('%s/%s/%s.vim', dir, a:colorscheme, a:background)
  exe 'source' fnameescape(filereadable(file) ? file : dir . '/others.vim')
endfunction

augroup vimrc-color-scheme
  autocmd!
  autocmd ColorScheme * call s:override_highlights(expand('<amatch>'), &background)
augroup END

if $COLORTERM is# 'truecolor' || $COLORTERM is# '24bit'
  set termguicolors
endif
exe 'colorscheme' s:isplugged('iceberg.vim') ? 'iceberg' : 'slate'
" }}}

" Local settings {{{
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
" }}}
