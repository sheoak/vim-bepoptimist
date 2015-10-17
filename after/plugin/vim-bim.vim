" after/plugin/bim.vim - vim keymaps for bépo keyboard layout {{{
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.
"
" We unmap/remap instead of remapping everything to keep it
" simple and to stay up to date if new mappings are added.

" Plugin Unite {{{
if exists(':Unite') && exists("g:bim_remap_homerow") && g:bim_remap_homerow
    autocmd! FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()

        " Overwrite settings.
        nmap <buffer> s         <Plug>(unite_loop_cursor_up)
        nmap <buffer> t         <Plug>(unite_loop_cursor_down)
        nmap <buffer> S         <Plug>(unite_skip_cursor_up)
        nmap <buffer> T         <Plug>(unite_skip_cursor_down)

        " Open in tab
        nnoremap <silent><buffer><expr> j
                    \ unite#smart_map('t', unite#do_action('tabopen'))
    endfunction
endif
" }}}

" Fugitive mappings {{{
" TODO: optionnal
" TODO: better mapping
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

" Remap Sneak "s/S" to "è/È" (default) {{{
if exists("g:loaded_sneak_plugin")

    if !exists("g:bim_sneak_next")
        let g:bim_sneak_next = 'è'
    endif
    if !exists("g:bim_sneak_prev")
        let g:bim_sneak_prev = 'È'
    endif

    execute "nmap " . g:bim_sneak_next . " <Plug>Sneak_s"
    execute "xmap " . g:bim_sneak_next . " <Plug>Sneak_s"
    execute "omap " . g:bim_sneak_next . " <Plug>Sneak_s"

    execute "nmap " . g:bim_sneak_prev . " <Plug>Sneak_S"
    execute "xmap " . g:bim_sneak_prev . " <Plug>Sneak_S"
    execute "omap " . g:bim_sneak_prev . " <Plug>Sneak_S"

endif
" }}}

" Plugin Surround {{{
if hasmapto('<Plug>CSurround') && exists("g:bim_remap_homerow") && g:bim_remap_homerow
    " bépo mapping only
    nunmap cs
    nunmap cS
    nmap ls  <Plug>Csurround
    nmap lS  <Plug>CSurround
endif
" }}}

" vim-commentary fix (cgc) {{{
" bepo, cgc becomes lgc
if hasmapto('<Plug>ChangeCommentary') && exists("g:bim_remap_homerow") && g:bim_remap_homerow
    nunmap cgc
    nmap lgc <Plug>ChangeCommentary
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
