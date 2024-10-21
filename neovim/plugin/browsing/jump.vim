if !executable('autojump')
  echomsg expand("<SID>") .. ': cannot find autojump exe'
  finish
endif

function s:j(dest)
  let res = systemlist(['autojump', a:dest])
  if len(res) is 1
    let [dest] = res
  else
    echoerr join(res)
    return
  endif
  lcd `=dest`
  pwd
endfunction

function s:completion(A,L,P)
  return system(['autojump', '--complete', a:A])
        \->split()
        \->map({_, s -> substitute(s, '^.*__\d__', '', '')})
        \->uniq()
endfunction

command -complete=customlist,s:completion -nargs=1 J call s:j(<f-args>)

augroup dirfootprint
  autocmd!
  " does not count in autochdir - you are unconscious of that
  autocmd DirChanged window,tabpage,global
        \ call system(['autojump', '--add', v:event.cwd])
augroup END
