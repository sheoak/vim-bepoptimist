"=============================================================================
" FILE: after/plugin/bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" VERSION: 0.4
" LICENSE: MIT license
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.
"=============================================================================

if Bepoptimist_is_homerow()

    if exists(':GundoToggle')
        runtime patch/gundo.vim
    endif

    if exists('g:loaded_denite')
        runtime patch/denite.vim
    endif

endif

if exists('g:loaded_unimpaired')
    runtime patch/vim-unimpaired.vim
endif

" Mkdx
if exists("g:mkdp_auto_start")
    let g:mkdx#settings = { 'map': { 'prefix': 'mà' } }
endif

" -----------------------------------------------------------------------------
" GIT mappings (’)
" -----------------------------------------------------------------------------

if exists('g:loaded_fugitive')
    nnoremap ’b :Gblame<CR>
    nnoremap ’c :Gcommit<CR>
    nnoremap ’d :Gdiff<CR>
    nnoremap ’e :Gedit<CR>
    nnoremap ’fd :Gremove<CR>
    nnoremap ’fm :Gmove<CR>
    nnoremap ’i :Gpull<CR>
    nnoremap ’l :Glog --oneline<CR>
    nnoremap ’m :Gmerge<CR>
    nnoremap ’p :Gpush<CR>
    nnoremap ’r :Grebase<CR>
    nnoremap ’s :Gstatus<CR>
    nnoremap ’w :Gwrite<CR>
endif

" FZF
if exists('g:loaded_fzf')
    nnoremap ’’ :GFiles<CR>
    nnoremap ’h :Commits!<CR>
    nnoremap ’H :BCommits!<CR>
endif

" GitGutter mappings
if exists('g:loaded_gitgutter')
    nmap ’a <Plug>GitGutterStageHunk
    nmap ’u <Plug>GitGutterUndoHunk
    nmap ’v <Plug>GitGutterPreviewHunk
endif

" Table-mode
" Memo: þ is AltGr+T ([T]able)
if exists('g:loaded_table_mode')
    nnoremap þþ :TableModeToggle<CR>
    nnoremap þs :TableModeSort<CR>
    nnoremap þf :TableModeAddFormula<CR>
    nnoremap þe :TableModeEvalFormulaLine<CR>
    nnoremap þt <Plug>(table-mode-tableize)
    xnoremap þt <Plug>(table-mode-tableize)
    xnoremap þd <Plug>(table-mode-tableize-delimiter)
endif

" EeasyAlign (, is leader)
if exists('g:loaded_easy_align_plugin')
    nmap \ <Plug>(EasyAlign)
    xmap \ <Plug>(EasyAlign)
endif

" -----------------------------------------------------------------------------
"  Motions and text-objects (ç, é…)
" -----------------------------------------------------------------------------

if exists('g:loaded_camelcasemotion')
    " CamelCase motions (ç)
    nmap <silent> ç <Plug>CamelCaseMotion_w
    nmap <silent> Ç <Plug>CamelCaseMotion_b
    nmap <silent> gç <Plug>CamelCaseMotion_e
    nmap <silent> gÇ <Plug>CamelCaseMotion_ge
    vmap <silent> ç <Plug>CamelCaseMotion_w
    vmap <silent> Ç <Plug>CamelCaseMotion_b
    vmap <silent> gç <Plug>CamelCaseMotion_e
    vmap <silent> gÇ <Plug>CamelCaseMotion_ge

    " CamelCase text-objects (ç)
    omap <silent> aç <Plug>CamelCaseMotion_iw
    xmap <silent> aç <Plug>CamelCaseMotion_iw
    omap <silent> iç <Plug>CamelCaseMotion_ib
    xmap <silent> iç <Plug>CamelCaseMotion_ib
endif

" Git gutter text-objects (conflict with targets)
" [h]unks
if exists('g:loaded_gitgutter')
    omap ih <Plug>GitGutterTextObjectInnerPending
    omap ah <Plug>GitGutterTextObjectOuterPending
    xmap ih <Plug>GitGutterTextObjectInnerVisual
    xmap ah <Plug>GitGutterTextObjectOuterVisual
endif

" Snea[k]
" Some mappings are in vim-bepoptimist plugin (homerow remap and <>)
if exists('g:loaded_sneak_plugin')
    nmap k <Plug>Sneak_s
    xmap k <Plug>Sneak_s
    omap k <Plug>Sneak_s
    nmap K <Plug>Sneak_S
    xmap K <Plug>Sneak_S
    omap K <Plug>Sneak_S

    " label-mode
    nmap gk <Plug>SneakLabel_s
    nmap gK <Plug>SneakLabel_S

    " repeat motion
    map è <Plug>Sneak_;
    map È <Plug>Sneak_,

    " 1-character enhanced 'f'
    nmap f <Plug>Sneak_f
    nmap F <Plug>Sneak_F
    " visual-mode
    xmap f <Plug>Sneak_f
    xmap F <Plug>Sneak_F
    " operator-pending-mode
    omap f <Plug>Sneak_f
    omap F <Plug>Sneak_F

    if Bepoptimist_is_homerow()
        " 1-character enhanced 't'
        nmap à <Plug>Sneak_t
        nmap À <Plug>Sneak_T
        " visual-mode
        xmap à <Plug>Sneak_t
        xmap À <Plug>Sneak_T
        " operator-pending-mode
        omap à <Plug>Sneak_t
        omap À <Plug>Sneak_T
    endif

endif

if exists('g:loaded_surround')
    nmap du  <Plug>Dsurround
    nmap cu  <Plug>Csurround
    nmap cU  <Plug>CSurround
    nmap yu  <Plug>Ysurround
    nmap yU  <Plug>YSurround
    nmap yuu <Plug>Yssurround
    nmap yuU <Plug>YSsurround
    xmap u   <Plug>VSurround
    xmap u   <Plug>VgSurround
endif

" -----------------------------------------------------------------------------
" Coma (,) mappings:
" -----------------------------------------------------------------------------
"
" All coma mappings are use for file managment: actions on file, buffers…
"
" This mainly use Denite and FZF or basic actions like saving file
"
" - FZF is faster and better for easy actions (open file, c
" - Denite has more option and is better for custom action (tab open, append…)
"
" Case:
" For file browsing, lowercase means files and directory in most cases
" but it sometimes doesn't make sense as sources can be mixed
"
" Suffix:
" if leader is follow by of these keys, it will modify the next command:
"
" c     apply on [c]urrent buffer directory
" h     apply on [h]ome directory
" !     force next action (force save readonly…) or important action
" .     repeat for all files
"
" ,ct search in current directory (t=recursive)
" ,hb browser the home directory (not recursive)
"
" Combination:
" - ,.S force (S) save all (.) files
"
" For file saving/exiting, uppercase mean 'for all files'
"
" TODO: hidden buffers (denite buffers:!)
" -----------------------------------------------------------------------------

" Common actions (no plugin)
nmap ,s :w<CR>
nmap ,S :w!<CR>
nmap ,.s :wa<CR>
nmap ,.S :wa!<CR>
nmap ,w :saveas<space>
nmap ,W :saveas!<space>
nmap ,q :q<CR>
nmap ,Q :q!<CR>
nmap ,.q :qa<CR>
nmap ,.Q :qa!<CR>
nmap ,x :x<CR>
nmap ,X :x!<CR>
nmap ,u :bunload<CR>
nmap ,U :bunload!<CR>
nmap ,.u :bufdo bunload<CR>
nmap ,.U :bufdo bunload!<CR>
" for logic, but built-in ZZ is quicker
nmap ,.x :xa<CR>
nmap ,.X :xa!<CR>
nmap ,d :bdelete<CR>
nmap ,D :bdelete!<CR>
nmap ,.d :bufdo bdelete<CR>
nmap ,.D :bufdo bdelete!<CR>
" TODO: denite source command?
nmap ,iv :source ~/.config/nvim/init.vim<CR>
nmap ,is :source %<CR>

" FZF, it's faster than denite to open, no delay
if exists('g:loaded_fzf')
    " nnoremap <Tab> :Buffers<CR>
    nnoremap ,/ :Ag
    nnoremap ,, :FZF<CR>
    nnoremap ,’ :GFiles<CR>
    nnoremap ,~ :FZF ~<CR>
    nnoremap ,<space> :History<CR>
    nnoremap ,: :History:<CR>
endif

" Startify
if exists("g:loaded_startify")
    nnoremap ,v :Startify<CR>
endif

" Recent and favorites
" Alternative to fzf when action is needed:
if exists("g:loaded_denite")
    nnoremap <Tab> :<C-u>Denite -auto-resize buffer<CR>
    nnoremap ,<Tab> :<C-u>Denite -auto-resize buffer:!<CR>
    nnoremap ,<CR> :<C-u>Denite -resume<CR>

    " [R]ecent
    nnoremap ,r :<C-u>Denite file_mru<CR>
    nnoremap ,R :<C-u>Denite directory_mru<CR>

    " Recursive ([T]ree) files/folders
    nnoremap ,t :<C-u>DeniteProjectDir file/rec<CR>
    nnoremap ,ct :<C-u>DeniteBufferDir file/rec<CR>
    nnoremap ,ht :<C-u>Denite -path=~ file/rec<CR>
    nnoremap ,T :<C-u>DeniteProjectDir directory_rec<CR>
    nnoremap ,cT :<C-u>DeniteBufferDir directory_rec<CR>
    nnoremap ,hT :<C-u>Denite -path=~ directory_rec<CR>

    " [b]rowse (file/directory non recursive)
    nnoremap ,b :<C-u>DeniteProjectDir file<CR>
    nnoremap ,cb :<C-u>DeniteBufferDir file<CR>
    nnoremap ,hb :<C-u>Denite -path=~ file<CR>

    " [G]it
    nnoremap ,g :<C-u>DeniteProjectDir
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
    nnoremap ,cg :<C-u>DeniteBufferDir
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
    nnoremap ,hg :<C-u>Denite -path=~ file/rec/git-dotfiles<CR>

    " Searching
    nnoremap ,# :<C-u>DeniteCursorWord grep:. -mode=normal<CR>
    nnoremap ,a :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>
    nnoremap ,ca :DeniteBufferDir -buffer-name=grep -default-action=quickfix grep:::!<CR>
    nnoremap ,ha :Denite -path=~ -buffer-name=grep -default-action=quickfix grep:::!<CR>

    " Others
    nnoremap ,à :<C-u>Denite jump<CR>
    nnoremap ,À :<C-u>Denite tag<CR>
    nnoremap ,ç :<C-u>Denite colorscheme<CR>
    nnoremap ,C :<C-u>Denite change<CR>
    nnoremap ,j :<C-u>Denite emoji<CR>
    nnoremap ,k :<C-u>Denite help<CR>
    nnoremap ,l :<C-u>Denite line<CR>
    nnoremap ,L :<C-u>Denite line:buffers<CR>
    nnoremap ,n :<C-u>Denite outline<CR>
    nnoremap ,m :<C-u>Denite mark<CR>
    nnoremap ,p :<C-u>Denite neosnippet<CR>
    nnoremap ,o :<C-u>Denite output:!
    nnoremap ,y :<C-u>Denite register<CR>
    nnoremap ,z :<C-u>Denite spell<CR>
    nnoremap ,Z :<C-u>Denite grammarous<CR>
    nnoremap ,… :<C-u>Denite command_history<CR>
    nnoremap ,@ :<C-u>Denite command<CR>
    nnoremap ,?a :<C-u>Denite output:map<CR>
    nnoremap ,?n :<C-u>Denite output:nmap<CR>
    nnoremap ,?i :<C-u>Denite output:imap<CR>
    nnoremap ,?x :<C-u>Denite output:xmap<CR>
    nnoremap ,?o :<C-u>Denite output:omap<CR>

endif

" Ranger does not set the usual loaded variable at the moment
" if exists('g:ranger_command')
    nnoremap ,e :RangerWorkingDirectory<CR>
    nnoremap ,ce :RangerCurrentFile<CR>
    nnoremap ,he :Ranger ~<CR>
" endif

" -----------------------------------------------------------------------------
" Language related plugins (ß)
" Memo: ß is AltGr+S ([S]pell)
" -----------------------------------------------------------------------------

" Vim spell
nmap ßf :set spelllang=fr<CR>
nmap ße :set spelllang=en<CR>
nmap ßm :set spelllang=en,fr<CR>
nmap ßs z=

if exists('g:loaded_grammarous')
    nmap ßß <Plug>(grammarous-fixit)
    nmap ßI <Plug>(grammarous-move-to-info-window)
    nmap ßi <Plug>(grammarous-open-info-window)
    nmap ßh <Plug>(grammarous-reset)
    nmap ßa <Plug>(grammarous-fixall)
    nmap ßq <Plug>(grammarous-close-info-window)
    nmap ßr <Plug>(grammarous-remove-error)
    nmap ßd <Plug>(grammarous-disable-rule)
    nmap ßn <Plug>(grammarous-move-to-next-error)
    nmap ßp <Plug>(grammarous-move-to-previous-error)
    nmap ßc :GrammarousCheck<CR>
    vmap ß :GrammarousCheck<CR>
    omap ß <Plug>(operator-grammarous)
endif

" Thesaurus
if exists('g:loaded_thesaurus_query')
    nnoremap ßt :ThesaurusQueryReplaceCurrentWord<CR>
    nnoremap ßT :Thesaurus<space>
    nnoremap ßq :ThesaurusQueryReplace<space>
endif

" -----------------------------------------------------------------------------
"  Other mappings
" -----------------------------------------------------------------------------

" nvim-gdb
" Memo: ð is AltGr+d ([d]ebug)
" -----------------------------------------------------------------------------
if exists('g:loaded_nvimgdb')
    nnoremap ðð <C-w><C-p>
    nnoremap ðg :GdbStart gdb -q ./a.out
    nnoremap ðl :GdbStartLLDB lldb ./a.out
    nnoremap ðp :GdbStartPDB python -m pdb main.py
    nnoremap ð<Return> :GdbContinue<CR>
    nnoremap ð<Space> :GdbStep<CR>
    nnoremap ðu :GdbUntil<CR>
    nnoremap ðn :GdbNext<CR>
    nnoremap ðh :GdbFinish<CR>
    nnoremap ðt :GdbBreakpointToggle<CR>
    nnoremap ð< :GdbFrameUp<CR>
    nnoremap ð> :GdbFrameDown<CR>
    nnoremap ðe :GdbEvalWord<CR>
    vnoremap ðe :GdbEvalRange<CR>
    nnoremap ðd :GdbBreakpointClearAll<CR>
    nnoremap ði :GdbInterrupt<CR>
    nnoremap ðq :GdbDebugStop<CR>
endif
