path=(
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
  ${path}
)

export EDITOR=vim

export GREP_COLOR=33          # matching text
export GREP_COLORS='mt=33'    # matching text
       GREP_COLORS+=':fn=34'  # file name
       GREP_COLORS+=':ln=34'  # line number
       GREP_COLORS+=':bn=34'  # byte number
       GREP_COLORS+=':se=30'  # separator

export LANG=en_US.UTF-8

export LESS='--ignore-case'
       LESS+=' --no-init'
       LESS+=' --QUIET'
       LESS+=' --quit-if-one-screen'
       LESS+=' --RAW-CONTROL-CHARS'
       LESS+=' --shift 4'
       LESS+=' --tabs=4'

export LSCOLORS=ex   # directory
       LSCOLORS+=fx  # symbolic link
       LSCOLORS+=cx  # socket
       LSCOLORS+=dx  # pipe
       LSCOLORS+=bx  # executable
       LSCOLORS+=Gx  # block special
       LSCOLORS+=Dx  # character special
       LSCOLORS+=Bx  # executable with setuid bit set
       LSCOLORS+=Gx  # executable with setgid bit set
       LSCOLORS+=Cx  # directory writable to others, with sticky bit
       LSCOLORS+=Dx  # directory writable to others, without sticky bit

export LS_COLORS='di=34'       # directory
       LS_COLORS+=':ln=35'     # symbolic link
       LS_COLORS+=':so=32'     # socket
       LS_COLORS+=':pi=33'     # pipe
       LS_COLORS+=':ex=31'     # executable
       LS_COLORS+=':bd=01;36'  # block special
       LS_COLORS+=':cd=01;33'  # character special
       LS_COLORS+=':su=01;31'  # executable with setuid bit set
       LS_COLORS+=':sg=01;36'  # executable with setgid bit set
       LS_COLORS+=':tw=01;32'  # directory writable to others, with sticky bit
       LS_COLORS+=':ow=01;33'  # directory writable to others, without sticky bit

export PAGER=less

# Go
export GOPRIVATE=github.com/obcat
path=(${HOME}/go/bin(N-/) ${path})

# FZF
if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND='fd --type f'
fi

export FZF_DEFAULT_OPTS='--height=60%'
       FZF_DEFAULT_OPTS+=' --layout=reverse'
       FZF_DEFAULT_OPTS+=' --border=sharp'
       FZF_DEFAULT_OPTS+=' --prompt='\''>>> '\'''
       FZF_DEFAULT_OPTS+=' --color='
       FZF_DEFAULT_OPTS+='fg:-1:regular'
       FZF_DEFAULT_OPTS+=',bg:-1'
       FZF_DEFAULT_OPTS+=',preview-fg:-1:regular'
       FZF_DEFAULT_OPTS+=',preview-bg:-1'
       FZF_DEFAULT_OPTS+=',hl:3:regular'
       FZF_DEFAULT_OPTS+=',fg+:-1:regular'
       FZF_DEFAULT_OPTS+=',bg+:-1'
       FZF_DEFAULT_OPTS+=',gutter:-1'
       FZF_DEFAULT_OPTS+=',hl+:3:regular'
       FZF_DEFAULT_OPTS+=',query:-1:regular'
       FZF_DEFAULT_OPTS+=',disabled:8:regular'
       FZF_DEFAULT_OPTS+=',info:4:regular'
       FZF_DEFAULT_OPTS+=',border:-1:regular'
       FZF_DEFAULT_OPTS+=',prompt:8:regular'
       FZF_DEFAULT_OPTS+=',pointer:-1:regular'
       FZF_DEFAULT_OPTS+=',marker:3:regular'
       FZF_DEFAULT_OPTS+=',spinner:-1:regular'
       FZF_DEFAULT_OPTS+=',header:4:regular'
       FZF_DEFAULT_OPTS+=' --no-bold'
       FZF_DEFAULT_OPTS+=' --preview-window=border-sharp'
