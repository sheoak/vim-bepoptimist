"=============================================================================
" FILE: bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" VERSION: 0.4
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
if exists("g:bepoptimist_enable") && ! g:bepoptimist_enable
    finish
endif

" Check if the setting to remap homerow is on
fun! Bepoptimist_is_homerow()
    if !exists("g:bepoptimist_remap_homerow") || g:bepoptimist_remap_homerow
        return 1
    endif
endfunction

" ----------------------------------------------------------------------------
" Home row HJKL -> TSRN
" ----------------------------------------------------------------------------
if Bepoptimist_is_homerow()

    " - We do not remap s, it has an alias (cn)
    " - We keep J as Join
    " - We keep S as Line substitute
    noremap <nowait> t h
    noremap <nowait> s j
    noremap <nowait> r k
    noremap <nowait> n l
    noremap <nowait> gs gj
    noremap <nowait> gr gk

    " Remap home row keys somewhere else
    " Search n/N move to h/H
    noremap <nowait> h n
    noremap <nowait> H N
    noremap <nowait> gh gn
    noremap <nowait> gH gN
    " Replace move to l/L
    noremap <nowait> l r
    noremap <nowait> L R
    " gl has built-in, no remap needed
    noremap <nowait> gl gr
    noremap <nowait> gL gR
    " t/T move to h/H ([h]op), we leave gh/gH
    noremap <nowait> à t
    noremap <nowait> À T
    " L/H move to É/gÉ (Screen key)
    " Thoses maps are not so useful with sneak plugin
    noremap <nowait> É H
    noremap <nowait> gÉ L
    " we have a free j key to remap the annoying CTRL-] for jumps
    nnoremap j <C-]>
    nnoremap gj g<C-]>

    " moves in wrapped text with arrow keys
    noremap <nowait> <down> gj
    noremap <nowait> <up>   gk
    noremap <nowait> gs gj
    noremap <nowait> gr gk
    " Help key go to J
    noremap <nowait> J K

    " We have to free key (T/N) to navigate into tabs:
    nnoremap T :<C-U>tabprev<CR>
    nnoremap N :<C-U>tabnext<CR>
    nnoremap gT :<C-U>tabfirst<CR>
    nnoremap gN :<C-U>tablast<CR>

    " S and R are free, we make an alias for [] (vim-unimpaired + built-in)
    nmap S [
    nmap R ]

    " ranger style open tab
    nnoremap gn :tabe <CR>

endif

" è/È becomes ,; and free ,
noremap <nowait> è ;
noremap <nowait> È ,
noremap <nowait> gè g;
noremap <nowait> gÈ g,

" Even if we remap the homerow, previous / next fold are not remapped because
" they are awful on the bepo instead we use unimpaired style, this way we keep
" zr (reduce fold), zR (open all fold) and zs (scroll text horizontally)
nnoremap [z zk
nnoremap ]z zj

" Not compatible with vim-repeat for now
" direct access to command by switching . and :
if exists("g:bepoptimist_switch_command") && g:bepeptimist_switch_command
    nnoremap . :
    nnoremap : .
    vnoremap . :
    vnoremap : .
endif

" ----------------------------------------------------------------------------
" Taking advantage of bepo keys
" ----------------------------------------------------------------------------

" <> direct access
" TODO: remap system wise to have < > direct access everywhere
noremap « <
noremap » >

" repeat last command
nnoremap … @:

" ----------------------------------------------------------------------------
" Buffers and windows
" ----------------------------------------------------------------------------

" Quick window access
nnoremap é <C-w>
" Cycle 2 last buffers/windows
nnoremap éé :b#<CR>
nnoremap gé <C-w><C-p>
" <> direct access
nnoremap é« <C-w><
nnoremap é» <C-w>>
" close quickfix/location list
nnoremap é<space> :cclose<CR>
nnoremap é<bs> :lclose<CR>
nnoremap éà <C-w>]
nnoremap égà <C-w>g]

" remap to new homerow
if Bepoptimist_is_homerow()
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

" New operator "é" = full buffer
" TODO: visual mode
" TODO: remember position of the screen?
onoremap é :<c-u>normal! mzggVG<cr>`z

" last/first chars of line
" dê removes last char of line
" TODO: keep the cursor position
" TODO: vim-repeat
onoremap ê :<c-u>execute "normal! $v" . v:count1 . "hl"<CR>
onoremap Ê :<c-u>execute "normal! ^v" . v:count1 . "lh"<CR>

" Add line above/below but act as with :set paste
nnoremap ô :let b:s=&formatoptions<CR>:set formatoptions-=o<CR>o<Esc>:let &formatoptions=b:s<CR>i
nnoremap Ô :let b:s=&formatoptions<CR>:set formatoptions-=o<CR>O<Esc>:let &formatoptions=b:s<CR>i

" buffer navigation
nnoremap æ :<C-U>bprev<CR>
nnoremap € :<C-U>bnext<CR>

" first/last buffer
nnoremap gæ :<C-U>bfirst<CR>
nnoremap g€ :<C-U>blast<CR>
