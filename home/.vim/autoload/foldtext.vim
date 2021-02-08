function foldtext#global() abort
  let tabstop = repeat("\<Space>", &tabstop)
  return substitute(getline(v:foldstart), "\<Tab>", tabstop, 'g')
endfunction
