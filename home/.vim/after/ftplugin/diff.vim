vim9script

# Guard {{{
if exists('b:did_my_diff_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_diff_ftplugin = true  # }}}


setlocal nofoldenable


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_diff_ftplugin
      \| setlocal foldenable<
      \'  # }}}
