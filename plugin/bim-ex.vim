"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bim-ex.vim - vim keymaps for Explorer in bépo keyboard layout
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    augroup netrw_dvorak_fix
        autocmd!
        autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
    augroup END
    function! Fix_netrw_maps_for_dvorak()
        noremap <buffer> t j
        noremap <buffer> s k
        noremap <buffer> k s
        noremap <buffer> gb gT
        noremap <buffer> gé gt
    endfunction
endif
" }}}
