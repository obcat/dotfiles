let s:padding   = ' '
let s:separator = ' '

function my#statusline#global() abort
  return s:{s:activity()}()
endfunction

function my#statusline#local(filetype) abort
  return s:{a:filetype}_{s:activity()}()
endfunction

function s:active() abort
  " NOTE: "+= ... join" is faster than ".= ..."
  let s = []
  let s += [s:padding]
  let s += ['%f']
  let s += [s:separator]
  let s += ['%h%r%w']
  let s += ['%=']
  let s += [s:separator]
  let s += ['%P']
  let s += [s:padding]
  return join(s, '')
endfunction

function s:inactive() abort
  return s:active()
endfunction

function s:qf_active() abort
  let s = []
  let s += [s:padding]
  let s += ['%q']
  let s += [s:separator]
  let s += ['%{printf(''"%s"'', get(w:, ''quickfix_title'', ''''))}']
  let s += ['%=']
  let s += [s:separator]
  let s += ['%P']
  let s += [s:padding]
  return join(s, '')
endfunction

function s:qf_inactive() abort
  return s:qf_active()
endfunction

function s:voyager_active() abort
  let s = []
  let s += [s:padding]
  let s += ['%{fnamemodify(@%, '':p'')}']
  let s += ['%=']
  let s += [s:separator]
  let s += ['%P']
  let s += [s:padding]
  return join(s, '')
endfunction

function s:voyager_inactive() abort
  return s:voyager_active()
endfunction

function s:activity() abort
  return g:statusline_winid == win_getid() ? 'active' : 'inactive'
endfunction
