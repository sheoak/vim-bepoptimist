" bim.vim - vim keymaps for bépo keyboard layout
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.0.1
"
" Based on http://bepo.fr/wiki/Vim suggestions, unknow author

" ----------------------------------------------------------------------------
" Init
" ----------------------------------------------------------------------------
if exists('g:loaded_bim_plugin') || &compatible || v:version < 700
    finish
endif
let g:loaded_bim_plugin = 1

" bepo configuration, only if it’s current layout
if exists("g:bepo_enable") && ! g:bepo_enable
    finish
endif

" Check if the setting to remap homerow is on
fun! Vimbim_is_homerow()
    if !exists("g:bim_remap_homerow") || g:bim_remap_homerow
        return 1
    endif
endfunction

" ----------------------------------------------------------------------------
" Prefix configuration
" ----------------------------------------------------------------------------

" Options default mappings
if !exists("g:bim_option_prefix")
    let g:bim_option_prefix   = 'œ'
endif
if !exists("g:bim_buffer_prefix")
    let g:bim_buffer_prefix   = 'é'
endif
if !exists("g:bim_window_prefix")
    let g:bim_window_prefix   = 'è'
endif
if !exists("g:bim_buffer_operator")
    let g:bim_buffer_operator = 'é'
endif

" ----------------------------------------------------------------------------
" Home row HJKL -> CTSR
" ----------------------------------------------------------------------------
if Vimbim_is_homerow()

    " Bepo home row keys
    let g:bim_left_key   = 'c'
    let g:bim_right_key  = 'r'
    let g:bim_top_key    = 's'
    let g:bim_bottom_key = 't'

    noremap <nowait> c h
    noremap <nowait> r l
    noremap <nowait> t j
    noremap <nowait> s k
    " Top/Bottom of the screen
    noremap <nowait> C H
    noremap <nowait> R L
    " Join line / help
    noremap <nowait> T J
    noremap <nowait> S K
    " Previous / next fold
    noremap zt zj
    noremap zs zk

    " Remap home row keys somewhere else
    " T move to J
    noremap <nowait> j t
    noremap <nowait> J T
    " C move to L
    noremap <nowait> l c
    noremap <nowait> L C
    " R move to H
    noremap <nowait> h r
    noremap <nowait> H R
    " S move to K
    noremap <nowait> k s
    noremap <nowait> K S

    " we avoid remapping "gt" and "gs"
    nnoremap <nowait> <up>   gs
    nnoremap <nowait> <down> gt

else
    " default vim home row
    let g:bim_left_key     = 'h'
    let g:bim_right_key    = 'l'
    let g:bim_top_key      = 'k'
    let g:bim_bottom_key   = 'j'
endif

" direct access to command by switching . and :
if exists("g:bim_switch_command") && g:bim_switch_command
    nnoremap . :
    nnoremap : .
    vnoremap . :
    vnoremap : .
    " for compatibility with vim-repeat
    nmap : <Plug>(RepeatDot)
endif

" <> direct access
noremap « <
noremap » >

" this leave us a nice logical combo to replace , and ; 
" when we remap , to leader
noremap < ,
noremap > ;

" ----------------------------------------------------------------------------
" Buffers and windows
" ----------------------------------------------------------------------------

" New operator "é" = full buffer ; a very powerfull mapping!
" Drawback: move to top of the screen, as any vim motion would do
execute "onoremap " . g:bim_buffer_operator . ":<c-u>normal! mzggVG<cr>`z"

" cycle 2 last buffers, like <C-w><C-w> for windows
execute "nnoremap " . g:bim_buffer_prefix . g:bim_buffer_prefix . " :<C-U>b#<CR>"
" change buffer
execute "nnoremap " . g:bim_buffer_prefix . "d :<C-U>bd<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "u :<C-U>bun<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "U :<C-U>bun!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "q :<C-U>q<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "Q :<C-U>q!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "w :<C-U>w<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "W :<C-U>w!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "s :<C-U>save =expand('%')<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "S :<C-U>save! =expand('%')<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "h :<C-U>split<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "v :<C-U>vsplit<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "x :<C-U>x<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "X :<C-U>X<CR>"

" works like gt/gT but for buffers ([G]oto [É]cran)
execute "nnoremap g" . g:bim_buffer_prefix . " :<C-U>bp<CR>"
execute "nnoremap g" . toupper(g:bim_buffer_prefix) . " :<C-U>bn<CR>"

" Quick window access
execute "nnoremap " . g:bim_window_prefix . " <C-w>"
execute "nnoremap " . g:bim_window_prefix . g:bim_window_prefix " <C-w><C-w>"

" close preview window
execute "nnoremap " . g:bim_window_prefix . "z :pc<CR>"
" close quickfix window
execute "nnoremap " . g:bim_window_prefix . "f :ccl<CR>"

if Vimbim_is_homerow()
    " Remap window + home row
    execute "nnoremap " . g:bim_window_prefix . "c <C-w>h"
    execute "nnoremap " . g:bim_window_prefix . "t <C-w>j"
    execute "nnoremap " . g:bim_window_prefix . "s <C-w>k"
    execute "nnoremap " . g:bim_window_prefix . "r <C-w>l"
    " Move to the left/right/top/bottom
    execute "nnoremap " . g:bim_window_prefix . "C <C-w>H"
    execute "nnoremap " . g:bim_window_prefix . "T <C-w>J"
    execute "nnoremap " . g:bim_window_prefix . "S <C-w>K"
    execute "nnoremap " . g:bim_window_prefix . "R <C-w>L"
    " Remap moved keys ([C]lose -> h, [T]ab -> j, [S]plit -> k, [R]otate -> l
    execute "nnoremap " . g:bim_window_prefix . "j <C-w>t"
    " h to split horizontaly, v for verticaly
    execute "nnoremap " . g:bim_window_prefix . "h <C-w>s"
    execute "nnoremap " . g:bim_window_prefix . "H <C-w>S"
    execute "nnoremap " . g:bim_window_prefix . "l <C-w>r"
    execute "nnoremap " . g:bim_window_prefix . "J <C-w>T"
    execute "nnoremap " . g:bim_window_prefix . "K <C-w>S"
    execute "nnoremap " . g:bim_window_prefix . "L <C-w>R"
    execute "nnoremap " . g:bim_window_prefix . "« <C-w><"
    execute "nnoremap " . g:bim_window_prefix . "» <C-w>>"

    " TODO find something for close
    execute "nnoremap " . g:bim_window_prefix . "ç <C-w>c"
    execute "nnoremap " . g:bim_window_prefix . "Ç <C-w>C"
endif

" ----------------------------------------------------------------------------
" Setting options
" ----------------------------------------------------------------------------
execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "n :<C-U>set number!<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "r :<C-U>set relativenumber!<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "f :<C-U>set foldenable!<CR>:set foldenable?<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "p :<C-U>set invpaste<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "b :<C-U>let &background = ( &background == 'dark'? 'light' : 'dark' )<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "w :<C-U>set wrap!<CR>:set wrap?<CR>"

" spell options start with l
execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "ll :<C-U>setlocal spell!<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix .
    \ "lf :<C-U>setlocal spell! spelllang=fr<CR>"

execute "nnoremap <silent> " . g:bim_option_prefix
    \ . "le :<C-U>setlocal spell! spelllang=en<CR>"

" vim configuration and plugins
" [E]dit [V]imrc, [S]ource [V]imrc, [S]ource current
execute "nnoremap <silent> " . g:bim_option_prefix . "ev :<C-U>e $MYVIMRC<cr>"
execute "nnoremap <silent> " . g:bim_option_prefix . "sv :<C-U>source $MYVIMRC<cr>"
execute "nnoremap <silent> " . g:bim_option_prefix . "ss :<C-U>source %<cr>"

" Formatting

" new operator é = full buffer
onoremap é :<c-u>normal! ggVG<cr>

" > have been remap to » so it's free for a similar more complex operation
" with Tabularize
nmap æ <Plug>(EasyAlign)
xmap æ <Plug>(EasyAlign)

" last/first chars of line
onoremap â :<c-u>execute "normal! $v" . v:count1 . "hl"<CR>
onoremap Â :<c-u>execute "normal! ^v" . v:count1 . "lh"<CR>

" Add line above/below but without insert mode
nnoremap <silent> Ô :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> ô :<C-U>call <SID>BlankDown(v:count1)<CR>

" Plugin Surround
" We need to remap everything to avoid conflict
if exists('g:surround_no_mappings') && g:surround_no_mappings
    nmap ds  <Plug>Dsurround
    nmap ls  <Plug>Csurround
    nmap lS  <Plug>CSurround
    nmap ys  <Plug>Ysurround
    nmap yS  <Plug>YSurround
    nmap yss <Plug>Yssurround
    nmap ySs <Plug>YSsurround
    nmap ySS <Plug>YSsurround
    xmap S   <Plug>VSurround
    xmap gS  <Plug>VgSurround
endif

fun! s:CleanTrailingSpaces(type, ...)

    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv"
    elseif a:type == 'line'
        "silent exe "normal! '[V']"
    else
        silent exe "normal! `[v`]"
    endif

    exe "silent! '<,'>s/\\s\\+$//g"
    exe "normal! "

    let &selection = sel_save

endfun

fun! s:NonBreakableSpaces(type, ...)
    "let sel_save = &selection
    "let &selection = "inclusive"
    "let reg_save = @@

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv"
    elseif a:type == 'line'
        silent exe "normal! '[V']"
    else
        silent exe "normal! `[v`]"
    endif

    exe "silent! s/(\S) ([:;?!])/\1 \2/g"

    "let &selection = sel_save
    "let @@ = reg_save
endfunction

function! s:InputChar()
    let c = getchar()
    return type(c) == type(0) ? nr2char(c) : c
endfunction

" based on vim-surround plugin code
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("Ô", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("ô", a:count)
endfunction
