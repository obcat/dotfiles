#!/bin/bash
#
# Create symbolic links.

cd ~

virtual_home='dotfiles/home'

for dotfile_path in "${virtual_home}"/.??*
do
  dotfile_name=$(basename "${dotfile_path}")

  if [ "${dotfile_name}" = '.??*' ]; then
    echo "error: no dotfiles in ~/${virtual_home}/" 1>&2
    break
  fi

  if [ -e "${dotfile_name}" ] && [ ! -h "${dotfile_name}" ]; then
    if [ -d "${dotfile_name}.bak" ]; then
      rm -r "${dotfile_name}.bak"
    fi

    echo -n 'backup) '
    mv -vf "${dotfile_name}" "${dotfile_name}.bak"
  fi

  echo -n 'link) '
  ln -svnf "${dotfile_path}" "${dotfile_name}"
done
