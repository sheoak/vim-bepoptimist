" bim.vim - vim keymaps for bépo keyboard layout {{{
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
" Based on http://bepo.fr/wiki/Vim suggestions, unknow author
"
" TODO: Unite
" TODO: Better git shortcut
" TODO: Tabular without leader
" TODO: Save without leader?
" TODO: better comments
"
" TODO: use   ç
" MEMO: use gà,gé,gè,zà,zé,zè,"g,"
"
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

" Shortcut to custom mapping, defined depending on options {{{
nnoremap [buffer]   <Nop>
nnoremap [window]   <Nop>
nnoremap [option]   <Nop>
nnoremap [format]   <Nop>
vnoremap [buffer]   <Nop>
vnoremap [window]   <Nop>
vnoremap [option]   <Nop>
vnoremap [format]   <Nop>

" é is for manipulation of buffer [é]cran
nmap é [buffer]
" É for manipulation of windows   [É]cran
nmap É [window]
" à is a prefix for setting options ([À] régler)
nmap à [option]
" è is for formatting
nmap è [format]
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

" Windows: Easier window manipulation with é instead of C-w {{{
" ----------------------------------------------------------------------------

" quick buffer access
" -------------------------------------------------------------------------
" cycle 2 last buffers
nnoremap [buffer]é :b#<CR>
" change buffer
nnoremap [buffer]d :bd<CR>
nnoremap [buffer]c :bp<CR>
nnoremap [buffer]r :bn<CR>
nnoremap [buffer]u :bun<CR>
nnoremap [buffer]U :bun!<CR>
nnoremap [buffer]q :q<CR>
nnoremap [buffer]Q :q!<CR>
nnoremap [buffer]w :w<CR>
nnoremap [buffer]W :w!<CR>
nnoremap [buffer]s :save =expand('%')<CR>
nnoremap [buffer]S :save! =expand('%')<CR>
nnoremap [buffer]<SPACE> :split<CR>
nnoremap [buffer]<CR> :vsplit<CR>

" quick window access
" -------------------------------------------------------------------------
nnoremap [window] <C-w>
nnoremap [window]é <C-w><C-w>
nnoremap [window]É <C-w><C-w>

" direct acces to <C-w> with w
nnoremap [window]t <C-w>j
nnoremap [window]s <C-w>k
nnoremap [window]c <C-w>h
nnoremap [window]r <C-w>l
" move to the left/right/top/bottom
nnoremap [window]C <C-w>H
nnoremap [window]R <C-w>L
nnoremap [window]T <C-w>J
nnoremap [window]S <C-w>K
" }}}

" Setting options {{{
nnoremap <silent> [option]n :set number!<CR>
nnoremap <silent> [option]r :set relativenumber!<CR>
nnoremap <silent> [option]f :set foldenable!<CR>
nnoremap <silent> [option]p :set invpaste<CR>
nnoremap <silent> [option]b :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nnoremap <silent> [option]w :set wrap!<CR>

" spell options start with [option]s
" [S]et [S]pell, [S]pell [F]rench/[E]nglish
nnoremap <silent> [option]ss :setlocal spell!<CR>
nnoremap <silent> [option]sf :setlocal spell! spelllang=fr<CR>
nnoremap <silent> [option]se :setlocal spell! spelllang=en<CR>

" vim configuration and plugins
" [E]dit [V]imrc, [S]ource [V]imrc, [S]ource current
nnoremap [option]ev :e $MYVIMRC<cr>
nnoremap [option]sv :source $MYVIMRC<cr>
nnoremap [option]ss :source %<cr>

" }}}

" Formatting {{{

" Replace space by non breakable space where it should (French rules)
nnoremap [format]  :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
" vnoremap [format]  :s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
" clean trailing spaces
nnoremap [format]$ :%s/\s\+$//<CR>
" vnoremap [format]$ :s/\s\+$//<CR>
"
nnoremap [format]= :retab<CR>
nnoremap [format]d :%d<CR>
nnoremap [format]y :%y<CR>
nnoremap [format]l :%d<CR>i


" Plugin Tabularize
" TODO: check if plugin installed
" FIXME
" vnoremap [format]è :Tabularize/=<CR>
nnoremap [format]t= :Tabularize /=<CR>
" vnoremap [format]= :Tabularize /=<CR>
nnoremap [format]t: :Tabularize /:\zs<CR>
" vnoremap [format]: :Tabularize /:\zs<CR>

" }}}

" Saving {{{
" I do not map :w! because it should be used carefully
" leader use is acceptable because it is very quick and a very common
" operation
map <leader>, :w<CR>
map <leader>; :w !sudo tee % > /dev/null<CR>
" }}}

" Plugin Unite {{{
if !exists("g:unite_no_mappings") || ! g:unite_no_mapping
    autocmd! FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()

        " Overwrite settings.
        nmap <buffer> s         <Plug>(unite_loop_cursor_up)
        nmap <buffer> t         <Plug>(unite_loop_cursor_down)
        nmap <buffer> S         <Plug>(unite_skip_cursor_up)
        nmap <buffer> T         <Plug>(unite_skip_cursor_down)

        " open in tab
        nnoremap <silent><buffer><expr> j
                    \ unite#smart_map('t', unite#do_action('tabopen'))
    endfunction
endif
" }}}

" Fugitive mappings {{{
if exists("g:bim_remap_fugitive") && g:bim_remap_fugitive
    nnoremap gys :Gstatus<CR><C-w>20+
    nnoremap gye :Gedit<CR>
    nnoremap gya :Gadd<CR>
    nnoremap gyd :Gdiff<CR>
    nnoremap gyl :Glog<CR>
    nnoremap gyp :Gpush<CR>
    nnoremap gyc :Gcommit<CR>
endif
" }}}

" Plugin Surround {{{
" TODO: remap insert mappings?
if exists("g:bim_remap_surround") && g:bim_remap_surround
    let g:surround_no_mappings = 1
    " bépo mapping
    nmap ls  <Plug>Csurround
    nmap lS  <Plug>CSurround
    " same
    nmap ds  <Plug>Dsurround
    nmap ys  <Plug>Ysurround
    nmap yS  <Plug>YSurround
    nmap yss <Plug>Yssurround
    nmap ySs <Plug>YSsurround
    nmap ySS <Plug>YSsurround
    xmap S   <Plug>VSurround
    xmap gS  <Plug>VgSurround
endif
" }}}

" vim-commentary fix (cgc) {{{
if exists("g:bim_remap_commentary") && g:bim_remap_commentary
    " TODO: test if installed
    " bepo, cgc becomes lgc
    nmap lgc <Plug>ChangeCommentary
    " same:
    xmap gc  <Plug>Commentary
    nmap gc  <Plug>Commentary
    omap gc  <Plug>Commentary
    nmap gcc <Plug>CommentaryLine
    nmap gcu <Plug>Commentary<Plug>Commentary
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
