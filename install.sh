#!/bin/bash
#
# Create symbolic links.

cd ~

readonly VIRTUAL_HOME='dotfiles/home'

rename_or_remove_if_exist() {
  [[ ! -e "$1" ]] && return 0

  if [[ -h "$1" ]]; then
    rm "$1"
  else
    rename_or_remove_if_exist "${1}.bak"

    echo -n 'backup) '
    mv -v "$1" "${1}.bak"
  fi
}

printf '\e[1m%s\e[0m\n' 'Creating symbolic links...'

for fpath in "${VIRTUAL_HOME}"/.??*
do
  fname=$(basename "${fpath}")

  if [[ "${fname}" == '.??*' ]]; then
    { printf '\e[1;31m%s\e[0m' 'Error: '
      echo "No dotfiles in ~/${VIRTUAL_HOME}."; } 1>&2
    exit 1
  fi

  rename_or_remove_if_exist "${fname}"

  echo -n 'link) '
  ln -sv "${fpath}" "${fname}"
done

printf '\e[1m%s\e[0m\n' "It's done!"
