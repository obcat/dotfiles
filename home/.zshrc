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

alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'

alias pw=pwd
alias so=source

(( ${+commands[tmux]} )) && alias tm=tmux
(( ${+commands[tree]} )) && alias tree='tree -C'

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

# https://www.zsh.org/mla/users/2002/msg00798.html
no_autoremove() {
  LBUFFER=${LBUFFER}${KEYS}
}
zle -N no_autoremove
bindkey ' ' no_autoremove
bindkey '&' no_autoremove
bindkey ';' no_autoremove
bindkey '|' no_autoremove

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

UNTRACKED_STR='%F{blue}*%f'
UNSTAGED_STR='%F{yellow}*%f'
STAGED_STR='%F{green}*%f'

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

vcs_info_improved() {
  if [[ ${PWD}/ == */.git/* ]]; then
    vcs_info_msg_0_='[?]'
    return 0
  fi

  vcs_info
}

add-zsh-hook -Uz precmd vcs_info_improved

if [[ -z ${SSH_CONNECTION} ]]; then
  PROMPT='%F{magenta}%1d %#%f '
else
  PROMPT='%F{cyan}%1d %#%f '
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
