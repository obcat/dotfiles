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
Plug 'cocopon/iceberg.vim'        " カラースキーム
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
set list                          "
set listchars=eol:¬,tab:▸\        "

" 暗い背景によく合う色を使うようVimにお願いする
set background=dark
" カラースキームのオーバーライド用関数
function! OverrideColorscheme() abort
    if execute('colorscheme') == 'iceberg' && &background == 'dark'
        hi MatchParen ctermbg=242 ctermfg=255  guibg=#3e445e guifg=#ffffff
        hi Visual     ctermbg=239 ctermfg=NONE guibg=#272c42 guifg=NONE
    endif
endfunction
" カラースキーム読み込み後にオーバーライドを実行
autocmd ColorScheme * call OverrideColorscheme()
" lightline.vimにカラースキームを教えてあげる
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ }
" カラースキームの指定
colorscheme iceberg

set swapfile                      " swapファイルの一時的な作成を許可
set directory=$HOME/.vim/swap     " swapファイルの保存先
" set undofile                      " undoファイルの永続的な作成を許可
set undodir=$HOME/.vim/undo       " undoファイルの保存先

" USキーボード用
noremap ; :
" ウィンドウ間の移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Emacs風キーバインド
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-h> <Backspace>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos() - 2]<CR>
inoremap <C-a> <Home>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-h> <Backspace>
inoremap <C-k> <C-o>D
inoremap <C-n> <Down>
inoremap <C-p> <Up>
