let s:separator = "\<Space>" ->repeat(2)

function! statusline#global() abort
  return s:global_{s:activity()}()
endfunction

function! statusline#local(filetype) abort
  return s:local_{a:filetype}_{s:activity()}()
endfunction


function s:global_active() abort
  let winwidth = winwidth(0)
  let stl = ''
  let stl .= s:separator
  let stl .= '%t'
  if winwidth < 40
    return stl
  endif
  let stl .= s:separator
  let stl .= s:gitbranch() ->s:escape()
  if winwidth < 50
    return stl
  endif
  let stl .= s:separator
  let stl .= '%4*'
  let stl .= s:githunks('*', 6, '>') ->s:escape()
  let stl .= '%0*'
  if winwidth < 60
    return stl
  endif
  let stl .= '%='
  let stl .= s:cwd() ->s:escape()
  let stl .= s:separator
  return stl
endfunction

function s:global_inactive() abort
  let stl = ''
  let stl .= s:separator
  let stl .= '%t'
  return stl
endfunction


function s:local_qf_active() abort
  let winwidth = winwidth(0)
  let stl = ''
  let stl .= s:separator
  let stl .= '%q'
  if winwidth < 60
    return stl
  endif
  let stl .= s:separator
  let stl .= ('"' . w:quickfix_title . '"') ->s:escape()
  if winwidth < 80
    return stl
  endif
  let stl .= '%='
  let stl .= s:cwd() ->s:escape()
  let stl .= s:separator
  return stl
endfunction

function s:local_qf_inactive() abort
  let stl = ''
  let stl .= s:separator
  let stl .= '%q'
  return stl
endfunction


function s:local_molder_active() abort
  let stl = ''
  let stl .= s:separator
  let stl .= b:molder_dir ->fnamemodify(':~') ->s:escape()
  if winwidth(0) < 60
    return stl
  endif
  let stl .= '%='
  let stl .= s:cwd() ->s:escape()
  let stl .= s:separator
  return stl
endfunction

function s:local_molder_inactive() abort
  let stl = ''
  let stl .= s:separator
  let stl .= getbufvar(winbufnr(g:statusline_winid), 'molder_dir')
    \ ->fnamemodify(':~')
    \ ->s:escape()
  return stl
endfunction


function s:githunks(symbol, max, t_symbol) abort
  try
    let hunknum = len(gitgutter#hunk#hunks(bufnr()))
  catch /:E117:/
    return 'E117'
  endtry
  return hunknum <= a:max
    \ ? (a:symbol ->repeat(hunknum))
    \ : (a:symbol ->repeat(a:max - 1)) . a:t_symbol
endfunction

function s:gitbranch() abort
  try
    return gina#component#repo#branch()
  catch /:E117:/
    return 'E117'
  endtry
endfunction

function s:cwd() abort
  return getcwd() ->fnamemodify(':t')
endfunction


function s:activity() abort
  return g:statusline_winid == win_getid()
    \ ? 'active'
    \ : 'inactive'
endfunction


function s:escape(text) abort
  return substitute(a:text, '%', '%%', 'g')
endfunction