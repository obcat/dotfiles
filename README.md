# dotfiles インストール手順

## １．ホームディレクトリに移動する
`$ cd`

## ２．Git がインストールされているか確認する
`$ git --version`

## ３．されてなければ `yum` とか `apt` で Git をインストール

## ４．dotfiles をクローン
`$ git clone https://github.com/igg-g/dotfiles.git`

## ５．dotfiles ディレクトリへ移動
`$ cd dotfiles`

## ６．シンボリックリンク作成用のシェルスクリプトを実行
`$ ./install.sh`

## ７．ログインし直すなどして dotfiles を読み込ませておしまい
