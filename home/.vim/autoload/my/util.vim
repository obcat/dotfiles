function my#util#get_parent_directory() abort
  let dir = expand('%:p:h')
  let trimmed = trim(dir, '/', 2)
  return empty(trimmed) ? dir : (trimmed . '/')
endfunction
