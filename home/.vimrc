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
  Plug 'airblade/vim-rooter'             " Change the working directory
  Plug 'cocopon/colorswatch.vim'         " Generate beautiful color swatch
  Plug 'cocopon/iceberg.vim'             " Color scheme
  Plug 'cocopon/inspecthi.vim'           " Inspects a link structure of hi-groups
  Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy finder
  Plug 'ghifarit53/tokyonight-vim'       " Color scheme
  Plug 'glidenote/memolist.vim'          " Create and manage memo
  Plug 'haya14busa/vim-asterisk'         " Provides improved * motion
  Plug 'hrsh7th/vim-vsnip'               " VSCode Snippet like plugin
  Plug 'hrsh7th/vim-vsnip-integ'         " vsnip integrations
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
  Plug 'mattn/vim-molder'                " Minimal file explorer
  Plug 'mattn/vim-sonictemplate'         " Easy and high speed coding method
  Plug 'ntpeters/vim-better-whitespace'  " Highlight the trailing white spaces
  Plug 'obcat/tlr.vim'                   " Tmux-like window Resizer
  Plug 'prabirshrestha/asyncomplete-lsp.vim' " LSP source for asyncomplete.vim and vim-lsp
  Plug 'prabirshrestha/asyncomplete.vim' " Async autocompletion
  Plug 'prabirshrestha/vim-lsp'          " Language Server Protocol
  Plug 'previm/previm'                   " Realtime markdown preview
  Plug 'rhysd/clever-f.vim'              " Make f, F, t and T cleverer
  Plug 'thinca/vim-prettyprint'          " Prettyprint Vim variable for debug
  Plug 'thinca/vim-themis'               " Testing framework for Vim script
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

  function! PluginManagerInstall() abort
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endfunction
endif

filetype plugin on

" Check if a plugin exists
function s:isplugged(name) abort
  let target = 'g:plugs['''..a:name..'''].dir'
  return exists(target)
    \ ? isdirectory(eval(target))
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
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set nowrap
set number
set ruler
set shortmess& shortmess+=aIF
set showtabline=2
set signcolumn=yes
set wildmenu
syntax enable

" Completion
set completeopt=menuone
set pumheight=8

" Cursor
if has('vim_starting')
  let &t_EI .= "\e[2 q"
  let &t_SI .= "\e[6 q"
  let &t_SR .= "\e[4 q"
endif

" Editing
set backspace=indent,eol,start
set formatoptions& formatoptions+=j
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
set history=1000

" Misc
set belloff=all
set clipboard=unnamed
set hidden
set mouse=a
set splitbelow
set splitright
set ttimeoutlen=50
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
nnoremap z<CR> zt
nnoremap zt z<CR>

nnoremap <Leader>q <C-w>c
nnoremap <silent> <Leader>w :<C-u>silent update<CR>
nnoremap <silent> <Leader>l :<C-u>let v:hlsearch = !v:hlsearch<CR>
nnoremap <silent> <Leader>t :<C-u>call <SID>run_shell()<CR>

nnoremap <silent> [q :<C-u>cprevious<CR>
nnoremap <silent> ]q :<C-u>cnext<CR>

nnoremap <silent> - :<C-u>call <SID>explore_head()<CR>

nnoremap <silent> <C-w>o <C-w>o:doautocmd User WinResized<CR>
nnoremap <silent> <C-w><C-o> <C-w><C-o>:doautocmd User WinResized<CR>

function s:run_shell() abort "{{{
  let fname = @% ->fnamemodify(':p')
  let wd = isdirectory(fname)
    \ ? fname
    \ : getcwd()
  call term_start(&shell, #{
    \ cwd: wd,
    \ term_finish: 'close',
    \ })
endfunction "}}}

function s:explore_head() abort "{{{
  let dir = expand('%:p:h')
  if !isdirectory(dir)
    return
  endif
  exe 'edit' fnameescape(dir)
endfunction "}}}
" }}}

" Visual {{{
xnoremap y ygv<ESC>
xnoremap Y Ygv<ESC>
xnoremap a' 2i'
xnoremap a" 2i"
" }}}

" Operator pending {{{
onoremap a' 2i'
onoremap a" 2i"
" }}}

" Insert {{{
inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>
inoremap <expr> <C-a> <SID>i_ctrl_a()
inoremap <expr> <C-e> <SID>i_ctrl_e()
inoremap <C-d> <Del>

inoremap <C-u> <C-g>u<C-u>

inoremap <expr> <CR> pumvisible() ? '<C-y><CR>' : '<CR>'

function s:i_ctrl_a() abort
  let line = getline('.')
  let indent     = strchars(matchstr(line, '^\s*'))
  let precedings = strchars(strpart(line, 0, col('.') - 1))
  if  indent < precedings
    return "\<C-g>U\<Left>" ->repeat(precedings - indent)
  else
    return "\<C-g>U\<Left>" ->repeat(precedings)
  endif
endfunction

function s:i_ctrl_e() abort
  let curcol = col('.')
  let endcol = col('$')
  if curcol < endcol
    return "\<C-g>U\<Right>" ->repeat(strchars(strpart(getline('.'), curcol - 1)))
  else
    return "\<C-e>"
  endif
endfunction
" }}}

" Command line {{{
cnoremap <C-b> <Left>
cnoremap <expr> <C-f> <SID>c_ctrl_f()
cnoremap <C-a> <Home>
cnoremap <expr> <C-d> <SID>c_ctrl_d()

cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

function s:c_ctrl_f() abort
  if getcmdpos() <= strlen(getcmdline())
    return "\<Right>"
  else
    return &cedit
  endif
endfunction

function s:c_ctrl_d() abort
  if getcmdpos() <= strlen(getcmdline())
    return "\<Del>"
  else
    return "\<C-d>"
  endif
endfunction
" }}}
" }}}

" Aliases {{{
function s:alias(key, val) abort "{{{
  exe printf(
    \ 'cnoreabbrev <expr> %s (getcmdtype() is# ":" && getcmdpos() == %d) ? %s : %s',
    \ a:key, 1 + len(a:key), string(a:val), string(a:key)
    \ )
endfunction "}}}

call s:alias('ss',    'so %')
call s:alias('cap',   'Capture')
call s:alias('gina',  'Gina')
call s:alias('h',     'H')
call s:alias('hc',    'helpc')
call s:alias('helpg', 'Helpg')
" }}}

" User-defined commands {{{
command! -nargs=? -complete=help H
  \ exe (max([80 * 2, winheight(0)]) <= winwidth(0) ? 'vertical' : '') 'help' <q-args>

command! -nargs=1 Helpg
  \ exe (max([80 * 2, winheight(0)]) <= winwidth(0) ? 'vertical' : '') 'helpgrep' <q-args>
" }}}

" Autocommands {{{
autocmd vimrc FileType *         setlocal formatoptions-=o
autocmd vimrc FileType gitcommit setlocal spell
autocmd vimrc FileType gitconfig setlocal noexpandtab
autocmd vimrc FileType vim       setlocal foldmethod=marker
autocmd vimrc FileType help      call <SID>onft_help()
autocmd vimrc FileType qf        call <SID>onft_qf()

autocmd vimrc BufReadPost     * call <SID>restore_curpos()
autocmd vimrc TerminalWinOpen * setlocal nonumber signcolumn=no

" Avoid `No matching autocommands` error
autocmd vimrc User * :

function s:onft_help() abort
  setlocal conceallevel=0
  if !&modifiable
    nnoremap <buffer> <silent> C :<C-u>exe 'help' expand('<cword>')..'@en'<CR>
    nnoremap <buffer> <silent> J :<C-u>exe 'help' expand('<cword>')..'@ja'<CR>
  endif
endfunction

function s:onft_qf() abort
  exe 'resize' min([line('$') + 2, 10])
  nnoremap <buffer> <silent> p :<C-u>call <SID>qf_preview()<CR>
endfunction

function s:qf_preview() abort
  " :normal avoids redrawing
  exe "normal! \<CR>zz\<C-w>p"
endfunction

function s:restore_curpos() abort
  if 1 <= line('''"') && line('''"') <= line('$') && &ft !~# 'commit'
    exe 'normal! g`"'
  endif
endfunction
" }}}

" Statusline {{{
set statusline=%!MyStatusLine()

function! MyStatusLine() abort "{{{
  let activity = g:statusline_winid == win_getid()
    \ ? 'active'
    \ : 'inactive'
  return s:stl_{activity}()
endfunction "}}}

const s:space = "\<Space>" ->repeat(2)

function s:stl_active() abort
  let winwid = winwidth(0)
  let stl = ''
  let stl .= s:space
  let stl .= '%t'
  if winwid < 40
    return stl
  endif
  let stl .= s:space
  let stl .= s:gitbranch()
  if winwid < 50
    return stl
  endif
  let stl .= s:space
  let stl .= '%4*'
  let stl .= s:githunks()
  let stl .= '%0*'
  if winwid < 60
    return stl
  endif
  let stl .= '%='
  let stl .= getcwd() ->fnamemodify(':t')
  let stl .= s:space
  return stl
endfunction

function s:stl_inactive() abort
  let stl = ''
  let stl .= s:space
  let stl .= '%t'
  return stl
endfunction

function s:gitbranch() abort "{{{
  try
    return gina#component#repo#branch()
  catch /:E117:/
    return 'E117'
  endtry
endfunction "}}}

function s:githunks() abort "{{{
  try
    let hunknum = len(gitgutter#hunk#hunks(bufnr()))
  catch /:E117:/
    return 'E117'
  endtry
  let max = 6
  let symbol = '*'
  return hunknum <= max
    \ ? (symbol ->repeat(hunknum))
    \ : (symbol ->repeat(max - 1))..'>'
endfunction "}}}
" }}}

" Tabline {{{
set tabline=%!MyTabLine()

function! MyTabLine() abort "{{{
  let tal = ''
  let N = tabpagenr('$')
  for i in range(1, N)
    let tal .= s:tal_label(i)
  endfor
  let tal .= s:tal_fill()
  return tal
endfunction "}}}

function s:tal_label(tabnr) abort "{{{
  let activity = a:tabnr == tabpagenr() ? 'active' : 'inactive'
  return s:tal_label_{activity}(a:tabnr)
endfunction "}}}

const s:modflag_margin = 1
const s:padding = 2 * s:modflag_margin + 1
const s:width = 16

function s:tal_label_active(tabnr) abort
  let delimleft  = '%#TabLineSelDelim#'..'▏'..'%#TabLineSel#'
  let delimright = '%#TabLineSelDelim#'..'▕'..'%#TabLineSel#'
  let modflag    = '%#TabLineSelMod#'  ..'●'..'%#TabLineSel#'
  let activebufnr = tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]
  let lbl = ''
  let lbl .= '%#TabLineSel#'
  let lbl .= '%'..a:tabnr..'T'
  let lbl .= (a:tabnr == 1 ? "\<Space>" : delimleft)
        \ .. "\<Space>" ->repeat(s:padding - 1)
  let lbl .= s:bufname(activebufnr) ->s:center(s:width)
  let lbl .= "\<Space>" ->repeat(s:modflag_margin)
        \ .. (getbufvar(activebufnr, '&modified') ? modflag : "\<Space>")
        \ .. "\<Space>" ->repeat(s:modflag_margin - 1)
        \ .. delimright
  return lbl
endfunction

function s:tal_label_inactive(tabnr) abort
  let activebufnr = tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]
  let lbl = ''
  let lbl .= '%#TabLine#'
  let lbl .= '%'..a:tabnr..'T'
  let lbl .= "\<Space>" ->repeat(s:padding)
  let lbl .= s:bufname(activebufnr) ->s:center(s:width)
  let lbl .= "\<Space>" ->repeat(s:padding)
  return lbl
endfunction

function s:tal_fill() abort
  let fil = ''
  let fil .= '%#TabLineFill#'
  let fil .= '%T'
  return fil
endfunction

function s:center(str, minwid) abort "{{{
  let strwid = strwidth(a:str)
  if strwid > a:minwid
    return a:str
  endif
  let p = (a:minwid - strwid) / 2
  return printf('%s%s%s',
    \ "\<Space>" ->repeat(p),
    \ a:str,
    \ "\<Space>" ->repeat(a:minwid - (p + strwid))
    \ )
endfunction "}}}

function s:bufname(bufnr) abort "{{{
  if getbufvar(a:bufnr, '&buftype') is# 'quickfix'
    return '[Quickfix List]'
  endif
  let name = bufname(a:bufnr)
  if empty(name)
    return '[No Name]'
  endif
  return fnamemodify(name, ':t')..(isdirectory(name) ? '/' : '')
endfunction "}}}
" }}}

" Plugin settings {{{
if s:isplugged('vim-asterisk') "{{{
  map *  <Plug>(asterisk-z*)
  map g* <Plug>(asterisk-gz*)
endif "}}}

if s:isplugged('vim-better-whitespace') "{{{
  let g:strip_whitespace_on_save = 1
  let g:better_whitespace_ctermcolor = 'NONE'
  let g:better_whitespace_guicolor   = 'NONE'
endif "}}}

if s:isplugged('clever-f.vim') "{{{
  let g:clever_f_across_no_line = 1
endif "}}}

if s:isplugged('ctrlp.vim') "{{{
  let g:ctrlp_show_hidden     = 1
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
  let g:ctrlp_buffer_func = #{enter: 'g:CtrlpBufferFuncEnter'}

  if s:isplugged('ctrlp_matchfuzzy.vim')
    let g:ctrlp_match_func = #{match: 'ctrlp_matchfuzzy#matcher'}
  endif

  function! CtrlpBufferFuncEnter() abort
    setlocal cursorlineopt=line
  endfunction

  nnoremap <silent> ,, :<C-u>CtrlPMRU<CR>
endif "}}}

if s:isplugged('vim-easy-align') "{{{
  xmap ga <Plug>(EasyAlign)
endif "}}}

if s:isplugged('gina.vim') "{{{
  autocmd vimrc FileType gina-commit setlocal spell
endif "}}}

if s:isplugged('vim-gitgutter') "{{{
  set updatetime=100
  let g:gitgutter_sign_priority = 10
endif "}}}

if s:isplugged('vim-highlightedyank') "{{{
  let g:highlightedyank_highlight_duration = 500
endif "}}}

if s:isplugged('vim-hitspop') "{{{
  let g:hitspop_line = 'winbot'
  autocmd vimrc User WinResized call hitspop#main()
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

  autocmd vimrc User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  autocmd vimrc User lsp_float_opened
    \ call popup_setoptions(lsp#ui#vim#output#getpreviewwinid(), #{
    \   padding: [0, 1, 0, 1],
    \   maxheight: 16,
    \   highlight: 'LspPreviewPopup',
    \ })
endif "}}}

if s:isplugged('memolist.vim') "{{{
  " NOTE: memolist creates directories if needed
  let g:memolist_path = isdirectory(expand('~/Dropbox'))
    \ ? expand('~/Dropbox/memolist')
    \ : expand('~/memolist')
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = expand('~/.vim/template/memolist')
endif "}}}

if s:isplugged('vim-molder') "{{{
  let g:molder_show_hidden = 1
  let g:loaded_netrw             = 1
  let g:loaded_netrwFileHandlers = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1

  autocmd vimrc FileType molder call <SID>onft_molder()

  function s:onft_molder() abort
    setlocal cursorlineopt=line
    setlocal nonumber
    setlocal statusline=%!MolderStl()
  endfunction

  function! MolderStl() abort
    let space = "\<Space>" ->repeat(2)
    let stl = ''
    let stl .= space
    let stl .= @% ->fnamemodify(':p:~')
    if winwidth(0) < 60
      return stl
    endif
    let stl .= '%='
    let stl .= getcwd() ->fnamemodify(':t')
    let stl .= space
    return stl
  endfunction
endif "}}}

if s:isplugged('vim-operator-replace') "{{{
  map  <Space>r  <Plug>(operator-replace)
  nmap <Space>rr <Plug>(operator-replace)<Plug>(operator-replace)
endif "}}}

if s:isplugged('open-browser.vim') "{{{
  let g:netrw_nogx = 1
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif "}}}

if s:isplugged('vim-rooter') "{{{
  let g:rooter_cd_cmd = 'lcd'
  let g:rooter_silent_chdir = 1
endif "}}}

if s:isplugged('vim-sandwich') "{{{
  " NOTE: s can be replaced by cl
  nmap s <Nop>
  xmap s <Nop>
  nmap sx sdb
  nmap sc srb
  nmap s" <Plug>(operator-sandwich-add-query1st)"
  nmap s' <Plug>(operator-sandwich-add-query1st)'
  nmap s0 <Plug>(operator-sandwich-add-query1st))
  nmap s9 <Plug>(operator-sandwich-add-query1st)(
  nmap s[ <Plug>(operator-sandwich-add-query1st)[
  nmap s] <Plug>(operator-sandwich-add-query1st)]
  nmap sf <Plug>(operator-sandwich-add-query1st)f
  nmap s{ <Plug>(operator-sandwich-add-query1st){
  nmap s} <Plug>(operator-sandwich-add-query1st)}
  xmap s" <Plug>(operator-sandwich-add)"
  xmap s' <Plug>(operator-sandwich-add)'
  xmap s0 <Plug>(operator-sandwich-add))
  xmap s9 <Plug>(operator-sandwich-add)(
  xmap s[ <Plug>(operator-sandwich-add)[
  xmap s] <Plug>(operator-sandwich-add)]
  xmap sf <Plug>(operator-sandwich-add)f
  xmap s{ <Plug>(operator-sandwich-add){
  xmap s} <Plug>(operator-sandwich-add)}
endif "}}}

if s:isplugged('vim-sclow') "{{{
  let g:sclow_hide_full_length = 1
  let g:sclow_sbar_right_offset = -1
  autocmd vimrc User WinResized call sclow#update()
endif "}}}

if s:isplugged('vim-sonictemplate') "{{{
  let g:loaded_sonictemplate_vim = 1  " Disable default key mappings
  let g:sonictemplate_vim_template_dir = expand('~/.vim/template/sonictemplate')
  let g:sonictemplate_maintainer = 'obcat <obcat@icloud.com>'
  let g:sonictemplate_license    = 'MIT License'

  command! -nargs=1 -complete=customlist,sonictemplate#complete
    \ Template call sonictemplate#apply(<f-args>, 'n')

  autocmd vimrc FileType stpl setlocal noexpandtab
endif "}}}

if s:isplugged('vim-swap') "{{{
  omap i, <Plug>(swap-textobject-i)
  xmap i, <Plug>(swap-textobject-i)
  omap a, <Plug>(swap-textobject-a)
  xmap a, <Plug>(swap-textobject-a)
endif "}}}

if s:isplugged('tlr.vim') "{{{
  let g:tlr_resize_steps = 8
  nmap <silent> <C-Down>  <Plug>(tlr-down):doautocmd User WinResized<CR>
  nmap <silent> <C-Up>    <Plug>(tlr-up):doautocmd User WinResized<CR>
  nmap <silent> <C-Left>  <Plug>(tlr-left):doautocmd User WinResized<CR>
  nmap <silent> <C-Right> <Plug>(tlr-right):doautocmd User WinResized<CR>
endif "}}}

if s:isplugged('vim-vsnip') "{{{
  let g:vsnip_snippet_dir = expand('~/.vim/snippet/vsnip')
  imap <expr> <C-i> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-i>'
  smap <expr> <C-i> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-i>'
endif "}}}
" }}}

" Color scheme {{{
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1

function s:override_highlights(name, bg) abort
  let dir  = expand('~/.vim/highlight')
  let file = printf('%s/%s/%s.vim', dir, a:name, a:bg)
  if filereadable(file)
    exe 'source' fnameescape(file)
  else
    exe 'source' fnameescape(dir..'/others.vim')
  endif
endfunction

autocmd vimrc ColorScheme *
  \ call s:override_highlights(expand('<amatch>'), &background)

if s:isplugged('iceberg.vim')
  colorscheme iceberg
else
  colorscheme slate
endif

if $COLORTERM is# 'truecolor' || $COLORTERM is# '24bit'
  set termguicolors
endif
" }}}

" Local settings {{{
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif
" }}}
