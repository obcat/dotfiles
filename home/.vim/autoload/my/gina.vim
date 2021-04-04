vim9script

def my#gina#rebase_interactive()
  const register = getreg(v:register)
  gina#action#call('yank:rev')
  const revision = getreg(v:register)
  setreg(v:register, register)
  if revision =~ '^\x\+$'
    term_start(printf('git rebase --interactive %s', revision))
  endif
enddef
