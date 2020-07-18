#!/bin/bash

# .??* とすることでカレントディレクトリ（.）と親ディレクトリ（..）を除外
for f in .??*
do
    [[ "$f" == ".git" ]]      && continue
    [[ "$f" == ".DS_Store" ]] && continue

    # -s ：シンボリックリンクをつくる
    # -fn：リンクファイルと同じ名前のファイルまたはディレクトリがあったら上書きする
    # -v ：処理の経過を表示する
    ln -sfnv ~/dotfiles/${f} ${HOME}/${f}
done
