#!/bin/bash
#
# Create symbolic links.

cd ~

readonly VIRTUAL_HOME='dotfiles/home'

readonly LC='\033['
readonly RC='m'
readonly NONE="${LC}00${RC}"
readonly BOLD="${LC}01${RC}"
readonly RED="${LC}31${RC}"

rename_or_remove_if_exist() {
  [[ ! -e "$1" ]] && return 0
  [[   -h "$1" ]] && { rm "$1"; return 0; }

  rename_or_remove_if_exist "${1}.bak"

  echo -n 'backup) '
  mv -v "$1" "${1}.bak"
}

printf "${BOLD}%s${NONE}\n" 'Creating symbolic links...'

for fpath in "${VIRTUAL_HOME}"/.??*; do
  fname=$(basename "${fpath}")

  if [[ "${fname}" == '.??*' ]]; then
    printf 1>&2 "${BOLD}${RED}%s: ${NONE}%s\n" \
      'Error' "No dotfiles in ~/${VIRTUAL_HOME}."
    exit 1
  fi

  rename_or_remove_if_exist "${fname}"

  echo -n 'link) '
  ln -sv "${fpath}" "${fname}"
done

printf "${BOLD}%s${NONE}\n" "It's done!"
