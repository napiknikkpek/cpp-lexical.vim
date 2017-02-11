
fu! s:syname()
  return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfu

fu! s:get_char()
  return getline('.')[col('.')-1]
endfu

fu! s:find_pair(dec, inc)
  let l:count = 1
  while l:count && search('['.a:inc.a:dec.']', 'bW')
    if s:syname() != ''
      continue
    endif
    let l:count += s:get_char() == a:inc ? 1 : -1
  endwhile
endfu

fu! cpp#lexical#before_class()
  while search('\v(struct|class|[;(){}<>])', 'bW')
    if s:syname() == 'Statement'
      return v:true
    elseif s:syname() =~# '^cComment'
      continue
    endif
    let ch = s:get_char()
    if ch == '>'
      call s:find_pair('<', '>')
    elseif ch == ')'
      call s:find_pair('(', ')')
    else
      return v:false
    endif
  endw
  return v:false
endfu
