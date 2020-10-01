#           __
#  ___ ___ / /  ________
# /_ /(_-</ _ \/ __/ __/
# /__/___/_//_/_/  \__/

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
case $(ls --version 2>/dev/null) in
  *GNU*)
    LS_COLOR_OPT='--color=always'
    ;;
  *) # BSD version on macOS assumed
    LS_COLOR_OPT='-G'
    ;;
esac

alias ls="ls -F ${LS_COLOR_OPT}"
alias la='ls -a'
alias ll='ls -al'
alias grep='grep --color=auto'
alias tree='tree -C'

alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'

alias so=source

#-------------------------------------------------------------------------------
# Completion
#-------------------------------------------------------------------------------
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#-------------------------------------------------------------------------------
# History
#-------------------------------------------------------------------------------
setopt SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#-------------------------------------------------------------------------------
# Key bindings
#-------------------------------------------------------------------------------
bindkey -e
bindkey '^n' history-beginning-search-forward-end
bindkey '^p' history-beginning-search-backward-end

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz colors && colors

NONE="%{${reset_color}%}"
GREEN="%{${fg_no_bold[green]}%}"
YELLOW="%{${fg_no_bold[yellow]}%}"
BLUE="%{${fg_no_bold[blue]}%}"
MAGENTA="%{${fg_no_bold[magenta]}%}"
CYAN="%{${fg_no_bold[cyan]}%}"

UNTRACKED_STR="${BLUE}*${NONE}"
UNSTAGED_STR="${YELLOW}*${NONE}"
STAGED_STR="${GREEN}*${NONE}"

+vi-git-untracked() {
  if git status --porcelain | grep -q '^??'; then
    hook_com[misc]=${UNTRACKED_STR}
  else
    hook_com[misc]=
  fi
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '[%b%m%u%c]'
zstyle ':vcs_info:git:*' actionformats '[%b|%a]'
zstyle ':vcs_info:git:*' unstagedstr ${UNSTAGED_STR}
zstyle ':vcs_info:git:*' stagedstr ${STAGED_STR}
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

insert_break() {
  if [[ -z ${INSERT_BREAK_ACTIVATED} ]]; then
    INSERT_BREAK_ACTIVATED=1
    return 0
  fi

  printf '\n'
}

vcs_info_improved() {
  if [[ ${PWD}/ == */.git/* ]]; then
    vcs_info_msg_0_='[?]'
    return 0
  fi

  vcs_info
}

add-zsh-hook -Uz precmd insert_break
add-zsh-hook -Uz precmd vcs_info_improved

if [[ -z ${SSH_CONNECTION} ]]; then
  PROMPT="${CYAN}%1d %#${NONE} "
else
  PROMPT="${MAGENTA}%1d %#${NONE} "
fi

setopt PROMPT_SUBST
RPROMPT='${vcs_info_msg_0_}'

#-------------------------------------------------------------------------------
# Misc
#-------------------------------------------------------------------------------
setopt NO_BEEP

#-------------------------------------------------------------------------------
# Local settings
#-------------------------------------------------------------------------------
if [[ -r ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi
