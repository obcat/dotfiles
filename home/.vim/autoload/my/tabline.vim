vim9script

def my#tabline#get(): string
  return Labels() .. Fill()
enddef

def Labels(): string
  return range(1, tabpagenr('$'))->mapnew('Label(v:val)')->join('')
enddef

def Label(tabnr: number): string
  return tabnr == tabpagenr()
    ? LabelActive(tabnr)
    : LabelInactive(tabnr)
enddef

const PADDING0 = '   '
const PADDING1 = ' @ '
const MINWIDTH = 16
const MAXWIDTH = 16

def LabelActive(tabnr: number): string
  const bufnr = Currentbufnr(tabnr)
  return ''
    .. '%#TabLineSel#'
    .. '%' .. tabnr .. 'T'
    .. PADDING0
    .. Bufname(bufnr)->Center(MINWIDTH)->Truncate(MAXWIDTH)->Escape()
    .. '%#TabLineSelMod#'
    .. (getbufvar(bufnr, '&modified') ? PADDING1 : PADDING0)
enddef

def LabelInactive(tabnr: number): string
  return ''
    .. '%#TabLine#'
    .. '%' .. tabnr .. 'T'
    .. PADDING0
    .. Bufname(Currentbufnr(tabnr))->Center(MINWIDTH)->Truncate(MAXWIDTH)->Escape()
    .. PADDING0
enddef

def Fill(): string
  return ''
    .. '%#TabLineFill#'
    .. '%T'
    .. '%='
    .. ' '
    .. Gitinfo()->Escape()
    .. ' '
enddef

def Currentbufnr(tabnr: number): number
  return tabpagebuflist(tabnr)[tabpagewinnr(tabnr) - 1]
enddef

def Bufname(bufnr: number): string
  const bufinfo = getbufinfo(bufnr)[0]
  if !empty(bufinfo.name)
    const trimmed = trim(bufinfo.name, '/', 2)
    return empty(trimmed) ? bufinfo.name : fnamemodify(trimmed, ':t')
  endif
  const wininfo = getwininfo(bufinfo.windows[0])[0]
  if wininfo.quickfix
    return gettext(wininfo.loclist ? '[Location List]' : '[Quickfix List]')
  endif
  const buftype = getbufvar(bufnr, '&buftype')
  if buftype is 'nofile' || buftype is 'acwrite' || buftype is 'terminal'
    return gettext('[Scratch]')
  elseif buftype is 'prompt'
    return gettext('[Prompt]')
  elseif buftype is 'popup'
    return gettext('[Popup]')
  endif
  return gettext('[No Name]')
enddef

def Gitinfo(): string
  return [
    'gina#component#repo#preset()',
    'gina#component#status#preset()',
    'gina#component#traffic#preset()',
    ]
    ->map('trim(Safe(v:val))')
    ->filter('!empty(v:val)')
    ->join()
enddef

def Safe(expr: string): string
  var result = 'error'
  try
    result = eval(expr)
  catch
  endtry
  return result
enddef

def Center(string: string, minwidth: number): string
  const strwidth = strwidth(string)
  if minwidth <= strwidth
    return string
  endif
  const left = (minwidth - strwidth) / 2
  const right = minwidth - (left + strwidth)
  return repeat(' ', left) .. string .. repeat(' ', right)
enddef

def Truncate(string: string, maxwidth: number, symbol = '>'): string
  if strwidth(string) <= maxwidth
    return string
  endif
  return printf('%.*S%s', maxwidth - strwidth(symbol), string, symbol)
enddef

def Escape(string: string): string
  return substitute(string, '%', '%%', 'g')
enddef
