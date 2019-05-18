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

" Remove mapping starting by r in Gstatus
fun! s:FixFugitive()
    let l:arr = map(range(char2nr('a'),char2nr('z')),'nr2char(v:val)')
    for l:key in l:arr
        if !empty(maparg('r' . l:key))
            execute "nunmap <buffer>r" . l:key
        endif
    endfor
endfunction

" ----------------------------------------------------------------------------
" Filetype detection
" ----------------------------------------------------------------------------
autocmd FileType fugitive call s:FixFugitive()

" ----------------------------------------------------------------------------
" Prefix configuration
" ----------------------------------------------------------------------------

" Options default mappings
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

    " we avoid remapping "gt" and "gs"
    nnoremap <nowait> <up>   gk
    nnoremap <nowait> <down> gj

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

" quick align paragraphs
nnoremap g« <ip
nnoremap g» >ip

" TODO: find an easier key? ù ’ …
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
" TODO: counter ( 4… ) like for .
nnoremap … @:

" ----------------------------------------------------------------------------
" Buffers and windows
" ----------------------------------------------------------------------------

" TODO: clean me
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
execute "nnoremap " . g:bim_buffer_prefix . "s :<C-U>w<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "S :<C-U>w!<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "h :<C-U>split<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "v :<C-U>vsplit<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "x :<C-U>x<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "X :<C-U>X<CR>"
execute "nnoremap " . g:bim_window_prefix . "z :pc<CR>"

" Quick window access
execute "nnoremap " . g:bim_window_prefix . " <C-w>"
execute "nnoremap " . g:bim_window_prefix . g:bim_window_prefix " <C-w><C-p>"
" close quickfix window
" FIXME: this overrides built-in
execute "nnoremap " . g:bim_window_prefix . "f :ccl<CR>"


" remap to new homerow
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

    " close quickfix
    execute "nnoremap " . g:bim_window_prefix . "<space> :cclose<CR>"

endif

" executing
nmap ;p <Nop>
nmap ;s <Nop>
vmap ;x :call bexec#Visual()<CR>
nmap ;x :call bexec#Normal()<CR>
nmap ;l :call bexec#Live()<CR>
nmap ;sv :source ~/.config/nvim/init.vim<CR>
nmap ;ss source %<CR>
nmap ;pi :PlugInstall<CR>
nmap ;pu :PlugUpdate<CR>
nmap ;pU :PlugUpgrade<CR>
nmap ;pc :PlugClean<CR>
nmap ;ps :PlugStatus<CR>
nmap ;pd :PlugDiff<CR>
" reinstall plugins quickly
nmap ;pI :w<CR>:source ~/.config/nvim/init.vim<CR>:PlugInstall<CR>
nmap ;m :make<CR>
nmap ;tt :!tox<CR>
nmap ;tp :!pytest<CR>

" ----------------------------------------------------------------------------
" Setting options
" ----------------------------------------------------------------------------

" Formatting

" New operator "é" = full buffer
execute "onoremap " . g:bim_buffer_operator . " :<c-u>normal! mzggVG<cr>`z"

" last/first chars of line
" dâ removes last char of line
" todo: move to è ?
" todo: remember position
onoremap â :<c-u>execute "normal! $v" . v:count1 . "hl"<CR>
onoremap Â :<c-u>execute "normal! ^v" . v:count1 . "lh"<CR>

" Add line above/below but act as with :set paste
nnoremap ô :let b:s=&formatoptions<CR>:set formatoptions-=o<CR>o<Esc>:let &formatoptions=b:s<CR>i
nnoremap Ô :let b:s=&formatoptions<CR>:set formatoptions-=o<CR>O<Esc>:let &formatoptions=b:s<CR>i

" buffer and window navigation
" in the same style than the homerow but for left hand
nnoremap æ :<C-U>bp<CR>
nnoremap € :<C-U>bn<CR>
nnoremap \| :<C-U>tabp<CR>
nnoremap œ :<C-U>tabn<CR>

" likely for CTRL-p: we move it to CTRL-t
inoremap <C-t> <C-p>
inoremap <C-p> <C-t>

" Plugin Surround
" We need to remap everything to avoid conflict
if exists('g:surround_no_mappings') && g:surround_no_mappings
    nmap dè  <Plug>Dsurround
    nmap cè  <Plug>Csurround
    nmap cÈ  <Plug>CSurround
    nmap yè  <Plug>Ysurround
    nmap yÈ  <Plug>YSurround
    nmap yèè <Plug>Yssurround
    nmap yÈÈ <Plug>YSsurround
    xmap È   <Plug>VSurround
    xmap gè  <Plug>VgSurround
endif


" TODO: create an operator:
" ip<operator> deletes trailing chars in the paragraph
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

" TODO: create an operator:
" ip<operator> adds nbsp in the paragraph
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

