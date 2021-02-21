vim9script

def my#statusline#get(context: string): string
  return printf('%s%s()', context, Activity())->eval()
enddef

const padding   = ' '
const separator = ' '

def GlobalActive(): string
  return ''
    .. padding
    .. '%f'
    .. separator
    .. '%h%r%w'
    .. '%='
    .. separator
    .. '%P'
    .. padding
enddef

def GlobalInactive(): string
  return GlobalActive()
enddef

def QfActive(): string
  return ''
    .. padding
    .. '%q'
    .. separator
    .. '%{printf(''"%s"'', get(w:, ''quickfix_title'', ''''))}'
    .. '%='
    .. separator
    .. '%P'
    .. padding
enddef

def QfInactive(): string
  return QfActive()
enddef

def VoyagerActive(): string
  return ''
    .. padding
    .. '%{fnamemodify(@%, '':p'')}'
    .. '%='
    .. separator
    .. '%P'
    .. padding
enddef

def VoyagerInactive(): string
  return VoyagerActive()
enddef

def Activity(): string
  return <number>g:statusline_winid == win_getid() ? 'Active' : 'Inactive'
enddef
