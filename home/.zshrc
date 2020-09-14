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

#-------------------------------------------------------------------------------
# Completion
#-------------------------------------------------------------------------------
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#-------------------------------------------------------------------------------
# History
#-------------------------------------------------------------------------------
setopt share_history

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
bindkey "^n" history-beginning-search-forward-end
bindkey "^p" history-beginning-search-backward-end

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
autoload -Uz vcs_info

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
  test "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = true \
  && git status --porcelain | grep -m 1 '^??' &> /dev/null

  if [ "$?" -eq 0 ]; then
    hook_com[misc]=${untrackedstr}
  else
    hook_com[misc]=
  fi
}

precmd() { vcs_info; }
setopt prompt_subst

if [ "${SSH_CONNECTION}" ]; then
  PROMPT='%F{yellow}%1d %#%f '
else
  PROMPT='%F{cyan}%1d %#%f '
fi

RPROMPT='${vcs_info_msg_0_}'

#-------------------------------------------------------------------------------
# Misc
#-------------------------------------------------------------------------------
setopt no_beep

#-------------------------------------------------------------------------------
# Local settings
#-------------------------------------------------------------------------------
test -s ~/.zshrc_local && source "$_"
