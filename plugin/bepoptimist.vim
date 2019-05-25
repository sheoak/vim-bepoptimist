"=============================================================================
" FILE: bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" VERSION: 0.3
" LICENSE: MIT license
"
" Vim keymaps for bépo keyboard layout
"
" TODO: last close window
" TODO: close last open
" TODO: cycle buffers
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
    " noremap <nowait> k s
    " noremap <nowait> K S

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
noremap « <
noremap » >
" noremap { [
" noremap } ]
" noremap ] }
" noremap [ {

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
nnoremap é <C-w>
" Cycle 2 last windows
nnoremap éé <C-w><C-p>
" <> direct access
nnoremap é« <C-w><
nnoremap é» <C-w>>
" close quickfix/location list
nnoremap é<space> :cclose<CR>
nnoremap é<cr> :lclose<CR>
nnoremap éà <C-w>]
nnoremap égà <C-w>g]

" remap to new homerow
if Vimbim_is_homerow()
    " Remap window + home row
    nnoremap ét <C-w>h
    nnoremap és <C-w>j
    nnoremap ér <C-w>k
    nnoremap én <C-w>l
    " Move to the left/right/top/bottom
    nnoremap éT <C-w>H
    nnoremap éS <C-w>J
    nnoremap éR <C-w>K
    nnoremap éN <C-w>L
    " Remap moved keys ([n]ew k, [t]ab -> j, [s]plit -> h, [r]otate -> l
    " also change h/v to open empty buffers
    nnoremap éh :new<CR>
    nnoremap év :vnew<CR>
    nnoremap éj <C-w>t
    nnoremap éJ <C-w>T
    nnoremap ék <C-w>n
    nnoremap éK <C-w>N
    nnoremap él <C-w>r
    nnoremap éL <C-w>R
endif

" Formatting

" Forgotten unbreakable spaces… for French only
" TODO: move me with execute ;
nnoremap ;  :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>

" New operator "é" = full buffer
onoremap é :<c-u>normal! mzggVG<cr>`z

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
nnoremap \| :<C-U>tabprev<CR>
nnoremap ¦ :<C-U>tabfirst<CR>
nnoremap g\| :<C-U>-tabmove<CR>
nnoremap œ :<C-U>tabnext<CR>
nnoremap gœ :<C-U>+tabmove<CR>
nnoremap Œ :<C-U>tablast<CR>

" relocate | to `
noremap ` \|
