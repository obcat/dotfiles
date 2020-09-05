#!/bin/bash

for f in .??*
do
    [[ ${f} == '.git' ]]       && continue
    [[ ${f} == '.DS_Store'  ]] && continue

    rm -r ${HOME}/${f}
    ln -snv ~/dotfiles/${f} ${HOME}/${f}
done
