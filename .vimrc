if empty(glob('~/.vim/autoload/plug.vim'))                                " vim-plugがなければインストール
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()                 " vim-plugでのプラグイン管理を開始
Plug 'junegunn/vim-plug'          " vim-plugのヘルプページを取得するために必要？
Plug 'vim-jp/vimdoc-ja'           " 日本語版のヘルプページ
Plug 'tpope/vim-fugitive'         " Vim上でGitを使う
Plug 'airblade/vim-gitgutter'     " git diffを行番号の横に表示
Plug 'itchyny/lightline.vim'      " ステータスラインをリッチに
call plug#end()                   " vim-plugでのプラグイン管理を終了

set updatetime=100                " swapファイルの更新周期（vim-gitgutterの推奨設定）

syntax on                         " シンタックスハイライトを有効化
filetype plugin indent on         " ファイルタイプに基づいたインデントを有効化
set autoindent                    " 新しい行を始めるときに自動でインデント
set smartindent                   " 新しい行を始めるときに高度な自動インデントを行う
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
set nofoldenable                  " すべての折りたたみを開いた状態でファイルを開く
" set wildmenu                      " ワイルドメニューを有効化
set wildmode=list:longest,full    " 1回目のタブ: 共通する最長部分まで補完してから候補をリスト表示
                                  " 2回目以降のタブ: タブを押すごとに次のマッチを補完. またワイルドメニューが有効なら表示する
set hlsearch                      " 検索するときにマッチした文字をすべてハイライトする
set incsearch                     " インクリメンタルサーチを有効化
set clipboard=unnamed,unnamedplus " システムのクリップボードに対応するレジスタ（""または"+）をデフォルトのレジスタにする
set helplang=ja                   " ヘルプページで優先して使用する言語のリスト
set hidden                        " バッファを放棄（abandon）するとき隠れ（hidden）状態にする（メモリを開放しないということ）. これにより変更が未保存でも怒られなくなる
set noshowmode                    " 最終行に--挿入--といったメッセージを表示しない（lightline.vimにより不要になったため）

set background=dark               " 暗い背景によく合う色を使うようVimにお願いする
colorscheme iceberg               " カラースキームの指定

set swapfile                      " swapファイルの一時的な作成を許可
set directory=$HOME/.vim/swap     " swapファイルの保存先
" set undofile                      " undoファイルの永続的な作成を許可
set undodir=$HOME/.vim/undo       " undoファイルの保存先

" Vimスパルタモード
map <left> <nop>
map <up> <nop>
map <right> <nop>
map <down> <nop>
