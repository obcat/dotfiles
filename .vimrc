"   __  __ _ _____ _________
"   \ \ | |_|     V  __/  __|
"    \ \| | | | | | |  | [__
" [_] \___|_|_|_|_|_|  \____|

" Encoding {{{
set encoding=utf-8   " Vimが内部で使用する文字コード
scriptencoding utf-8 " スクリプトで使用されている文字コードの宣言
" }}}

" プラグイン {{{
let s:plugin_manager_exists = !empty(glob('~/.vim/autoload/plug.vim'))

if s:plugin_manager_exists
    call plug#begin()
    Plug 'junegunn/vim-plug'      " プラグインを管理するプラグイン
    Plug 'vim-jp/vimdoc-ja'       " 日本語版のヘルプ
    Plug 'cocopon/iceberg.vim'    " カラースキーム
    Plug 'cocopon/shadeline.vim'  " シンプルなステータスライン
    Plug 'tpope/vim-fugitive'     " Vim上でGitを使う
    Plug 'airblade/vim-gitgutter' " Gitのステータスを行番号の横に表示
    Plug 'cohama/lexima.vim'      " 閉じ括弧の自動補完
    call plug#end()
endif

" ファイル形式別プラグインのロードを有効化
filetype plugin on
" }}}

" 基本設定 {{{
" 見た目
syntax on                   " シンタックスハイライトを有効化
set number                  " 行番号を表示
set laststatus=2            " ステータスラインを常に表示
set showcmd                 " 入力中のコマンドをスクリーン右下に表示
set wildmenu                " コマンドライン補完時にリッチなメニューを表示
set background=dark         " Vimに背景色を伝える
set list                    " タブや改行を表示する
set listchars=tab:▸\ ,eol:¬ " listが有効なときに使う文字
set cursorline              " カーソル行をハイライト
set ambiwidth=double        " 一部の特殊な文字の表示幅
set display=lastline        " ウィンドウの最後の行が収まらないときの表示形式
" if s:plugin_manager_exists
"     set noshowmode          " 最終行に--挿入--といったメッセージを表示しない
" endif

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
set virtualedit=block " フリーカーソルモードを有効にする場面
set backspace=2       " インサートモードにおけるBSやDelの挙動
set showmatch         " 閉じ括弧入力時に対応する開き括弧を知らせる

" 検索
set hlsearch  " 最後に検索したパターンをハイライト
set incsearch " 検索パターン入力中にその文字をハイライト

" バックアップ
set directory=$HOME/.vim/swap " swapファイルの保存先
set undodir=$HOME/.vim/undo   " undoファイルの保存先

" ファイルの取り扱い
set updatetime=100 " この時間だけ入力がなければswapファイルを更新
set autoread       " Vimの外部での変更を自動的に読み込む
set hidden         " バッファを放棄するときメモリを開放しない

" その他
set helplang=ja                   " ヘルプで優先して使用する言語のリスト
set sidescroll=1                  " 水平スクロールの刻み幅
set clipboard=unnamed,unnamedplus " デフォルトのレジスタ
autocmd FileType vim setlocal foldmethod=marker
" }}}

" カラースキーム {{{
" カラースキームのオーバーライド用関数
function! s:OverrideColorscheme() abort
    if g:colors_name == 'iceberg' && &background == 'dark'
        " hi MatchParen ctermbg=242 ctermfg=255  guibg=#3e445e guifg=#ffffff
        " hi Visual     ctermbg=239 ctermfg=NONE guibg=#272c42 guifg=NONE
    endif
endfunction

" カラースキームを読み込むたびにオーバーライド
autocmd ColorScheme * call s:OverrideColorscheme()

" カラースキームの指定
if s:plugin_manager_exists
    colorscheme iceberg
endif
" }}}

" キーマッピング {{{
" 折り返された行で直観的なカーソル移動を行う
noremap j gj
noremap k gk
" }}}

" プラグインの設定 {{{
if s:plugin_manager_exists
    " shadeline {{{
    let g:shadeline = {}
    let g:shadeline.active = {
    \   'left': [
    \       'fname',
    \       'flags',
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
    " }}}
endif
" }}}
