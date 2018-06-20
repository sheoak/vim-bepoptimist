" after/plugin/bim.vim - vim keymaps for bépo keyboard layout
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.

" Fugitive mappings
if exists("g:loaded_fugitive") && exists("g:bim_map_fugitive") && g:bim_map_fugitive
    if !exists("g:bim_fugitive_prefix")
        let g:bim_fugitive_prefix = 'gy'
    endif
    execute "nnoremap " . g:bim_fugitive_prefix . "s :Gstatus<CR>"
    execute "nnoremap " . g:bim_fugitive_prefix . "e :Gedit<CR>"
    execute "nnoremap " . g:bim_fugitive_prefix . "d :Gdiff<CR>"
    execute "nnoremap " . g:bim_fugitive_prefix . "l :Glog --oneline<CR>"
    execute "nnoremap " . g:bim_fugitive_prefix . "p :Gpush<CR>"
    execute "nnoremap " . g:bim_fugitive_prefix . "c :Gcommit<CR>"
    execute "nnoremap " . g:bim_fugitive_prefix . "g :Gpull<CR>"

    execute "nnoremap " . g:bim_fugitive_prefix . "m :GMove "
endif

" Remap Sneak "s/S" to "à/À" (default)
if exists("g:loaded_sneak_plugin") && Vimbim_is_homerow()

    if !exists("g:bim_sneak_next")
        let g:bim_sneak_next = 'à'
    endif
    if !exists("g:bim_sneak_prev")
        let g:bim_sneak_prev = 'À'
    endif

    execute "nmap " . g:bim_sneak_next . " <Plug>Sneak_s"
    execute "xmap " . g:bim_sneak_next . " <Plug>Sneak_s"
    execute "omap " . g:bim_sneak_next . " <Plug>Sneak_s"
    execute "nmap " . g:bim_sneak_prev . " <Plug>Sneak_S"
    execute "xmap " . g:bim_sneak_prev . " <Plug>Sneak_S"
    execute "omap " . g:bim_sneak_prev . " <Plug>Sneak_S"

    nmap j <Plug>Sneak_t
    xmap j <Plug>Sneak_t
    omap j <Plug>Sneak_t
    nmap J <Plug>Sneak_T
    xmap J <Plug>Sneak_T
    omap J <Plug>Sneak_T

    if exists("g:bim_remap_leader") && g:bim_remap_leader
        " reset "," in vim-sneak, because taken by leader
        nnoremap <expr> ’ sneak#reset(',')
        xnoremap <expr> ’ sneak#reset(',')
        onoremap <expr> ’ sneak#reset(',')
        nmap ’ <Plug>SneakPrevious
        xmap ’ <Plug>SneakPrevious
    endif

endif

" Gundo fix and mapping
if exists(':GundoToggle')
    if !exists("g:bim_gundo_key")
        let g:bim_gundo_key = 'ù'
    endif
    if Vimbim_is_homerow()
        let g:gundo_map_move_older = "t"
        let g:gundo_map_move_newer = "s"
    endif
    execute "nnoremap <silent> " . g:bim_gundo_key . " :GundoToggle<CR>"
endif

" Plugin Surround
if hasmapto('<Plug>CSurround') && Vimbim_is_homerow()
    let g:surround_no_mappings = 1
    nunmap cs
    nunmap cS
    nmap ls  <Plug>Csurround
    nmap lS  <Plug>CSurround
endif
