autoload colors
autoload -Uz vcs_info

precmd() {
    vcs_info
}

# Prompt
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%b%m%u%c]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{green}*%f"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}*%f"
setopt PROMPT_SUBST
PROMPT=$'%F{cyan}%1d %#%f '
RPROMPT='${vcs_info_msg_0_}'

# Completion
autoload -U compinit
compinit
