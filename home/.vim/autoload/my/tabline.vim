vim9script

def my#tabline#get(): string
  return Labels() .. Fill()
enddef

def Labels(): string
  return range(1, tabpagenr('$'))
        ->mapnew((_, v) => Label(v))
        ->join('')
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
  const bufnr = CurrentBufnr(tabnr)
  return '%#TabLineSel#'
      .. '%' .. tabnr .. 'T'
      .. PADDING0
      .. Bufname(bufnr)->Center(MINWIDTH)->Truncate(MAXWIDTH)->Escape()
      .. '%#TabLineSelMod#'
      .. (getbufvar(bufnr, '&modified') ? PADDING1 : PADDING0)
enddef

def LabelInactive(tabnr: number): string
  const bufnr = CurrentBufnr(tabnr)
  return '%#TabLine#'
      .. '%' .. tabnr .. 'T'
      .. PADDING0
      .. Bufname(bufnr)->Center(MINWIDTH)->Truncate(MAXWIDTH)->Escape()
      .. PADDING0
enddef

def Fill(): string
  return '%#TabLineFill#'
      .. '%T'
      .. '%='
      .. ' '
      .. Gitinfo()->Escape()
      .. ' '
enddef

def CurrentBufnr(tabnr: number): number
  return tabpagebuflist(tabnr)[tabpagewinnr(tabnr) - 1]
enddef

def Bufname(bufnr: number): string
  const bufinfo = getbufinfo(bufnr)[0]
  if bufinfo.name != ''
    const trimmed = trim(bufinfo.name, '/', 2)
    return trimmed == '' ? bufinfo.name : fnamemodify(trimmed, ':t')
  endif
  const wininfo = getwininfo(bufinfo.windows[0])[0]
  if wininfo.quickfix
    return gettext(wininfo.loclist ? '[Location List]' : '[Quickfix List]')
  endif
  const buftype = getbufvar(bufnr, '&buftype')
  return {
    nofile:   '[Scratch]',
    acwrite:  '[Scratch]',
    terminal: '[Scratch]',
    prompt:   '[Prompt]',
    popup:    '[Popup]',
  }->get(buftype, '[No Name]')->gettext()
enddef

def Gitinfo(): string
  return [
    ['gina#component#repo#preset',    []],
    ['gina#component#status#preset',  []],
    ['gina#component#traffic#preset', []],
  ] ->mapnew((_, v) => trim(call(SafeCall, v)))
    ->filter((_, v) => v != '')
    ->join()
enddef

def SafeCall(func: any, arglist: list<any>): string
  var result = 'error'
  try
    result = call(func, arglist)
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
