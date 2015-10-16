" These maps are loaded after because the plugins must have been loaded, so we
" can make our test

" Plugin Unite {{{
if exists(':Unite')
    autocmd! FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()

        " Overwrite settings.
        nmap <buffer> s         <Plug>(unite_loop_cursor_up)
        nmap <buffer> t         <Plug>(unite_loop_cursor_down)
        nmap <buffer> S         <Plug>(unite_skip_cursor_up)
        nmap <buffer> T         <Plug>(unite_skip_cursor_down)

        " open in tab
        nnoremap <silent><buffer><expr> j
                    \ unite#smart_map('t', unite#do_action('tabopen'))
    endfunction
endif
" }}}

" Fugitive mappings {{{
if exists("g:loaded_fugitive")
    nnoremap gys :Gstatus<CR><C-w>20+
    nnoremap gye :Gedit<CR>
    nnoremap gya :Gadd<CR>
    nnoremap gyd :Gdiff<CR>
    nnoremap gyl :Glog<CR>
    nnoremap gyp :Gpush<CR>
    nnoremap gyc :Gcommit<CR>
endif
" }}}

" Sneak {{{
if exists("g:loaded_sneak_plugin")
    nmap è <Plug>Sneak_s
    nmap È <Plug>Sneak_S
    xmap è <Plug>Sneak_s
    xmap È <Plug>Sneak_S
    omap è <Plug>Sneak_s
    omap È <Plug>Sneak_S

endif
" }}}

" Plugin Surround {{{
if hasmapto('<Plug>CSurround')
    " bépo mapping only
    nunmap cs
    nunmap cS
    nmap ls  <Plug>Csurround
    nmap lS  <Plug>CSurround
endif
" }}}

" vim-commentary fix (cgc) {{{
" bepo, cgc becomes lgc
if hasmapto('<Plug>ChangeCommentary')
    nunmap cgc
    nmap lgc <Plug>ChangeCommentary
endif
" }}}


" vim:foldmethod=marker:foldlevel=0
