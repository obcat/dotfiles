" Maintainer: {{_expr_:get(g:,'sonictemplate_maintainer','')}}
" License:    {{_expr_:get(g:,'sonictemplate_license','')}}

if exists('g:loaded_{{_expr_:expand("%:p:t:r")}}')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim


{{_cursor_}}


let g:loaded_{{_expr_:expand('%:p:t:r')}} = 1

let &cpo = s:save_cpo
unlet s:save_cpo
