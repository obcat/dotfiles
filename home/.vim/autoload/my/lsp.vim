vim9script

def my#lsp#on_lsp_buffer_enabled()
  nnoremap <buffer> L <Nop>
  nmap <buffer> Ld <Plug>(lsp-definition)
  nmap <buffer> Lr <Plug>(lsp-references)
enddef

def my#lsp#on_lsp_float_opened()
  const winid = lsp#ui#vim#output#getpreviewwinid()
  const lines = getbufline(winbufnr(winid), 1, '$')
  const maxwidth = lines->mapnew((_, v) => strwidth(v))->max()
  popup_setoptions(winid, {
    maxheight: &lines / 3,
    minwidth: maxwidth,
    highlight: 'LspPreviewPopup',
    padding: [0, 1, 0, 1],
    borderhighlight: ['LspPreviewPopupBorder'],
    borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    scrollbar: 0,
    filter: FloatFilter
  })
enddef

def FloatFilter(winid: number, key: string): bool
  const table = {
    "\<BS>":  () => popup_close(winid),
    "\<C-e>": () => win_execute(winid, "normal! \<C-e>"),
    "\<C-y>": () => win_execute(winid, "normal! \<C-y>"),
    "\<C-d>": () => win_execute(winid, "normal! \<C-d>"),
    "\<C-u>": () => win_execute(winid, "normal! \<C-u>"),
    "\<C-f>": () => win_execute(winid, "normal! \<C-f>"),
    "\<C-b>": () => win_execute(winid, "normal! \<C-b>"),
  }
  if has_key(table, key)
    table[key]()
    return true
  endif
  return false
enddef
