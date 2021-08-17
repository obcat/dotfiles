vim9script

# Guard {{{
if exists('b:did_my_markdown_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_markdown_ftplugin = true  # }}}


setlocal wrap


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_markdown_ftplugin
      \| setlocal wrap<
      \'  # }}}
