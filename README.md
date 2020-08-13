# dotfiles

## インストール方法

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
    $ git clone https://github.com/igg-g/dotfiles.git
    ````

1. dotfiles ディレクトリへ移動
    ```
    $ cd dotfiles
    ```

1. シンボリックリンク作成用のシェルスクリプトを実行
    ```
    $ ./install.sh
    ```
