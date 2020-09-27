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

add_suffix() {
  if [[ $# -ne 2 ]]; then
    echo "${FUNCNAME[0]}: Exactly 2 arguments required" 1>&2
    return 1
  fi

  local file=$1
  local suffix=$2

  if [[ ! -e ${file} ]]; then
    echo "${FUNCNAME[0]}: ${file}: No such file or directory" 1>&2
    return 1
  fi

  if [[ -e ${file}${suffix} ]]; then
    add_suffix "${file}${suffix}" "${suffix}"
  fi

  mv "${file}" "${file}${suffix}"
  echo "renamed: ${file} -> ${file}${suffix}"
}

printf "${BOLD}%s${NONE}\n" 'Creating symbolic links...'

for fpath in "${VIRTUAL_HOME}"/.??*; do
  fname=$(basename "${fpath}")

  if [[ ${fname} == '.??*' ]]; then
    printf 1>&2 "${BOLD}${RED}%s: ${NONE}%s\n" \
      Error "No dotfiles in ~/${VIRTUAL_HOME}."
    exit 1
  fi

  if [[ -h ${fname} ]] && [[ $(readlink "${fname}") == ${fpath} ]]; then
    echo "symlink: already exists: ${fname} -> ${fpath}"
    continue
  fi

  if [[ -e ${fname} ]]; then
    add_suffix "${fname}" '.bak'
  fi

  ln -s "${fpath}" "${fname}"
  echo "symlink: created: ${fname} -> ${fpath}"
done

printf "${BOLD}%s${NONE}\n" "It's done!"
