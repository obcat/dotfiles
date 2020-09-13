#!/bin/bash
#
# Create symbolic links.

cd ~

virtualhome='dotfiles/home'

for fpath in "${virtualhome}"/.??*
do
  fname=$(basename "${fpath}")

  if [ "${fname}" = '.??*' ]; then
    echo "error: no dotfiles in ~/${virtualhome}/" 1>&2
    break
  fi

  if [ -e "${fname}" ] && [ ! -h "${fname}" ]; then
    echo -n 'backup) '
    mv -vf "${fname}" "${fname}.bak"
  fi

  echo -n 'link) '
  ln -svnf "${fpath}" "${fname}"
done
