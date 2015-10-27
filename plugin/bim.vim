" bim.vim - vim keymaps for bépo keyboard layout
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.0.1
"
" Based on http://bepo.fr/wiki/Vim suggestions, unknow author
"
" TODO: Better git shortcut
" TODO: Save without leader?
" TODO: better comments
"
" MEMO: use gà,gé,gè,zà,zé,zè,"g,"
"
" TODO: operators è à ç / ù œ æ €
" TODO: tabularize operator waiting like :ù:é ù=àp
" TODO: lang cleaner operator waiting like æap, æé
" TODO: next/previous ident? ambient/inner ident
"
" TODO: namespace bim#var
"
" TABULARIZE:
" FORMATING LANG AWARE: 
" CLEANING TRAIL:           €           €€, €ap, €é
" INNER FUNCTION: if
" AMBIANT FUNCTION: af
" FREE:
"
" gl
" gh (select mode ?)
" gj (moved to arrow)
" gk (moved to arrow)
" gà : invert sneak? Easier than À? À stays free?
" gy : git ?
" gè :
" gç :
" gc : vim commentary
" zà :
" zé :
" zè :
" zù :
" â : trail?
" è : ?
" € : lang formating?
" ê : ?
" û : ?
"
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

" layout detection, experimental, except if enable war forced
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

" ----------------------------------------------------------------------------
" Prefix configuration
" ----------------------------------------------------------------------------

" vim-sneak: vim-bim must be loaded before vim-sneak for this to works
let g:sneak#nextprev_t = 'j'

" Options default mappings
if !exists("g:bim_option_prefix")
    let g:bim_option_prefix   = 'œ'
endif
if !exists("g:bim_buffer_prefix")
    let g:bim_buffer_prefix   = 'é'
endif
if !exists("g:bim_window_prefix")
    let g:bim_window_prefix   = 'É'
endif
if !exists("g:bim_buffer_operator")
    let g:bim_buffer_operator = 'é'
endif

" ----------------------------------------------------------------------------
" Home row HJKL -> CTSR
" ----------------------------------------------------------------------------
if !exists("g:bim_remap_homerow") || g:bim_remap_homerow

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

" <> direct access
noremap « <
noremap » >

" ----------------------------------------------------------------------------
" Buffers and windows
" ----------------------------------------------------------------------------

" New operator "é" = full buffer ; a very powerfull mapping!
" Drawback: move to top of the screen, as any vim motion would do
execute "onoremap " . g:bim_buffer_operator . " :<c-u>normal! ggVG<cr>"

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
execute "nnoremap " . g:bim_buffer_prefix . "<SPACE> :<C-U>split<CR>"
execute "nnoremap " . g:bim_buffer_prefix . "<CR> :<C-U>vsplit<CR>"

" works like gt/gT but for buffers ([G]oto [É]cran)
execute "nnoremap g" . g:bim_buffer_prefix . " :<C-U>bp<CR>"
execute "nnoremap g" . toupper(g:bim_buffer_prefix) . " :<C-U>bn<CR>"

" Quick window access
execute "nnoremap " . g:bim_window_prefix . " <C-w>"
execute "nnoremap " . g:bim_window_prefix . g:bim_window_prefix " <C-w><C-w>"

if !exists("g:bim_remap_homerow") || g:bim_remap_homerow
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
    execute "nnoremap " . g:bim_window_prefix . "h <C-w>c"
    execute "nnoremap " . g:bim_window_prefix . "j <C-w>t"
    execute "nnoremap " . g:bim_window_prefix . "k <C-w>s"
    execute "nnoremap " . g:bim_window_prefix . "l <C-w>r"
    execute "nnoremap " . g:bim_window_prefix . "H <C-w>C"
    execute "nnoremap " . g:bim_window_prefix . "J <C-w>T"
    execute "nnoremap " . g:bim_window_prefix . "K <C-w>S"
    execute "nnoremap " . g:bim_window_prefix . "L <C-w>R"
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

" Plugins options ([A]ddons)
" TODO: create a function to add custom "option-a" mappings in vimrc
execute "nnoremap <silent> " . g:bim_option_prefix . "ag :<C-U>Goyo<CR>"
execute "nnoremap <silent> " . g:bim_option_prefix . "an :<C-U>NeoCompleteToggle<CR>"

" Formatting

" Replace space by non breakable space where it should (French rules)
"nnoremap [format]  :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
" vnoremap [format]  :s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
" clean trailing spaces
"nnoremap [format]$ :%s/\s\+$//<CR>
" vnoremap [format]$ :s/\s\+$//<CR>

" new operator é = full buffer
" a very powerfull mapping!
onoremap é :<c-u>normal! ggVG<cr>

"nnoremap <silent> € :set opfunc=bim#CleanTrailingSpaces<CR>g@
"nnoremap <silent> €€ €l
"vnoremap <silent> € :<C-U>call bim#CleanTrailingSpaces(visualmode(), 1)<CR>
" TODO: after, only if tabularize is found
nnoremap <silent> æ :set opfunc=<SID>TabularizeOp<CR>g@
nnoremap <silent> æ :set opfunc=<SID>TabularizeOp<CR>g@

" move line down/up
nnoremap <silent> lm :set opfunc=<SID>MoveLineDown<CR>g@
nnoremap <silent> lM :set opfunc=<SID>MoveLineUp<CR>g@

" last/first chars of line
onoremap â :<c-u>execute "normal! $v" . v:count1 . "hl"<CR>
onoremap Â :<c-u>execute "normal! ^v" . v:count1 . "lh"<CR>

" TODO: trail delete
" nnoremap ê … opfunc …
" nnoremap Ê … opfunc …
" TODO: delete last char
" nnoremap â … opfunc …
" nnoremap Â … opfunc …
"
" TODO: lang formating
" nnoremap € … opfunc …

" ----------------------------------------------------------------------------
" Saving
" ----------------------------------------------------------------------------
" leader use is acceptable because it is very quick and a very common
" operation
" TODO: find something more "bepo"
map <leader>, :w<CR>
" map <leader>; :w !sudo tee % > /dev/null<CR>

" Add line above/below but without insert mode
nnoremap <silent> Ô :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> ô :<C-U>call <SID>BlankDown(v:count1)<CR>

" Operator "line" (l), only if homerow has been remapped
if !exists("g:bim_remap_homerow") || g:bim_remap_homerow
    onoremap l :<c-u>normal! 0v$<CR>
endif
" [B]elow/[A]bove [L]ine
onoremap bl :<C-u>execute "normal! jV" . (v:count == 0 ? '' : v:count - 1 . "j" )<CR>
onoremap al :<C-u>execute "normal! kV" . (v:count == 0 ? '' : v:count - 1 . "k" )<CR>

" à/À : sneak               àte, Àte…
" é/É : buffer              éé, ÉÉ, Ér, éd… dé, yé…
" À : window                ÀÀ, Àr, Àc…
" æ : Align Expression      æ=ap, æ==, æé…
" œ : Option Edit           œf, œsv, œev, œlf…
" ô : line over/below       dô, dÔ, ô, Ô
" ù : Unite                 ùf, ùb, ùa, ùm, ùg…
" € : Trailing spaces       €€, €ap, €é…
" â/Â

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

fun! s:TabularizeOp(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    let c = s:InputChar()
    let c = c ? c : '='

    if ! a:0 && a:type != "line"
        silent exe "normal! `[v`]"
    endif

    exe "Tabularize/" . c

    let &selection = sel_save
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

