if empty(glob('~/.vim/autoload/plug.vim')) " vim-plugがなければインストール
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/vim-plug'          " vim-plugのヘルプページを取得するために必要？
Plug 'vim-jp/vimdoc-ja'           " 日本語版のヘルプページ
Plug 'tpope/vim-fugitive'         " Vim上でGitを使う
Plug 'airblade/vim-gitgutter'     " git diffを行番号の横に表示
Plug 'cocopon/iceberg.vim'        " カラースキーム
Plug 'itchyny/lightline.vim'      " ステータスラインをリッチに
Plug 'cohama/lexima.vim'          " 閉じ括弧の自動補完
call plug#end()

syntax on                         " シンタックスハイライトを有効化
filetype plugin indent on         " ファイルタイプに基づいたインデントを有効化
set autoindent                    " 直前の行から新しい行のインデントを得る
set smartindent                   " C言語等で有効な高度な自動インデント
set expandtab                     " <Tab>でスペースを入力
set tabstop=4                     " <Tab>の表示幅
set shiftwidth=4                  " 自動インデントに使われるスペースの数
set backspace=2                   " 多くのターミナルでバックスペースの挙動を修正
set number                        " 行番号を表示
set cursorline                    " カーソル行をハイライト
set showcmd                       " 入力中のコマンドをスクリーン右下に表示
set laststatus=2                  " ステータスラインを常に表示
set nowrap                        " 行の折り返しを禁止
set foldmethod=indent             " インデントベースでコードを折りたたむ
set nofoldenable                  " すべての折りたたみを開いた状態でファイルを開く
set wildmode=list:longest,full    " <Tab>による補完の動作設定
set hlsearch                      " 最後に検索したパターンをハイライト
set incsearch                     " 検索パターン入力中にその文字をハイライト
set clipboard=unnamed,unnamedplus " システムのクリップボードに対応するレジスタ（""または"+）をデフォルトのレジスタにする
set helplang=ja                   " ヘルプページで優先して使用する言語のリスト
set hidden                        " バッファを放棄（abandon）するとき隠れ（hidden）状態にする（メモリを開放しないということ）. これで変更が未保存でも怒られなくなる
set noshowmode                    " 最終行に--挿入--といったメッセージを表示しない
set list                          " <Tab>や<EOL>を表示する
set listchars=eol:¬,tab:▸\        " 'list'が有効なときに使う文字
set updatetime=100                " この時間だけ入力がなければswapファイルを更新
set directory=$HOME/.vim/swap     " swapファイルの保存先
set undodir=$HOME/.vim/undo       " undoファイルの保存先

" Vimに背景色を教えてあげる
set background=dark
" カラースキームのオーバーライド用関数
function! s:OverrideColorscheme() abort
    if g:colors_name == 'iceberg' && &background == 'dark'
        hi MatchParen ctermbg=242 ctermfg=255  guibg=#3e445e guifg=#ffffff
        hi Visual     ctermbg=239 ctermfg=NONE guibg=#272c42 guifg=NONE
    endif
endfunction
" カラースキーム読み込み後にオーバーライドを実行
autocmd ColorScheme * call s:OverrideColorscheme()
" カラースキームの指定
colorscheme iceberg

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

" USキーボード用
noremap ; :
vnoremap ; :
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
" DやCと一貫性をもたせる
nnoremap Y y$
