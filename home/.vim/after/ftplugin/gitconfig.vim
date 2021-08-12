vim9script

# Guard {{{
if exists('b:did_my_gitconfig_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_gitconfig_ftplugin = true  # }}}


setlocal formatoptions-=o formatoptions+=j
setlocal noexpandtab


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_gitconfig_ftplugin
      \| setlocal formatoptions<
      \| setlocal expandtab<
      \'  # }}}
