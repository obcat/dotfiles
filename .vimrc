"   __  __ _ _____ _________
"   \ \ | |_|     V  __/  __|
"    \ \| | | | | | |  | [__
" [_] \___|_|_|_|_|_|  \____|

" Encoding {{{
set encoding=utf-8   " Vimが内部で使用する文字コード
scriptencoding utf-8 " スクリプトで使用されている文字コードの宣言
" }}}

" プラグイン {{{
" プラグインのリスト
if !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin()
    Plug 'junegunn/vim-plug'        " プラグインを管理するプラグイン
    Plug 'vim-jp/vimdoc-ja'         " 日本語版のヘルプ
    Plug 'arcticicestudio/nord-vim' " カラースキーム
    Plug 'cocopon/iceberg.vim'      " カラースキーム
    Plug 'cocopon/shadeline.vim'    " シンプルなステータスライン
    Plug 'lambdalisue/gina.vim'     " Vim上でGit
    Plug 'airblade/vim-gitgutter'   " Gitのステータスを行番号の横に表示
    call plug#end()
else
    echo 'Plugins are not installed yet. See README.md.'
endif

" ファイル形式別プラグインのロードを有効化
filetype plugin on

" プラグインがインストールされているかどうかを調べる関数
function! s:IsInstalled(plugin) abort
    return !empty(glob('~/.vim/plugged/' . a:plugin))
endfunction
" }}}

" 基本設定 {{{
" 見た目
syntax on                   " シンタックスハイライトを有効化
set number                  " 行番号を表示
set laststatus=2            " ステータスラインを常に表示
set showcmd                 " 入力中のコマンドをスクリーン右下に表示
set wildmenu                " コマンドライン補完時にリッチなメニューを表示
set background=dark         " Vimに伝える背景色
set list                    " タブや改行を表示
set listchars=tab:▸\ ,eol:¬ " listが有効なときに使う文字
set cursorline              " カーソル行をハイライト
set ambiwidth=double        " 一部の特殊な文字の表示幅
set display=lastline        " ウィンドウの最後の行が収まらないときの表示形式

" インデント
filetype indent on " ファイル形式別インデントのロードを有効化
set autoindent     " 直前の行から新しい行のインデントを得る
set smartindent    " C言語等で有効な高度な自動インデント
set breakindent    " 折り返された行を同じインデントで表示
set expandtab      " タブで空白を入力
set tabstop=4      " 画面上でタブ文字が占める幅
set shiftwidth=4   " 自動インデントやコマンド<<などに使われる空白の数
set smarttab       " shiftwidthの数だけタブで空白を挿入しBSで空白を削除する
set shiftround     " インデントをshiftwidthの値の倍数に丸める

" 編集
set virtualedit=block          " フリーカーソルモードを有効にする場面
set backspace=indent,eol,start " 挿入モードにおけるBSやDelの挙動
set showmatch                  " 閉じ括弧入力時に対応する開き括弧を知らせる

" 検索
set hlsearch  " 最後に検索したパターンをハイライト
set incsearch " 検索パターン入力中にその文字をハイライト

" バックアップ
let s:swapdir = $HOME . '/.vim/swap'
if !isdirectory(s:swapdir)
    call mkdir(s:swapdir, 'p')
endif
let &directory = s:swapdir " swapファイルの保存先

" ファイルの取り扱い
set autoread       " Vimの外部での変更を自動的に読み込む
set hidden         " バッファを放棄するときメモリを開放しない

" その他
set helplang=ja                   " ヘルプで優先して使用する言語のリスト
set belloff=all                   " ベルを鳴らさないようにするイベント
set ttimeoutlen=100               " キーコード入力をタイムアウトにする時間
set sidescroll=1                  " 水平スクロールの刻み幅
set history=200                   " コマンドライン履歴の記録数
set clipboard=unnamed,unnamedplus " デフォルトのレジスタ
augroup vimrc
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" カラースキーム {{{
if s:IsInstalled('iceberg.vim')
    colorscheme iceberg
else
    colorscheme slate
endif

if $COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit'
    set termguicolors
endif
" }}}

" キーマッピング {{{
" 折り返された行を見た目のままに移動する
noremap j gj
noremap k gk

" コマンドライン履歴を先頭一致で遡る
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}

" プラグインの設定 {{{
" gitgutter {{{
if s:IsInstalled('vim-gitgutter')
    set updatetime=100 " この時間だけ入力がなければswapファイルを更新
endif
" }}}

" shadeline {{{
if s:IsInstalled('shadeline.vim')
    let g:shadeline = {}
    let g:shadeline.active = {
    \   'left': [
    \       'fname',
    \       'flags',
    \       'ShadelineItemGitBranch'
    \   ],
    \   'right': [
    \       '<',
    \       ['ff', 'fenc', 'ft'],
    \       'ruler',
    \   ],
    \ }
    let g:shadeline.inactive = {
    \   'left': [
    \       'fname',
    \       'flags',
    \   ],
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
