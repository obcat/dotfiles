autoload colors
autoload -Uz vcs_info

precmd() {
  vcs_info
}

# Prompt
untrackedstr='%F{blue}*%f'
unstagedstr='%F{yellow}*%f'
stagedstr='%F{green}*%f'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%b%m%u%c]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr $unstagedstr
zstyle ':vcs_info:git:*' stagedstr $stagedstr
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep -m 1 '^??' &> /dev/null
  then
    hook_com[misc]=$untrackedstr
  else
    hook_com[misc]=''
  fi
}

setopt PROMPT_SUBST
PROMPT='%F{cyan}%1d %#%f '
RPROMPT='${vcs_info_msg_0_}'

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Completion
autoload -Uz compinit
compinit

# Aliases
## Colorized output
alias ls='ls -G'
alias la='ls -Ga'
alias ll='ls -Gal'
alias tree='tree -C'

## Confirm before overwrite
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
