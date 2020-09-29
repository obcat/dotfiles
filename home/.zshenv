export EDITOR=vim
export LANG=en_US.UTF-8
       LESS='--ignore-case --no-init --QUIET --quit-if-one-screen'
export LESS="${LESS} --RAW-CONTROL-CHARS --shift 4 --tabs=4"
export PAGER=less

case $(grep -V) in
  *BSD*)
    export GREP_COLOR=33
    ;;
  *GNU*)
    export GREP_COLORS='mt=33:fn=34:ln=34:bn=34:se=30'
    ;;
esac
