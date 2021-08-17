vim9script

# Guard {{{
if exists('b:did_my_vim_ftplugin') || get(g:, 'my_no_ftplugin', false)
  finish
endif
b:did_my_vim_ftplugin = true  # }}}


b:is_vim9script = false
for line in getline(1, 10)
  if line =~ '^\s*vim9s\%[cript]\>'
    b:is_vim9script = true
    break
  endif
endfor


if b:is_vim9script
  b:caw_oneline_comment = '#'
endif


setlocal foldmethod=marker
setlocal formatoptions-=o formatoptions+=j


inoremap <buffer> <C-]> 💥<C-]>


inoreabbrev <buffer> aug💥
\ augroup <CR>
 \autocmd!<CR>
 \autocmd <CR>
 \augroup END
 \<Up><Up><Up><End>

inoreabbrev <buffer> def💥
\ def <CR>
 \enddef
 \<Up><End>

inoreabbrev <buffer> fu💥
\ function  abort<CR>
 \endfunction
 \<Up><End><S-Left><Left>

inoreabbrev <buffer> for💥
\ for <CR>
 \endfor
 \<Up><End>

inoreabbrev <buffer> if💥
\ if <CR>
 \endif
 \<Up><End>

inoreabbrev <buffer> try💥
\ try<CR>
 \catch<CR>
 \endtry
 \<Up><C-o>O<C-g>u

inoreabbrev <buffer> scr💥
\ function s:main() abort<CR>
 \endfunction<CR>
 \<CR>
 \call s:main()
 \<Up><Up><C-o>O<C-g>u


# Teardown {{{
b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
   .. '| unlet! b:did_my_vim_ftplugin
      \| unlet! b:is_vim9script
      \| setlocal foldmethod<
      \| setlocal formatoptions<
      \| silent! iunmap <buffer> <C-]>
      \| silent! iunabbrev <buffer> aug💥
      \| silent! iunabbrev <buffer> def💥
      \| silent! iunabbrev <buffer> fu💥
      \| silent! iunabbrev <buffer> for💥
      \| silent! iunabbrev <buffer> if💥
      \| silent! iunabbrev <buffer> try💥
      \| silent! iunabbrev <buffer> scr💥
      \'  # }}}
