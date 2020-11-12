setlocal cursorlineopt=line
setlocal nonumber

nmap <buffer> D <plug>(molder-operations-delete)
nmap <buffer> R <plug>(molder-operations-rename)
nmap <buffer> d <plug>(molder-operations-newdir)

nnoremap <buffer> o <C-w>s:<C-u>call molder#open()<CR>
nnoremap <buffer> v <C-w>v:<C-u>call molder#open()<CR>
nnoremap <buffer> t :<C-u>tab split<CR>:call molder#open()<CR>
nnoremap <buffer> cd :<C-u>call <SID>lcd()<CR>
nnoremap <buffer> <nowait> s :<C-u>call <SID>run_shell()<CR>

if exists('s:loaded_functions')
  finish
endif

function! s:lcd() abort
  let l:dir = molder#curdir()
  exe 'lcd' l:dir
  echo l:dir
endfunction

function! s:run_shell() abort
  call term_start(&shell, #{
    \ cwd: molder#curdir(),
    \ term_finish: 'close',
    \ })
endfunction

let s:loaded_functions = 1
