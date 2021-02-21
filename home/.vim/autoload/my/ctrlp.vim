vim9script

def my#ctrlp#set_options()
  const half = &lines / 2
  g:ctrlp_match_window = printf('order:ttb,min:%d,max:%d', half, half)
enddef
