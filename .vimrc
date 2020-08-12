"   __  __ _ _____ _________
"   \ \ | |_|     V  __/  __|
"    \ \| | | | | | |  | [__
" [_] \___|_|_|_|_|_|  \____|

" Encoding {{{
set encoding=utf-8   " Vimが内部で使用する文字コード
scriptencoding utf-8 " スクリプトで使用されている文字コードの宣言
" }}}

" プラグインのセットアップ {{{
" vim-plugがなければインストール
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" プラグインのリスト
call plug#begin()
Plug 'junegunn/vim-plug'      " vim-plugのヘルプページを取得するために必要？
Plug 'vim-jp/vimdoc-ja'       " 日本語版のヘルプページ
Plug 'cocopon/iceberg.vim'    " カラースキーム
Plug 'itchyny/lightline.vim'  " ステータスラインをリッチに
Plug 'tpope/vim-fugitive'     " Vim上でGitを使う
Plug 'airblade/vim-gitgutter' " Gitのステータスを行番号の横に表示
Plug 'cohama/lexima.vim'      " 閉じ括弧の自動補完
call plug#end()

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
set noshowmode              " 最終行に--挿入--といったメッセージを表示しない
set background=dark         " Vimに背景色を伝える
set list                    " タブや改行を表示する
set listchars=tab:▸\ ,eol:¬ " listが有効なときに使う文字
set cursorline              " カーソル行をハイライト
set ambiwidth=double        " 一部の特殊な文字の表示幅
set display=lastline        " ウィンドウの最後の行が収まらないときの表示形式

" インデント
filetype indent on " ファイル形式別インデントのロードを有効化
set autoindent     " 直前の行から新しい行のインデントを得る
set smartindent    " C言語等で有効な高度な自動インデント
set expandtab      " タブで空白を入力
set tabstop=4      " タブの表示幅
set shiftwidth=4   " 自動インデントに使われる空白の数
set smarttab       " shiftwidthの数だけタブで空白を挿入しBSで空白を削除する
set backspace=2    " インサートモードにおけるBSやDelの挙動

" 検索
set hlsearch  " 最後に検索したパターンをハイライト
set incsearch " 検索パターン入力中にその文字をハイライト

" バックアップ
set directory=$HOME/.vim/swap " swapファイルの保存先
set undodir=$HOME/.vim/undo   " undoファイルの保存先

" ファイルの取り扱い
set updatetime=100 " この時間だけ入力がなければswapファイルを更新
set autoread       " Vimの外部での変更を自動的に読み込む
set hidden         " バッファをabandonするときhidden状態にする

" その他
set helplang=ja                   " ヘルプページで優先して使用する言語のリスト
set belloff=all                   " ベルを鳴らさないようにするイベントの指定
set clipboard=unnamed,unnamedplus " デフォルトのレジスタ
autocmd FileType vim setlocal foldmethod=marker
" }}}

" カラースキーム {{{
" カラースキームのオーバーライド用関数
function! s:OverrideColorscheme() abort
    if g:colors_name == 'iceberg' && &background == 'dark'
        hi MatchParen ctermbg=242 ctermfg=255  guibg=#3e445e guifg=#ffffff
        hi Visual     ctermbg=239 ctermfg=NONE guibg=#272c42 guifg=NONE
    endif
endfunction

" カラースキームを読み込むたびにオーバーライドを実行
autocmd ColorScheme * call s:OverrideColorscheme()

" カラースキームの指定
colorscheme iceberg
" }}}

" キーマッピング {{{
" USキーボード用
" noremap ; :
" vnoremap ; :

" ウィンドウ間の移動
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Emacs風キーバインド
" cnoremap <C-a> <Home>
" cnoremap <C-b> <Left>
" cnoremap <C-d> <Del>
" cnoremap <C-e> <End>
" cnoremap <C-f> <Right>
" cnoremap <C-h> <Backspace>
" cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos() - 2]<CR>
" inoremap <C-a> <Home>
" inoremap <C-b> <Left>
" inoremap <C-d> <Del>
" inoremap <C-e> <End>
" inoremap <C-f> <Right>
" inoremap <C-h> <Backspace>
" inoremap <C-k> <C-o>D
" inoremap <C-n> <Down>
" inoremap <C-p> <Up>

" その他
" nnoremap Y y$
" }}}

" プラグインの設定 {{{
" lightline
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" }}}
