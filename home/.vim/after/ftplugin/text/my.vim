vim9script

# Guard {{{
if exists('b:did_my_text_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_text_ftplugin = true  # }}}


setlocal wrap


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_text_ftplugin
      \| setlocal wrap<
      \'  # }}}
