
" Remove mapping starting by r in Gstatus
let s:arr = map(range(char2nr('a'),char2nr('z')),'nr2char(v:val)')
for s:key in s:arr
    if !empty(maparg('r' . s:key))
        execute "nunmap <buffer>r" . s:key
    endif
endfor
xunmap <buffer>s
nunmap <buffer>s
