
nmap - <Plug>fugitive:s

" Remove mapping starting by r in Gstatus
let s:arr = ['r', 'i', 'f', 'u', 'p', 's', 'a', 'e', 'w', 'm', 'd', '<Space>', '?']
for s:key in s:arr
    execute "nmap <buffer>b" . s:key . " <Plug>fugitive:r" . s:key
endfor
