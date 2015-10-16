" bim.vim - vim keymaps for bépo keyboard layout {{{
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
" Based on http://bepo.fr/wiki/Vim suggestions, unknow author
"
" TODO: settings before loading/after loading
" TODO: Better git shortcut
" TODO: Save without leader?
" TODO: better comments
"
" TODO: use   ç
" MEMO: use gà,gé,gè,zà,zé,zè,"g,"
"
" TODO: :execute "map " . a:key . " :!" . a:action
" TODO: operator buffer: é
"
" œ : ?
" æ : ?
" € : ?
"
" ----------------------------------------------------------------------------
" Mapping scheme :
" ----------------------------------------------------------------------------
" $ or è    is for options                  ($f toggles folding)
" w or é    is for window handling          (éé cycle last windows)
" gy        is for git                      (gys run :Gstatus)
" gc        is for vim-commentary           (gcc comments a line)
" ls/ds/ys  is for surround                 (ysaw" add quotes around word)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}

" bepo configuration, only if it’s current layout {{{
" ----------------------------------------------------------------------------

" disabled
if exists("g:bepo_enable") && ! g:bepo_enable
    finish
endif

" layout detection, experimental, except if enable war forced
" ----------------------------------------------------------------------------
if !exists("g:bepo_enable")
    " in tty (no X server), need testing on some other distributions
    if $TERM == "linux"
        if executable('localectl') && empty(system("localectl|grep bepo"))
            finish
        endif
    else
        if executable('setxkbmap') && empty(system("setxkbmap -print|grep bepo"))
            finish
        endif
    endif
endif

" }}}

" Plugins configuration
" TODO: before?
let g:surround_no_mappings = 1

" Options default mappings {{{
let g:bim_option_prefix   = 'à'
let g:bim_buffer_prefix   = 'é'
let g:bim_window_prefix   = 'É'
let g:bim_buffer_operator = 'é'

" }}}

" Home row HJKL -> CTSR {{{
" ----------------------------------------------------------------------------
if !exists("g:bim_remap_homerow") || g:bim_remap_homerow
    noremap c h
    noremap r l
    noremap t j
    noremap s k
    " Top/Bottom of the screen
    noremap C H
    noremap R L
    " Join line / help
    noremap T J
    noremap S K
    " Previous / next fold
    noremap zt zj
    noremap zs zk

    " Remap home row keys somewhere else
    " ----------------------------------------------------------------------------
    " T move to J ([J]usqu'à)
    noremap j t
    noremap J T
    " C move to L (Change)
    noremap l c
    noremap L C
    " R move to H (Replace)
    noremap h r
    noremap H R
    " S move to K (Substitute)
    noremap k s
    noremap K S

    " Remap g…
    " ----------------------------------------------------------------------------
    noremap gs gk
    noremap gt gj
    " Previous / next / first / last tab
    noremap gb gT
    noremap gé gt
    noremap gB :exe "silent! tabfirst"<CR>
    noremap gÉ :exe "silent! tablast"<CR>
endif
" }}}

" <> direct access {{{
noremap « <
noremap » >
" }}}

" quick buffer access {{{
" -------------------------------------------------------------------------

" cycle 2 last buffers
execute "nnoremap " . g:bim_buffer_prefix . g:bim_buffer_prefix . " :<C-U>b#<CR>"
" change buffer
execute "nnoremap " . g:bim_buffer_prefix . "d :<C-U>bd<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "c :<C-U>bp<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "r :<C-U>bn<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "u :<C-U>bun<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "U :<C-U>bun!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "q :<C-U>q<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "Q :<C-U>q!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "w :<C-U>w<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "W :<C-U>w!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "s :<C-U>save =expand('%')<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "S :<C-U>save! =expand('%')<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "<SPACE> :<C-U>split<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "<CR> :<C-U>vsplit<CR>"

" quick window access
" -------------------------------------------------------------------------
execute "nnoremap " . g:bim_window_prefix . " <C-w>"
execute "nnoremap " . g:bim_window_prefix . "é <C-w><C-w>"
execute "nnoremap " . g:bim_window_prefix . "É <C-w><C-w>"

" direct acces to <C-w> with w
execute "nnoremap " . g:bim_window_prefix . "t <C-w>j"
execute "nnoremap " . g:bim_window_prefix . "s <C-w>k"
execute "nnoremap " . g:bim_window_prefix . "c <C-w>h"
execute "nnoremap " . g:bim_window_prefix . "r <C-w>l"
" move to the left/right/top/bottom
execute "nnoremap " . g:bim_window_prefix . "C <C-w>H"
execute "nnoremap " . g:bim_window_prefix . "R <C-w>L"
execute "nnoremap " . g:bim_window_prefix . "T <C-w>J"
execute "nnoremap " . g:bim_window_prefix . "S <C-w>K"
" }}}

" Setting options {{{
execute "nnoremap <silent> " . g:bim_option_prefix . "n :<C-U>set number!<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "r :<C-U>set relativenumber!<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "f :<C-U>set foldenable!<CR>:set foldenable?<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "p :<C-U>set invpaste<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "b :<C-U>let &background = ( &background == 'dark'? 'light' : 'dark' )<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "w :<C-U>set wrap!<CR>:set wrap?<CR>"

" spell options start with l
execute "nnoremap <silent> " . g:bim_option_prefix . "ll :<C-U>setlocal spell!<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "lf :<C-U>setlocal spell! spelllang=fr<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "le :<C-U>setlocal spell! spelllang=en<CR>"

" vim configuration and plugins
" [E]dit [V]imrc, [S]ource [V]imrc, [S]ource current
execute "nnoremap <silent> " . g:bim_option_prefix . "ev :<C-U>e $MYVIMRC<cr>"
execute "nnoremap <silent> " . g:bim_option_prefix . "sv :<C-U>source $MYVIMRC<cr>"
execute "nnoremap <silent> " . g:bim_option_prefix . "ss :<C-U>source %<cr>"

" }}}

" Formatting {{{

" Replace space by non breakable space where it should (French rules)
"nnoremap [format]  :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
" vnoremap [format]  :s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
" clean trailing spaces
"nnoremap [format]$ :%s/\s\+$//<CR>
" vnoremap [format]$ :s/\s\+$//<CR>

" new operator é = full buffer
" a very powerfull mapping!
execute "onoremap " . g:bim_buffer_operator . " :<c-u>normal! ggVG<cr>"

" Plugin Tabularize
" TODO: check if plugin installed
" FIXME
" vnoremap [format]è :Tabularize/=<CR>
"nnoremap [format]t= :Tabularize /=<CR>
" vnoremap [format]= :Tabularize /=<CR>
" nnoremap [format]t: :Tabularize /:\zs<CR>
" vnoremap [format]: :Tabularize /:\zs<CR>

" }}}

" Saving {{{
" I do not map :w! because it should be used carefully
" leader use is acceptable because it is very quick and a very common
" operation
map <leader>, :w<CR>
map <leader>; :w !sudo tee % > /dev/null<CR>
" }}}


" vim:foldmethod=marker:foldlevel=0
