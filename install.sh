#!/bin/bash
#
# Create symbolic links.

cd ~

VIRTUAL_HOME=dotfiles/home

LC='\033['
RC=m
NONE=${LC}00${RC}
BOLD=${LC}01${RC}
RED=${LC}31${RC}

remove_symlink_rename_otherwise() {
  if [[ ! -e $1 ]]; then
    echo "${FUNCNAME[0]}: ${1}: No such file or directory" 1>&2
    return 1
  fi

  if [[ -h $1 ]]; then
    rm "$1"
    echo "removed) $1"
  else
    [[ -e ${1}.bak ]] && remove_symlink_rename_otherwise "${1}.bak"

    mv "$1" "${1}.bak"
    echo "renamed) $1 -> ${1}.bak"
  fi
}

printf "${BOLD}%s${NONE}\n" 'Creating symbolic links...'

for fpath in "${VIRTUAL_HOME}"/.??*; do
  fname=$(basename "${fpath}")

  if [[ ${fname} == '.??*' ]]; then
    printf 1>&2 "${BOLD}${RED}%s: ${NONE}%s\n" \
      Error "No dotfiles in ~/${VIRTUAL_HOME}."
    exit 1
  fi

  [[ -e ${fname} ]] && remove_symlink_rename_otherwise "${fname}"

  ln -s "${fpath}" "${fname}"
  echo "newlink) ${fname} -> ${fpath}"
done

printf "${BOLD}%s${NONE}\n" "It's done!"
