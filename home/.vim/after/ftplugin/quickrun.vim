vim9script

# Guard {{{
if exists('b:did_my_quickrun_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_quickrun_ftplugin = true  # }}}


setlocal nonumber
setlocal signcolumn=no


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_quickrun_ftplugin
      \| setlocal number<
      \| setlocal signcolumn<
      \'  # }}}
