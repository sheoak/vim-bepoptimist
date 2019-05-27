
" Remove mapping starting by r in Gstatus
fun! bepoptimist#fugitive#fixStatus()
    let l:arr = map(range(char2nr('a'),char2nr('z')),'nr2char(v:val)')
    for l:key in l:arr
        if !empty(maparg('r' . l:key))
            execute "nunmap <buffer>r" . l:key
        endif
    endfor
    xunmap <buffer>s
    nunmap <buffer>s
endfunction
