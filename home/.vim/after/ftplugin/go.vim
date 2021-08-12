vim9script

# Guard {{{
if exists('b:did_my_go_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_go_ftplugin = true  # }}}


if expand('<afile>') =~ '_test\.go'
  b:quickrun_config = {type: 'go/test'}
endif


setlocal formatoptions-=o formatoptions+=j
setlocal noexpandtab

inoremap <buffer> <C-]> 💥<C-]>


inoreabbrev <buffer> ife💥
\ if err != nil {<CR>
 \}
 \<C-o>O<C-g>u


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_go_ftplugin
      '| unlet! b:quickrun_config
      \| setlocal formatoptions<
      \| setlocal expandtab<
      \| silent! iunmap <buffer> <C-]>
      \| silent! iunabbrev <buffer> ife💥
      \'  # }}}
