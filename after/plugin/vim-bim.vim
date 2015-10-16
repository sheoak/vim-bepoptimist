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
    nnoremap <expr> j sneak#reset('t')
    nnoremap <expr> J sneak#reset('T')
    xnoremap <expr> j sneak#reset('t')
    xnoremap <expr> J sneak#reset('T')
    onoremap <expr> j sneak#reset('t')
    onoremap <expr> J sneak#reset('T')

    nmap è <Plug>Sneak_s
    nmap È <Plug>Sneak_S
    xmap è <Plug>Sneak_s
    xmap È <Plug>Sneak_S
    omap è <Plug>Sneak_s
    omap È <Plug>Sneak_S
    nmap \ <Plug>SneakPrevious
    xmap \ <Plug>SneakPrevious
endif
" }}}

" Plugin Surround {{{
" TODO: remap insert mappings?
if exists("g:loaded_surround")
    " bépo mapping
    nmap ls  <Plug>Csurround
    nmap lS  <Plug>CSurround
    " same
    nmap ds  <Plug>Dsurround
    nmap ys  <Plug>Ysurround
    nmap yS  <Plug>YSurround
    nmap yss <Plug>Yssurround
    nmap ySs <Plug>YSsurround
    nmap ySS <Plug>YSsurround
    xmap S   <Plug>VSurround
    xmap gS  <Plug>VgSurround
endif
" }}}

" vim-commentary fix (cgc) {{{
" bepo, cgc becomes lgc
" TODO: how to test if installed?
" must be defined before loading vim-commentary
if exists("g:loaded_commentary")
    nmap lgc <Plug>ChangeCommentary
    " same:
    xmap gc  <Plug>Commentary
    nmap gc  <Plug>Commentary
    omap gc  <Plug>Commentary
    nmap gcc <Plug>CommentaryLine
    nmap gcu <Plug>Commentary<Plug>Commentary
endif
" }}}


" vim:foldmethod=marker:foldlevel=0
