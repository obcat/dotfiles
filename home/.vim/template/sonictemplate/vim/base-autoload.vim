" Maintainer: {{_expr_:get(g:,'sonictemplate_maintainer','')}}
" License:    {{_expr_:get(g:,'sonictemplate_license','')}}

let s:save_cpo = &cpo
set cpo&vim


{{_cursor_}}


let &cpo = s:save_cpo
unlet s:save_cpo
