function my#ctrlp#set_options() abort
  let half = &lines / 2
  let g:ctrlp_match_window = printf('order:ttb,min:%d,max:%d', half, half)
endfunction
