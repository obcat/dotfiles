vim9script

# Guard {{{
if exists('b:did_my_ginaCommit_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_ginaCommit_ftplugin = true  # }}}


setlocal formatoptions-=o formatoptions+=j
setlocal nofoldenable
setlocal spell


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_ginaCommit_ftplugin
      \| setlocal formatoptions<
      \| setlocal foldenable<
      \| setlocal spell<
      \'  # }}}
