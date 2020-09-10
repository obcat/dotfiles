#!/bin/bash
#
# Create symbolic links.

cd ~

for fpath in dotfiles/home/.??*
do
  fname=$(basename "$fpath")

  if { [ -f "$fname" ] || [ -d "$fname" ]; } && [ ! -h "$fname" ]; then
    echo -n 'backup) '
    mv -v "$fname" "${fname}.bak"
  fi

  echo -n 'link) '
  ln -svnfF "$fpath" "$fname"
done
