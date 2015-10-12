"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bim.vim - vim keymaps for bépo keyboard layout
" Author:       sheoak <dev@sheoak.fr>
" Version:      0.1
"
" Based on http://bepo.fr/wiki/Vim suggestions, unknow author
"
" TODO: fix window shortcuts
" TODO: best way to remap surround plugin?
" TODO: check bepo enabled in console?
" TODO: read documentation about langmap and test it
" TODO: reconfigure for php/js
" TODO: debugger
"
" MEMO: use gà,gé,gè,zà,zé,zè,"g,"
"
" ----------------------------------------------------------------------------
" Mapping scheme :
" ----------------------------------------------------------------------------
" $         is for options                  ($f toggles folding)
" æ         is for window handling          (ææ cycle last windows)
" gy        is for git                      (gys run :Gstatus)
" gc        is for vim-commentary           (gcc comments a line)
" ls/ds/ys  is for surround                 (ysaw" add quotes around word)
"
" ----------------------------------------------------------------------------
" Meaning of the keys (most of the time):
" ----------------------------------------------------------------------------
" k         buffer (dk destroy a buffer)
" q         window (dq destroy a window)
" d         for destroy/deletion    (dk destroy a buffer)
" y         for creation/saving…
" l         '
" ----------------------------------------------------------------------------
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Word: w -> é, easier for motions like daw viw -> daè diè {{{
" ----------------------------------------------------------------------------
if !exists("g:bim_remap_word") || ! g:bim_remap_word
    noremap é w
    noremap É W
    onoremap aé aw
    onoremap aÉ aW
    onoremap ié iw
    onoremap iÉ iW
    vnoremap aé aw
    vnoremap aÉ aW
    vnoremap ié iw
    vnoremap iÉ iW
endif
" }}}

" Windows: Easier window manipulation with à instead of C-w {{{
" ----------------------------------------------------------------------------
if !exists("g:bim_remap_window") || g:bim_remap_window

    " BEPO
    " quick window access
    " TODO: find something simple with æ ?
    " TODO: free it for a nicer use (prev/next…)
    nnoremap € :bn<CR>
    nnoremap œ :bp<CR>

    noremap æ <C-w>
    noremap ææ <C-w><C-w>

    " direct acces to <C-w> with w
    noremap æt <C-w>j
    noremap æs <C-w>k
    noremap æc <C-w>h
    noremap ær <C-w>l
    " move to the left/right/top/bottom
    noremap æC <C-w>H
    noremap æR <C-w>L
    noremap æT <C-w>J
    noremap æS <C-w>K
    noremap æ<SPACE> :split<CR>
    noremap æ<CR> :vsplit<CR>
endif
" }}}

" Home row HJKL -> CTSR {{{
" ----------------------------------------------------------------------------
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
" }}}

" Remap home row keys somewhere else {{{
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
" }}}

" Remap g… {{{
" ----------------------------------------------------------------------------
noremap gs gk
noremap gt gj
" Previous / next / first / last tab
noremap gb gT
noremap gé gt
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" }}}

" <> direct access {{{
noremap « <
noremap » >
" }}}

" Ex remapping {{{
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

" Others easier mappings {{{

" Access registers more easily on bepo keyboard
" Registers: switch à and "
if !exists("g:bim_remap_registers") || ! g:bim_remap_registers
    nnoremap à "
    nnoremap " à
    nnoremap àà :registers<CR>
    " Delete/Yank/replace all content
    nnoremap d<return> ggdG
    nnoremap y<return> ggyG``
    nnoremap l<return> ggdG``
endif

" }}}

" Toggle options {{{
"  we remap $ to é and take advantage of $ free key
" Remember: vars start by $
" TODO: use è instead in g:bin_no_remap_dollar == 1
if !exists("g:bim_remap_dollar") || g:bim_remap_dollar

    nnoremap è $
    nnoremap $ è

    nnoremap <silent> $n :set number!<CR>
    nnoremap <silent> $r :set relativenumber!<CR>
    nnoremap <silent> $f :set foldenable!<CR>
    nnoremap <silent> $p :set invpaste<CR>
    nnoremap <silent> $b :let &background = ( &background == "dark"? "light" : "dark" )<CR>
    nnoremap <silent> $w :set wrap!<CR>

    " spell options
    " [S]et [S]pell, [S]et [S]pell [F]rench/[E]nglish
    nnoremap <silent> $ss :setlocal spell!<CR>
    nnoremap <silent> $sf :setlocal spell! spelllang=fr<CR>
    nnoremap <silent> $se :setlocal spell! spelllang=en<CR>

    " vim configuration and plugins
    nnoremap $ev :e $MYVIMRC<cr>
    nnoremap $sv :source $MYVIMRC<cr>
    nnoremap $ss :source %<cr>

endif
" }}}

" Window and buffer managment {{{
" ----------------------------------------------------------------------------
" Quick buffer/window access
nnoremap <silent> dq :q<CR>
nnoremap <silent> dQ :q!<CR>
" delete ([K]ill) buffer/force/a[l]l/force a[L]l
nnoremap <silent> dk :bd<CR>:bp<CR>
nnoremap <silent> dK :bd!<CR>:bp<CR>
nnoremap <silent> dl :bufdo bd<CR>:bp<CR>
nnoremap <silent> dL :bufdo bd!<CR>
" save and delete buffer/close window
nnoremap <silent> yk :w<CR>:bd<CR>:bp<CR>
nnoremap <silent> yq :wq<CR>

" I do not map :w! because it should be used carefully
" leader use is acceptable because it is very quick and a very common
" operation
map <leader>, :w<CR>
map <leader>; :w !sudo tee % > /dev/null<CR>

" Replace space by non breakable space where it should (French rules)
nnoremap d<Backspace> :%s/\(\S\) \([:;?!]\)/\1 \2/g<CR>
nnoremap d<Space> :%s/\s\+$//<CR>

" }}}

" Plugin Tabularize {{{
" TODO: check if plugin installed
" TODO: do not use leader
vmap <C-j> :Tabularize/=<CR>
nmap <Leader>= :Tabularize /=<CR>
vmap <Leader>= :Tabularize /=<CR>
nmap <Leader>: :Tabularize /:\zs<CR>
vmap <Leader>: :Tabularize /:\zs<CR>
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
