vim9script

# Guard {{{
if exists('b:did_my_ginaLog_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_ginaLog_ftplugin = true  # }}}


setlocal cursorline
setlocal number
setlocal signcolumn=no


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_ginaLog_ftplugin
      \| setlocal cursorline<
      \| setlocal number<
      \| setlocal signcolumn<
      \'  # }}}
