vim9script


def my#difforig()
  if !&modified
    echomsg 'No change since last save'
    return
  endif

  vertical new
  setlocal buftype=nofile
  read ++edit %%
  :0 delete _
  diffthis
  wincmd p
  diffthis
enddef


def my#auto_mkdir(dir: string)
  if isdirectory(dir)
    return
  endif
  const msg = printf('"%s" does not exist. Create?', strtrans(dir))
  const choices = join(['&Yes', '&No'], "\n")
  var choice: number
  try #                            ┌ No
    choice = confirm(msg, choices, 2, 'Question')
  catch /^Vim:Interrupt$/
  endtry
  redraw # avoid hit-enter prompt
  if choice == 1 # Yes
    mkdir(dir, 'p')
  endif
enddef
