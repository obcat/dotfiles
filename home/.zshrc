#           __
#  ___ ___ / /  ________
# /_ /(_-</ _ \/ __/ __/
# /__/___/_//_/_/  \__/

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
# Colorized output
case ${OSTYPE} in
  darwin*)
    alias ls='ls -FG'
    ;;
  linux*)
    alias ls='ls -F --color'
    ;;
esac

alias la='ls -a'
alias ll='ls -al'
alias tree='tree -C'

# Confirm before overwrite
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'

alias so=source

#-------------------------------------------------------------------------------
# Completion
#-------------------------------------------------------------------------------
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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

untrackedstr='%F{blue}*%f'
unstagedstr='%F{yellow}*%f'
stagedstr='%F{green}*%f'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%b%m%u%c]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "${unstagedstr}"
zstyle ':vcs_info:git:*' stagedstr "${stagedstr}"
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if git status --porcelain | grep -q '^??'; then
    hook_com[misc]=${untrackedstr}
  else
    hook_com[misc]=
  fi
}

improved_vcs_info() {
  # Avoid errors in .git directory
  if [[ ${PWD}/ == */.git/* ]]; then
    vcs_info_msg_0_='[?]'
    return 1
  fi

  vcs_info
}

add-zsh-hook -Uz precmd improved_vcs_info

if [ "${SSH_CONNECTION}" ]; then
  PROMPT='%F{yellow}%1d %#%f '
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
[ -r ~/.zshrc_local ] && source ~/.zshrc_local
