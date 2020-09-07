#!/bin/bash
#
# Create symbolic links.

for fpath in dotfiles/.??*
do
  fname=$(basename $fpath)

  [[ $fname == '.git' ]]      && continue
  [[ $fname == '.DS_Store' ]] && continue

  rm -r $fname 2> /dev/null
  ln -sv $fpath
done
