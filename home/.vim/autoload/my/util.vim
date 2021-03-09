vim9script

def my#util#get_parent_directory(): string
  const dir = expand('%:p:h')
  const trimmed = trim(dir, '/', 2)
  return trimmed == '' ? dir : (trimmed .. '/')
enddef
