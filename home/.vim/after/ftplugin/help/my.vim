vim9script

# Guard {{{
if exists('b:did_my_help_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_help_ftplugin = true  # }}}


command! -buffer -bar HelpView {
  setlocal buftype=help
  setlocal nomodifiable
  setlocal readonly
  setlocal colorcolumn=
  setlocal conceallevel=2
  setlocal nolist
  setlocal nonumber
  setlocal signcolumn=no
  nnoremap <buffer><silent> C @_:help <C-r><C-w>@en<CR>
  nnoremap <buffer><silent> J @_:help <C-r><C-w>@ja<CR>
}

command! -buffer -bar HelpEdit {
  setlocal buftype=
  setlocal modifiable
  setlocal noreadonly
  setlocal colorcolumn=+1
  setlocal conceallevel=0
  setlocal list
  setlocal number
  setlocal signcolumn=yes
  silent! nunmap <buffer> C
  silent! nunmap <buffer> J
}


if &buftype == 'help'
  HelpView
else
  HelpEdit
endif


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_help_ftplugin
      \| silent! delcommand HelpEdit
      \| silent! delcommand HelpView
      \| silent! nunmap <buffer> C
      \| silent! nunmap <buffer> J
      \'
if &buftype == 'help'
else
  b:undo_ftplugin ..=
        '| setlocal colorcolumn<
        \| setlocal conceallevel<
        \| setlocal list<
        \| setlocal number<
        \| setlocal signcolumn<
        \'
endif  # }}}
