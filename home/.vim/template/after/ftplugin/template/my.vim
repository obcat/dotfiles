:vim9script
:const FILETYPE = expand('%:p:h:t')
:silent keeppatterns :% substitute /FILETYPE/\=FILETYPE/ge
vim9script

# Guard {{{
if exists('b:did_my_FILETYPE_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_FILETYPE_ftplugin = true  # }}}


<+CURSOR+>


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_FILETYPE_ftplugin
      \|
      \'  # }}}
