function foldtext#global() abort
  let tabstop = repeat(' ', &tabstop)
  return substitute(getline(v:foldstart), '\t', tabstop, 'g')
endfunction
