vim9script

def my#smoothscroll#up()
  SmoothScroll(true)
enddef

def my#smoothscroll#down()
  SmoothScroll(false)
enddef

# Thank you aonemd.
def SmoothScroll(up: bool)
  const key = up ? "\<C-y>" : "\<C-e>"
  execute 'normal!' key
  redraw
  for i in range(1, winheight(0), 4)
    sleep 7m
    execute 'normal!' key
    redraw
  endfor
enddef
