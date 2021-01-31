function statusline#global() abort
  return s:{s:activity()}()
endfunction

function statusline#local(filetype) abort
  return s:{a:filetype}_{s:activity()}()
endfunction

function s:active() abort
  let w = winwidth(0)
  let s = ''
  let s .= '%f' ->s:fmt()
  if w < 50
    return s
  endif
  let s .= s:gitbranch() ->s:fmt() ->s:esc()
  if w < 60
    return s
  endif
  let s .= '%4*'
  let s .= s:githunks('*', 6, '>') ->s:fmt() ->s:esc()
  let s .= '%0*'
  if w < 70
    return s
  endif
  let s .= '%='
  let s .= s:cwd() ->s:fmt() ->s:esc()
  return s
endfunction

function s:inactive() abort
  let s = ''
  let s .= '%f' ->s:fmt()
  return s
endfunction

function s:qf_active() abort
  let w = winwidth(0)
  let s = ''
  let s .= '%q' ->s:fmt()
  if w < 50
    return s
  endif
  let title = get(w:, 'quickfix_title', '')
  let s .= printf('"%s"', title) ->s:fmt() ->s:esc()
  if w < 70
    return s
  endif
  let s .= printf('%%%dl of %%L', len(line('$'))) ->s:fmt()
  if w < 80
    return s
  endif
  let s .= '%='
  let s .= s:cwd() ->s:fmt() ->s:esc()
  return s
endfunction

function s:qf_inactive() abort
  let s = ''
  let s .= '%q' ->s:fmt()
  return s
endfunction

function s:voyager_active() abort
  let w = winwidth(0)
  let s = ''
  let dir = getbufvar(winbufnr(g:statusline_winid), 'voyager_curdir')
  let s .= (empty(dir) ? '?' : fnamemodify(dir, ':p:~')) ->s:fmt() ->s:esc()
  if w < 50
    return s
  endif
  let s .= s:gitbranch() ->s:fmt() ->s:esc()
  if w < 60
    return s
  endif
  let s .= '%='
  let s .= s:cwd() ->s:fmt() ->s:esc()
  return s
endfunction

function s:voyager_inactive() abort
  let s = ''
  let dir = getbufvar(winbufnr(g:statusline_winid), 'voyager_curdir')
  let s .= (empty(dir) ? '?' : fnamemodify(dir, ':p:~')) ->s:fmt() ->s:esc()
  return s
endfunction

function s:githunks(symbol, max, t_symbol) abort
  try
    let hunknum = len(gitgutter#hunk#hunks(bufnr()))
  catch /:E117:/
    return 'E117'
  endtry
  return hunknum <= a:max
    \ ? repeat(a:symbol, hunknum)
    \ : repeat(a:symbol, a:max - 1) . a:t_symbol
endfunction

function s:gitbranch() abort
  try
    return gina#component#repo#branch()
  catch /:E117:/
    return 'E117'
  endtry
endfunction

function s:cwd() abort
  return fnamemodify(getcwd(), ':t')
endfunction

function s:activity() abort
  return g:statusline_winid == win_getid() ? 'active' : 'inactive'
endfunction

function s:fmt(text) abort
  return printf(' %s ', a:text)
endfunction

function s:esc(text) abort
  return substitute(a:text, '%', '%%', 'g')
endfunction
