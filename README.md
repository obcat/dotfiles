# dotfiles

## インストール方法

### dotfiles

1. ホームディレクトリに移動
    ```
    $ cd
    ```
    
1. 本リポジトリをクローン
    ```
    $ git clone https://github.com/obcat/dotfiles.git
    ````

1. シンボリックリンク作成用のシェルスクリプトを実行
    ```
    $ ./dotfiles/install.sh
    ```

### Vim Plugins

1. Vim を起動し次のコマンドで Plugin manager をインストール

    ```
    :call PluginManagerInstall()
    ```

1. `vimrc` をリロード

    ```
    :so $MYVIMRC
    ```

1. 次のコマンドでプラグインをインストール

    ```
    :PlugInstall
    ```
