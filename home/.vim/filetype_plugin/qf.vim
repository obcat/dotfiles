setlocal nowrap
exe 'resize' min([line('$') + 2, 10])

" NOTE: {{map xxx :exe 'norm yyy'<CR>}} causes an error because :exe evaluates
" <CR>. s:preview() is defined to separate it.
nnoremap <buffer> <silent> p :<C-u>call <SID>preview()<CR>

if exists('s:loaded_functions')
  finish
endif

function! s:preview() abort
  " NOTE: :normal avoids redrawing
  exe "normal! \<CR>zz\<C-w>p"
endfunction

let s:loaded_functions = 1
