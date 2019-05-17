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

" Remap Sneak "s/S" to "k/K" (default)
if exists("g:loaded_sneak_plugin") && Vimbim_is_homerow()

    if !exists("g:bim_sneak_next")
        let g:bim_sneak_next = 'k'
    endif
    if !exists("g:bim_sneak_prev")
        let g:bim_sneak_prev = 'K'
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

    " repeat motion
    map > <Plug>Sneak_;
    map < <Plug>Sneak_,

    " 1-character enhanced 'f'
    nmap f <Plug>Sneak_f
    nmap F <Plug>Sneak_F
    " visual-mode
    xmap f <Plug>Sneak_f
    xmap F <Plug>Sneak_F
    " operator-pending-mode
    omap f <Plug>Sneak_f
    omap F <Plug>Sneak_F

    " 1-character enhanced 't'
    nmap j <Plug>Sneak_t
    nmap J <Plug>Sneak_T
    " visual-mode
    xmap j <Plug>Sneak_t
    xmap J <Plug>Sneak_T
    " operator-pending-mode
    omap j <Plug>Sneak_t
    omap J <Plug>Sneak_T

    " label-mode
    " nmap k <Plug>SneakLabel_s
    " nmap K <Plug>SneakLabel_S
endif

" Gundo fix and mapping
if exists(':GundoToggle')
    if !exists("g:bim_gundo_key")
        let g:bim_gundo_key = 'ù'
    endif
    if Vimbim_is_homerow()
        let g:gundo_map_move_older = "s"
        let g:gundo_map_move_newer = "r"
    endif
    execute "nnoremap <silent> " . g:bim_gundo_key . " :GundoToggle<CR>"
endif

if exists('g:loaded_denite')
    call denite#custom#map(
          \ 'normal',
          \ 'r',
          \ '<denite:move_to_previous_line>',
          \ 'noremap'
          \)
    call denite#custom#map(
          \ 'normal',
          \ 's',
          \ '<denite:move_to_next_line>',
          \ 'noremap'
          \)
    " move t to j
    call denite#custom#map(
          \ 'normal',
          \ 'j',
          \ '<denite:do_action:tabopen>',
          \ 'noremap'
          \)
endif

if exists('g:loaded_unimpaired')
    nmap »P <Plug>unimpairedPutAbove>']
    nmap »p <Plug>unimpairedPutBelow>']
    nmap «P <Plug>unimpairedPutAbove<']
    nmap «p <Plug>unimpairedPutBelow<']
    if !empty(maparg('<p'))
        unmap <p
        unmap <P
        unmap >p
        unmap >P
    endif
endif
