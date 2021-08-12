vim9script

# Guard {{{
if exists('b:did_my_voyager_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_voyager_ftplugin = true  # }}}


setlocal cursorline
setlocal signcolumn=no
setlocal statusline=%!my#statusline#get('Voyager')


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_voyager_ftplugin
      \| setlocal cursorline<
      \| setlocal signcolumn<
      \| setlocal statusline<
      \'  # }}}
