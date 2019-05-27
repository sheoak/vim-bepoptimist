
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
