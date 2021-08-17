vim9script

# Guard {{{
if exists('b:did_my_qf_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_qf_ftplugin = true  # }}}


execute 'resize' min([line('$') + 2, 10])
setlocal cursorline
setlocal signcolumn=no
setlocal statusline=%!my#statusline#get('Qf')


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_qf_ftplugin
      \| setlocal cursorline<
      \| setlocal signcolumn<
      \| setlocal statusline<
      \'  # }}}
