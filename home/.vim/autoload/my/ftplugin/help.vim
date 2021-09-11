vim9script


def my#ftplugin#help#K(lang: string)
  const cword = expand('<cword>')
  if cword == ''
    my#message#error('No identifier under cursor')
    return
  endif
  try
    execute printf('help %s@%s', cword, lang)
  catch /^Vim(help):\%(E149\|E661\): /
    my#message#error(v:exception[10 :])
  endtry
enddef
