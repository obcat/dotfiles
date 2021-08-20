vim9script


def my#template#onloaded()
  silent keeppatterns :% substitute /<%=\(.\{-}\)%>/\=eval(trim(submatch(1)))/ge
  :1
  if search('<+CURSOR+>') >= 1
    normal! "_da<
  endif
enddef
