vim9script

def my#foldtext#get(): string
  const tabstop = repeat(' ', &tabstop)
  return substitute(getline(v:foldstart), '\t', tabstop, 'g')
enddef
