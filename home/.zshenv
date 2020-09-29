export EDITOR=vim
export LANG=en_US.UTF-8
       LESS='--ignore-case --no-init --QUIET --quit-if-one-screen'
export LESS="${LESS} --RAW-CONTROL-CHARS --shift 4 --tabs=4"
export PAGER=less

export GREP_COLOR=33  # BSD
export GREP_COLORS='mt=33:fn=34:ln=34:bn=34:se=30'  # GNU

# GNU
       LS_COLORS='di=34':   # directory
       LS_COLORS+='ln=35':  # symbolic link
       LS_COLORS+='so=32':  # socket
       LS_COLORS+='pi=33':  # pipe
       LS_COLORS+='ex=31':  # executable
       LS_COLORS+='bd=36':  # block special
       LS_COLORS+='cd=33':  # character special
       LS_COLORS+='su=31':  # executable with setuid bit set
       LS_COLORS+='sg=36':  # executable with setgid bit set
       LS_COLORS+='tw=32':  # directory writable to others, with sticky bit
       LS_COLORS+='ow=33':  # directory writable to others, without sticky bit
export LS_COLORS
# BSD
       LSCOLORS=ex   # directory
       LSCOLORS+=fx  # symbolic link
       LSCOLORS+=cx  # socket
       LSCOLORS+=dx  # pipe
       LSCOLORS+=bx  # executable
       LSCOLORS+=gx  # block special
       LSCOLORS+=dx  # character special
       LSCOLORS+=bx  # executable with setuid bit set
       LSCOLORS+=gx  # executable with setgid bit set
       LSCOLORS+=cx  # directory writable to others, with sticky bit
       LSCOLORS+=dx  # directory writable to others, without sticky bit
export LSCOLORS
