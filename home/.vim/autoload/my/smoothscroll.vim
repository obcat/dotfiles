function my#smoothscroll#up()
  call s:smoothscroll(1)
endfunction

function my#smoothscroll#down() abort
  call s:smoothscroll(0)
endfunction

" Thank you aonemd.
function s:smoothscroll(up) abort
  let key = a:up ? "\<C-y>" : "\<C-e>"
  execute 'normal!' key
  redraw
  for i in range(1, winheight(0), 4)
    sleep 7m
    execute 'normal!' key
    redraw
  endfor
endfunction
