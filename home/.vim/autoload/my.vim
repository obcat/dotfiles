vim9script

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
    call mkdir(dir, 'p')
  endif
enddef
