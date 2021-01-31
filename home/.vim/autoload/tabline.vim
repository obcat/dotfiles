function tabline#global() abort
  return s:labels() . s:fill()
endfunction

function s:labels() abort
  return range(1, tabpagenr('$')) ->map('s:label(v:val)') ->join('')
endfunction

function s:label(tabnr) abort
  let activity = a:tabnr == tabpagenr() ? 'active' : 'inactive'
  return s:label_{activity}(a:tabnr)
endfunction

let s:padding = '   '
let s:modflag = ' @ '
let s:minwidth = 22 - len(s:padding) * 2

function s:label_active(tabnr) abort
  let bufnr = s:currentbufnr(a:tabnr)
  let l = ''
  let l .= '%#TabLineSel#'
  let l .= '%' . a:tabnr . 'T'
  let l .= s:padding
  let l .= s:bufname(bufnr) ->s:ctr(s:minwidth) ->s:esc()
  let l .= '%#TabLineSelMod#'
  let l .= getbufvar(bufnr, '&modified') ? s:modflag : s:padding
  return l
endfunction

function s:label_inactive(tabnr) abort
  let l = ''
  let l .= '%#TabLine#'
  let l .= '%' . a:tabnr . 'T'
  let l .= s:padding
  let l .= s:bufname(s:currentbufnr(a:tabnr)) ->s:ctr(s:minwidth) ->s:esc()
  let l .= s:padding
  return l
endfunction

function s:fill() abort
  let f = ''
  let f .= '%#TabLineFill#'
  let f .= '%T'
  return f
endfunction

function s:currentbufnr(tabnr) abort
  return tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]
endfunction

function s:bufname(bufnr) abort
  let bufinfo = getbufinfo(a:bufnr)[0]
  let bufname = bufinfo.name
  if !empty(bufname)
    return fnamemodify(bufname, ':t')
  endif
  let bufwinid = bufinfo.windows[0]
  let wininfo  = getwininfo(bufwinid)[0]
  if wininfo.quickfix
    return wininfo.loclist ? '[Location List]' : '[Quickfix List]'
  endif
  return '[No Name]'
endfunction

function s:ctr(text, minwidth) abort
  let strwidth = strwidth(a:text)
  if strwidth > a:minwidth
    return a:text
  endif
  let padding = (a:minwidth - strwidth) / 2
  let c = ''
  let c .= repeat(' ', padding)
  let c .= a:text
  let c .= repeat(' ', a:minwidth - (padding + strwidth))
  return c
endfunction

function s:esc(text) abort
  return substitute(a:text, '%', '%%', 'g')
endfunction
