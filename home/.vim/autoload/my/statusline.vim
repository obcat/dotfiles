vim9script

def my#statusline#get(context: string): string
  return call(context .. Activity(), [])
enddef

const PADDING   = ' '
const SEPARATOR = ' '

def GlobalActive(): string
  return ''
    .. PADDING
    .. '%f'
    .. SEPARATOR
    .. '%h%r%w'
    .. '%='
    .. SEPARATOR
    .. '%P'
    .. PADDING
enddef

def GlobalInactive(): string
  return GlobalActive()
enddef

def QfActive(): string
  return ''
    .. PADDING
    .. '%q'
    .. SEPARATOR
    .. '"%{get(w:, ''quickfix_title'', '''')}"'
    .. '%='
    .. SEPARATOR
    .. '%P'
    .. PADDING
enddef

def QfInactive(): string
  return QfActive()
enddef

def VoyagerActive(): string
  return ''
    .. PADDING
    .. '%{fnamemodify(@%, '':p'')}'
    .. SEPARATOR
    .. '%r%w'
    .. '%='
    .. SEPARATOR
    .. '%P'
    .. PADDING
enddef

def VoyagerInactive(): string
  return VoyagerActive()
enddef

def Activity(): string
  return <number>g:statusline_winid == win_getid() ? 'Active' : 'Inactive'
enddef
