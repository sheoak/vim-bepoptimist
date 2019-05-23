"=============================================================================
" FILE: bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" VERSION: 0.2
" LICENSE: MIT license
"
" Vim keymaps for bépo keyboard layout
"=============================================================================

if exists('g:loaded_bepoptimist') || &compatible || v:version < 700
    finish
endif
let g:loaded_bepoptimist = 1

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

" Remove mapping starting by r in Gstatus
fun! s:FixFugitive()
    let l:arr = map(range(char2nr('a'),char2nr('z')),'nr2char(v:val)')
    for l:key in l:arr
        if !empty(maparg('r' . l:key))
            execute "nunmap <buffer>r" . l:key
        endif
    endfor
endfunction

" Filetype detection
autocmd FileType fugitive call s:FixFugitive()

" ----------------------------------------------------------------------------
" Home row HJKL -> CTSR
" ----------------------------------------------------------------------------
if Vimbim_is_homerow()

    " Bepo home row keys
    let g:bim_left_key   = 't'
    let g:bim_right_key  = 'n'
    let g:bim_top_key    = 'r'
    let g:bim_bottom_key = 's'

    " noremap <nowait> c h
    noremap <nowait> t h
    noremap <nowait> s j
    noremap <nowait> r k
    noremap <nowait> n l
    " Top/Bottom of the screen
    noremap <nowait> R L
    " Join line / help
    noremap <nowait> T J
    noremap <nowait> S K
    " Previous / next fold
    noremap zs zj
    noremap zr zk
    noremap zR zr

    " Remap home row keys somewhere else
    " T move to J
    noremap <nowait> j t
    noremap <nowait> J T
    " N move to L
    noremap <nowait> l n
    noremap <nowait> L N
    " R move to H
    noremap <nowait> h r
    noremap <nowait> H R
    " S move to K
    noremap <nowait> k s
    noremap <nowait> K S

    nnoremap <nowait> <down> gj
    nnoremap <nowait> <up>   gk
    nnoremap <nowait> gs gj
    nnoremap <nowait> gr gk
    nnoremap <nowait> gj gs
    nnoremap <nowait> gk gr

else
    " default vim home row
    let g:bim_left_key     = 'h'
    let g:bim_right_key    = 'l'
    let g:bim_top_key      = 'k'
    let g:bim_bottom_key   = 'j'
endif

" Not compatible with vim-repeat for now
" direct access to command by switching . and :
if exists("g:bim_switch_command") && g:bim_switch_command
    nnoremap . :
    nnoremap : .
    vnoremap . :
    vnoremap : .
endif

" <> direct access
" TODO: remap system wise to have < > direct access everywhere
nnoremap « <
nnoremap » >
nnoremap < «
nnoremap > »
vnoremap « <
vnoremap » >
vnoremap < «
vnoremap > »
onoremap « <
onoremap » >
onoremap < «
onoremap > »

nmap \ <Plug>(EasyAlign)
xmap \ <Plug>(EasyAlign)

" À keys is reseved for jumps:
" previous / next jump (replace C-o and C-i)
nnoremap à <C-o>
nnoremap À <C-i>

" quick jump with à
nnoremap gà <C-]>
nnoremap gÀ g<C-]><C-w>T

" repeat last command
nnoremap … @:

" ----------------------------------------------------------------------------
" Buffers and windows
" ----------------------------------------------------------------------------

" Quick window access
nnoremap è <C-w>
" Cycle 2 last windows
nnoremap èè <C-w><C-p>
" <> direct access
nnoremap è« <C-w><
nnoremap è» <C-w>>
" close quickfix/location list
nnoremap è<space> :cclose<CR>
nnoremap è<cr> :lclose<CR>
nnoremap èà <C-w>]
nnoremap ègà <C-w>g]

" remap to new homerow
if Vimbim_is_homerow()
    " Remap window + home row
    nnoremap èt <C-w>h
    nnoremap ès <C-w>j
    nnoremap èr <C-w>k
    nnoremap èn <C-w>l
    " Move to the left/right/top/bottom
    nnoremap èT <C-w>H
    nnoremap èS <C-w>J
    nnoremap èR <C-w>K
    nnoremap èN <C-w>L
    " Remap moved keys ([n]ew k, [t]ab -> j, [s]plit -> h, [r]otate -> l
    nnoremap èh <C-w>s
    nnoremap èH <C-w>S
    nnoremap èj <C-w>t
    nnoremap èJ <C-w>T
    nnoremap èk <C-w>n
    nnoremap èK <C-w>N
    nnoremap èl <C-w>r
    nnoremap èL <C-w>R
endif

" ----------------------------------------------------------------------------
" Setting options
" ----------------------------------------------------------------------------

" Formatting

" New operator "é" = full buffer
onoremap è :<c-u>normal! mzggVG<cr>`z

" last/first chars of line
" dê removes last char of line
" todo: remember position
onoremap ê :<c-u>execute "normal! $v" . v:count1 . "hl"<CR>
onoremap Ê :<c-u>execute "normal! ^v" . v:count1 . "lh"<CR>

" Add line above/below but act as with :set paste
nnoremap ô :let b:s=&formatoptions<CR>:set formatoptions-=o<CR>o<Esc>:let &formatoptions=b:s<CR>i
nnoremap Ô :let b:s=&formatoptions<CR>:set formatoptions-=o<CR>O<Esc>:let &formatoptions=b:s<CR>i

" buffer and window navigation
" in the same style than the homerow but for left hand
nnoremap æ :<C-U>bprev<CR>
nnoremap Æ :<C-U>bfirst<CR>
nnoremap € :<C-U>bnext<CR>
nnoremap ¤ :<C-U>blast<CR>
nnoremap \| :<C-U>tabp<CR>
nnoremap œ :<C-U>tabn<CR>

" relocate | to `
noremap ` \|

" Plugin Surround
" We need to remap everything to avoid conflict
if exists('g:surround_no_mappings') && g:surround_no_mappings
    nmap dk  <Plug>Dsurround
    nmap ck  <Plug>Csurround
    nmap cK  <Plug>CSurround
    nmap yk  <Plug>Ysurround
    nmap yK  <Plug>YSurround
    nmap ykk <Plug>Yssurround
    nmap yKk <Plug>YSsurround
    xmap k   <Plug>VSurround
    xmap K   <Plug>VgSurround
endif

"" TODO: create an operator:
"" ip<operator> deletes trailing chars in the paragraph
"fun! s:CleanTrailingSpaces(type, ...)
"    let sel_save = &selection
"    let &selection = "inclusive"
"    if a:0  " Invoked from Visual mode, use gv command.
"        silent exe "normal! gv"
"    elseif a:type == 'line'
"        "silent exe "normal! '[V']"
"    else
"        silent exe "normal! `[v`]"
"    endif
"    exe "silent! '<,'>s/\\s\\+$//g"
"    exe "normal! "
"    let &selection = sel_save
"endfun

" TODO: create an operator:
" ip<operator> adds nbsp in the paragraph
"fun! s:NonBreakableSpaces(type, ...)
"    "let sel_save = &selection
"    "let &selection = "inclusive"
"    "let reg_save = @@

"    if a:0  " Invoked from Visual mode, use gv command.
"        silent exe "normal! gv"
"    elseif a:type == 'line'
"        silent exe "normal! '[V']"
"    else
"        silent exe "normal! `[v`]"
"    endif

"    exe "silent! s/(\S) ([:;?!])/\1 \2/g"

"    "let &selection = sel_save
"    "let @@ = reg_save
"endfunction
