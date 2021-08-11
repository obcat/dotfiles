vim9script

setlocal foldmethod=marker

{
  for line in getline(1, 10)
    if line =~ '^\s*vim9s\%[cript]\>'
      b:is_vim9script = true
      break
    endif
  endfor
}

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
