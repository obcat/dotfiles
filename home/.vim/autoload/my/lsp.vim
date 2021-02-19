let s:SID = expand('<SID>')

function my#lsp#on_lsp_buffer_enabled() abort
  nnoremap <buffer> L <Nop>
  nmap <buffer> Ld <Plug>(lsp-definition)
  nmap <buffer> Lr <Plug>(lsp-references)
endfunction

function my#lsp#on_lsp_float_opened() abort
  let winid = lsp#ui#vim#output#getpreviewwinid()
  let lines = getbufline(winbufnr(winid), 1, '$')
  let maxwidth = max(map(lines, 'strwidth(v:val)'))
  call popup_setoptions(winid, #{
    \ maxheight: &lines / 3,
    \ minwidth: maxwidth,
    \ highlight: 'LspPreviewPopup',
    \ padding: [0, 1, 0, 1],
    \ borderhighlight: ['LspPreviewPopupBorder'],
    \ borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    \ scrollbar: 0,
    \ filter: s:SID . 'float_filter',
    \ })
endfunction

function s:float_filter(winid, key) abort
  if a:key is "\<BS>"
    call popup_close(a:winid)
    return 1
  endif
  return 0
endfunction
