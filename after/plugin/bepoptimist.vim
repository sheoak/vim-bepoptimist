"=============================================================================
" FILE: after/plugin/bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" VERSION: 0.3
" LICENSE: MIT license
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.
"
" TODO: autoload patches on key press?
"=============================================================================

if Bepoptimist_is_homerow()

    if exists(':GundoToggle')
        runtime patch/gundo.vim
    endif

    if exists('g:loaded_denite')
        runtime patch/denite.vim
    endif

    if exists("g:loaded_sneak_plugin")
        runtime patch/sneak.vim
    endif

endif

if exists('g:loaded_unimpaired')
    runtime patch/vim-unimpaired.vim
endif
