#!/bin/bash
#
# Create symbolic links.

cd ~

for fpath in dotfiles/home/.??*
do
  fname=$(basename "$fpath")

  if [ -e "$fname" ] && [ ! -h "$fname" ]; then
    echo -n 'backup) '
    mv -vf "$fname" "${fname}.bak"
  fi

  echo -n 'link) '
  ln -svnf "$fpath" "$fname"
done
