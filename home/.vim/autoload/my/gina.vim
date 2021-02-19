function my#gina#rebase_interactive() abort
  let register = getreg(v:register)
  call gina#action#call('yank:rev')
  let revision = getreg(v:register)
  call setreg(v:register, register)
  if revision =~ '^\x\{7}$'
    call term_start(printf('git rebase --interactive %s', revision))
  endif
endfunction
