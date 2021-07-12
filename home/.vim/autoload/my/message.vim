vim9script


def my#message#error(msg: string)
  Echomsg(msg, 'ErrorMsg')
enddef


def Echomsg(msg: string, hl = 'None')
  execute 'echohl' hl
  try
    for line in split(msg, "\n")
      echomsg line
    endfor
  finally
    echohl None
  endtry
enddef
