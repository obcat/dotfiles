vim9script

# Guard {{{
if exists('b:did_my_capture_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_capture_ftplugin = true  # }}}


setlocal nolist
setlocal nonumber
setlocal signcolumn=no


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_capture_ftplugin
      \| setlocal list<
      \| setlocal number<
      \| setlocal signcolumn<
      \'  # }}}
