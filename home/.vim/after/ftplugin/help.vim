vim9script

if &modifiable
else
  setlocal signcolumn=no
  nnoremap <buffer><silent> C @_:help <C-r><C-w>@en<CR>
  nnoremap <buffer><silent> J @_:help <C-r><C-w>@ja<CR>
endif
