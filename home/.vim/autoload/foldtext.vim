function! foldtext#foldtext() abort
  let tabstop = "\<Space>" ->repeat(&tabstop)
  return getline(v:foldstart) ->substitute('\t', tabstop, 'g')
endf
