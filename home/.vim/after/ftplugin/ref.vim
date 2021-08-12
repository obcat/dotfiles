vim9script

# Guard {{{
if exists('b:did_my_ref_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_ref_ftplugin = true  # }}}


setlocal nolist
setlocal signcolumn=no


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_ref_ftplugin
      \| setlocal list<
      \| setlocal signcolumn<
      \'  # }}}
