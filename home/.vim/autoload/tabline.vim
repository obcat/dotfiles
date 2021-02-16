function tabline#global() abort
  return s:labels() . s:fill()
endfunction

function s:labels() abort
  let labels = map(range(1, tabpagenr('$')), 's:label(v:val)')
  return join(labels, '')
endfunction

function s:label(tabnr) abort
  let activity = a:tabnr == tabpagenr() ? 'active' : 'inactive'
  return s:label_{activity}(a:tabnr)
endfunction

let s:padding_0 = '   '
let s:padding_1 = ' @ '
let s:minwidth = 16
let s:maxwidth = 16

function s:label_active(tabnr) abort
  let bufnr = s:currentbufnr(a:tabnr)
  " NOTE: "+= ... join" is faster than ".= ..."
  let l = []
  let l += ['%#TabLineSel#']
  let l += ['%' . a:tabnr . 'T']
  let l += [s:padding_0]
  let l += [s:bufname(bufnr) ->s:center(s:minwidth) ->s:truncate(s:maxwidth) ->s:escape()]
  let l += ['%#TabLineSelMod#']
  let l += [s:padding_{getbufvar(bufnr, '&modified')}]
  return join(l, '')
endfunction

function s:label_inactive(tabnr) abort
  let l = []
  let l += ['%#TabLine#']
  let l += ['%' . a:tabnr . 'T']
  let l += [s:padding_0]
  let l += [s:bufname(s:currentbufnr(a:tabnr)) ->s:center(s:minwidth) ->s:truncate(s:maxwidth) ->s:escape()]
  let l += [s:padding_0]
  return join(l, '')
endfunction

function s:fill() abort
  let f = []
  let f += ['%#TabLineFill#']
  let f += ['%T']
  let f += ['%=']
  let f += [' ']
  let f += [s:gitinfo() ->s:escape()]
  let f += [' ']
  return join(f, '')
endfunction

function s:currentbufnr(tabnr) abort
  return tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]
endfunction

function s:bufname(bufnr) abort
  let bufinfo = getbufinfo(a:bufnr)[0]
  if !empty(bufinfo.name)
    let trimmed = trim(bufinfo.name, '/', 2)
    return empty(trimmed) ? bufinfo.name : fnamemodify(trimmed, ':t')
  endif
  let wininfo = getwininfo(bufinfo.windows[0])[0]
  if wininfo.quickfix
    return gettext(wininfo.loclist ? '[Location List]' : '[Quickfix List]')
  endif
  let buftype = getbufvar(a:bufnr, '&buftype')
  if index(['nofile', 'acwrite', 'terminal'], buftype) >= 0
    return gettext('[Scratch]')
  elseif buftype is 'prompt'
    return gettext('[Prompt]')
  elseif buftype is 'popup'
    return gettext('[Popup]')
  endif
  return gettext('[No Name]')
endfunction

function s:gitinfo() abort
  let info = [
    \ 'gina#component#repo#preset()',
    \ 'gina#component#status#preset()',
    \ 'gina#component#traffic#preset()',
    \]
  call map(info, 'trim(s:safe(v:val))')
  call filter(info, '!empty(v:val)')
  return join(info, ' ')
endfunction

function s:safe(expr) abort
  try
    return eval(a:expr)
  catch
    return 'error'
  endtry
endfunction

function s:center(string, minwidth)
  let strwidth = strwidth(a:string)
  if a:minwidth <= strwidth
    return a:string
  endif
  let left  = (a:minwidth - strwidth) / 2
  let right = a:minwidth - (left + strwidth)
  return repeat(' ', left) . a:string . repeat(' ', right)
endfunction

function s:truncate(string, maxwidth, symbol = '>')
  if strwidth(a:string) <= a:maxwidth
    return a:string
  endif
  return printf('%.*S%s', a:maxwidth - strwidth(a:symbol), a:string, a:symbol)
endfunction

function s:escape(string) abort
  return substitute(a:string, '%', '%%', 'g')
endfunction
