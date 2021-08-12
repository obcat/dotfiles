vim9script

# Guard {{{
if exists('b:did_my_help_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_help_ftplugin = true  # }}}


if &modifiable
else
  setlocal signcolumn=no
  nnoremap <buffer><silent> C @_:help <C-r><C-w>@en<CR>
  nnoremap <buffer><silent> J @_:help <C-r><C-w>@ja<CR>
endif


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_help_ftplugin
      \| setlocal signcolumn<
      \| silent! nunmap <buffer> C
      \| silent! nunmap <buffer> J
      \'
