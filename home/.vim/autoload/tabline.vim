let s:modflag = '@'
let s:label_minwidth = 22

let s:modflag_width = strwidth(s:modflag)
let s:label_padding = s:modflag_width + 2
let s:label_bufname_minwidth = s:label_minwidth - 2 * (s:label_padding)

function! tabline#tabline() abort
  return s:labels() . s:fill()
endfunction

function s:labels() abort
  let labels = ''
  let tabnrs = range(1, tabpagenr('$'))
  for tabnr in tabnrs
    let labels .= s:label(tabnr)
  endfor
  return labels
endfunction

function s:label(tabnr) abort
  let activity = a:tabnr == tabpagenr()
    \ ? 'active'
    \ : 'inactive'
  return s:label_{activity}(a:tabnr)
endfunction

function s:label_active(tabnr) abort
  let currentbufnr = s:currentbufnr(a:tabnr)
  let label = ''
  let label .= '%#TabLineSel#'
  let label .= '%' . a:tabnr . 'T'
  if a:tabnr == 1
    let label .= s:space(s:label_padding)
  else
    let label .= '%#TabLineSelDelim#'
    let label .= '▏'
    let label .= '%#TabLineSel#'
    let label .= s:space(s:label_padding - 1)
  endif
  let label .= s:bufname(s:currentbufnr(a:tabnr))
    \ ->s:center(s:label_bufname_minwidth)
    \ ->s:escape()
  let label .= s:space(1)
  if getbufvar(currentbufnr, '&modified')
    let label .= '%#TabLineSelMod#'
    let label .= s:modflag
    let label .= '%#TabLineSel#'
  else
    let label .= s:space(s:modflag_width)
  endif
  let label .= '%#TabLineSelDelim#'
  let label .= '▕'
  let label .= '%#TabLineSel#'
  return label
endfunction

function s:label_inactive(tabnr) abort
  let label = ''
  let label .= '%#TabLine#'
  let label .= '%' . a:tabnr . 'T'
  let label .= s:space(s:label_padding)
  let label .= s:bufname(s:currentbufnr(a:tabnr))
    \ ->s:center(s:label_bufname_minwidth)
    \ ->s:escape()
  let label .= s:space(s:label_padding)
  return label
endfunction

function s:fill() abort
  let fill = ''
  let fill .= '%#TabLineFill#'
  let fill .= '%T'
  return fill
endfunction

function s:currentbufnr(tabnr) abort
  return tabpagebuflist(a:tabnr)[tabpagewinnr(a:tabnr) - 1]
endfunction

function s:bufname(bufnr) abort
  let bufinfo = getbufinfo(a:bufnr)[0]
  let bufname = bufinfo.name
  if !empty(bufname)
    return (bufname ->fnamemodify(':t')) . (isdirectory(bufname) ? '/' : '')
  endif
  let bufwinid = bufinfo.windows[0]
  let wininfo  = getwininfo(bufwinid)[0]
  if wininfo.quickfix
    return wininfo.loclist ? '[Location List]' : '[Quickfix List]'
  endif
  return '[No Name]'
endfunction

function s:center(text, minwidth) abort
  let strwidth = strwidth(a:text)
  if strwidth > a:minwidth
    return a:text
  endif
  let padding = (a:minwidth - strwidth) / 2
  let centered = ''
  let centered .= s:space(padding)
  let centered .= a:text
  let centered .= s:space(a:minwidth - (padding + strwidth))
  return centered
endfunction

function s:escape(text) abort
  return substitute(a:text, '%', '%%', 'g')
endfunction

function s:space(size) abort
  return "\<Space>" ->repeat(a:size)
endfunction
