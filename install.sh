#!/bin/bash
#
# Create symbolic links.

cd ~

readonly VIRTUAL_HOME='dotfiles/home'

rename_or_remove_if_exist() {
  if [[ -e "$1" ]]; then
    if [[ -h "$1" ]]; then
      rm "$1"
    else
      rename_or_remove_if_exist "${1}.bak"

      echo -n 'backup) '
      mv -v "$1" "${1}.bak"
    fi
  fi
}

for fpath in "${VIRTUAL_HOME}"/.??*
do
  fname=$(basename "${fpath}")

  if [[ "${fname}" == '.??*' ]]; then
    echo "error: no dotfiles in ~/${VIRTUAL_HOME}" 1>&2
    exit 1
  fi

  rename_or_remove_if_exist "${fname}"

  echo -n 'link) '
  ln -sv "${fpath}" "${fname}"
done
