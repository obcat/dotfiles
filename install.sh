#!/bin/bash

for f in .??*
do
    [[ ${f} == '.git' ]]       && continue
    [[ ${f} == '.gitignore' ]] && continue
    [[ ${f} == '.DS_Store'  ]] && continue

    ln -sfnv ~/dotfiles/${f} ${HOME}/${f}
done
