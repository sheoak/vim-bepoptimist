"=============================================================================
" FILE: after/plugin/bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" VERSION: 0.3
" LICENSE: MIT license
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.
"=============================================================================

" Remap Sneak "s/S" to "é/É" (default)
if exists("g:loaded_sneak_plugin") && Vimbim_is_homerow()
    nmap l <Plug>Sneak_l
    xmap l <Plug>Sneak_l
    omap l <Plug>Sneak_l
    nmap L <Plug>Sneak_L
    xmap L <Plug>Sneak_L
    omap L <Plug>Sneak_L

    " repeat motion
    map h <Plug>Sneak_;
    map H <Plug>Sneak_,

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
    nmap l <Plug>Sneak_t
    nmap L <Plug>Sneak_T
    " visual-mode
    xmap l <Plug>Sneak_t
    xmap L <Plug>Sneak_T
    " operator-pending-mode
    omap l <Plug>Sneak_t
    omap L <Plug>Sneak_T

endif

" Gundo fix and mapping
if exists(':GundoToggle')
    if Vimbim_is_homerow()
        let g:gundo_map_move_older = "s"
        let g:gundo_map_move_newer = "r"
    endif
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
    " Hack to remove intrusive unimpaired mappings
    if !empty(maparg('<p'))
        unmap <p
        unmap <P
        unmap >p
        unmap >P
    endif
endif
