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
  if (( $# != 2 )); then
    echo "usage: ${FUNCNAME[0]} file suffix" 1>&2
    return 1
  fi

  local file=$1
  local suffix=$2

  if [[ ! -e ${file} && ! -h ${file} ]]; then
    echo "${FUNCNAME[0]}: ${file}: No such file or directory" 1>&2
    return 1
  fi
  if [[ -e ${file}${suffix} || -h ${file}${suffix} ]]; then
    add_suffix "${file}${suffix}" "${suffix}"
  fi

  mv "${file}" "${file}${suffix}" &&
  echo "renamed: ${file} -> ${file}${suffix}"
}


main() {
  printf "${BOLD}%s${NONE}\n" 'Creating symbolic links...'

  shopt -s nullglob
  fpaths=( "${VIRTUAL_HOME}"/.??* )

  if (( ${#fpaths[@]} == 0 )); then
    printf 1>&2 "${BOLD}${RED}%s: ${NONE}%s\n" \
      Error "No dotfiles in ~/${VIRTUAL_HOME}."
    exit 1
  fi

  for fpath in "${fpaths[@]}"; do
    fname=$(basename "${fpath}")

    if [[ -h ${fname} && $(readlink "${fname}") == ${fpath} ]]; then
      echo "symlink: already exists: ${fname} -> ${fpath}"
      continue
    fi

    # Note that "[[ -e file ]]" returns false if the file is a broken symbolic
    # link. Even such files should be backed up, so "[[ -e file || -h file ]]"
    # is used here.
    if [[ -e ${fname} || -h ${fname} ]]; then
      add_suffix "${fname}" '.bak'
    fi

    ln -s "${fpath}" "${fname}" &&
    echo "symlink: created: ${fname} -> ${fpath}"
  done

  printf "${BOLD}%s${NONE}\n" "It's done!"
}


main
