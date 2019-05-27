
nmap »P <Plug>unimpairedPutAbove>']
nmap »p <Plug>unimpairedPutBelow>']
nmap «P <Plug>unimpairedPutAbove<']
nmap «p <Plug>unimpairedPutBelow<']
" Hack to remove intrusive unimpaired mappings
if !empty(maparg('<p'))
    unmap <p
    unmap <P
    unmap >p
    unmap >P
endif
