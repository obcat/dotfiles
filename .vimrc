packloadall                       " startディレクトリ配下のプラグインをすべてロードする
silent! helptags ALL              " すべてのプラグインのヘルプページを出力やエラーを隠しながらロードする

syntax on                         " シンタックスハイライトを有効化
filetype plugin indent on         " ファイルタイプに基づいたインデントを有効化
set autoindent                    " 新しい行を始めるときに自動でインデント
set expandtab                     " タブをスペースに変換
set tabstop=4                     " タブをスペース4文字とカウント
set shiftwidth=4                  " 自動インデントに使われるスペースの数
set backspace=2                   " 多くのターミナルでバックスペースの挙動を修正
set number                        " 行番号を表示
set cursorline                    " カーソル行をハイライト
set showcmd                       " 入力中のコマンドをスクリーン右下に表示
set laststatus=2                  " ステータスラインを常に表示
set nowrap                        " 行の折り返しを禁止
set foldmethod=indent             " インデントベースでコードを折りたたむ
set wildmenu                      " 自動補完のときに利用できるワイルドメニューを有効化
set wildmode=list:longest,full    " 1回目のタブ: 共通する最長部分まで補完してから候補をリスト表示
""""""""""""""""""""""""""""""    " 2回目以降のタブ: タブを押すごとに次のマッチを補完. ワイルドメニューも表示する
set hlsearch                      " 検索するときにマッチした文字をすべてハイライトする
set incsearch                     " インクリメンタルサーチを有効化
set clipboard=unnamed,unnamedplus " システムのクリップボードに対応するレジスタ（""または"+）をデフォルトのレジスタにする
set helplang=ja                   " ヘルプページで優先して使用する言語のリスト

set background=dark               " 暗い背景によく合う色を使うようVimにお願いする
" let g:solarized_termcolors=256    " カラースキームsolarized用の設定
colorscheme iceberg               " カラースキームの指定

set swapfile                      " swapファイルの一時的な作成を許可
set directory=$HOME/.vim/swap     " swapファイルの保存先
" set undofile                      " undoファイルの永続的な作成を許可
set undodir=$HOME/.vim/undo       " undoファイルの保存先

let g:previm_open_cmd = 'open -a Google\ Chrome' " プラグインprevimのコマンド:PrevimOpenで開くブラウザ
