# dotfiles

## インストール方法

### dotfiles

1. ホームディレクトリに移動
    ```
    $ cd
    ```
    
1. Git がインストールされているか確認
    ```
    $ git --version
    ```
    
1. されてなければ `yum` とか `apt` で Git をインストール

1. 本リポジトリをクローン
    ```
    $ git clone https://github.com/obcat/dotfiles.git
    ````

1. dotfiles ディレクトリへ移動
    ```
    $ cd dotfiles
    ```

1. シンボリックリンク作成用のシェルスクリプトを実行
    ```
    $ ./install.sh
    ```

### Vim Plugins

1. Plugin manager をインストール

    ```
    $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
1. Vim を起動し次のコマンドでプラグインをインストール

    ```
    :PlugInstall
    ```

1. `.vimrc` を source

    ```
    :so $MYVIMRC
    ```
