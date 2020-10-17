"=============================================================================
" FILE: after/plugin/bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" LICENSE: MIT license
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.
"=============================================================================

if Bepoptimist_is_homerow()

    if exists(':GundoToggle')
        runtime patch/gundo.vim
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
" GIT mappings = ’
" -----------------------------------------------------------------------------

if exists('g:loaded_fugitive')
    nnoremap ’bl :Git_blame<CR>
    nnoremap ’<CR> :Git commit<CR>
    nnoremap ’e :Gedit<CR>
    nnoremap ’E :Gedit :0<CR>
    nnoremap ’fd :GDelete<CR>
    nnoremap ’fm :GMove<CR>
    nnoremap ’l :Git pull<CR>
    nnoremap ’h :0Git log --oneline<CR>
    nnoremap ’H :0Git log<CR>
    nnoremap ’m :Gmerge<CR>
    nnoremap ’p :Git push<CR>
    nnoremap ’r :Git rebase<CR>
    nnoremap ’R :Git rebase master<CR>
    nnoremap ’s :Git<CR>
    nnoremap ’w :Gwrite<CR>
    " conflict solving
    nnoremap ’d :Gvdiffsplit!<CR>
    nnoremap ’t :diffget //2<CR>
    nnoremap ’n :diffget //3<CR>
    nnoremap ’cb :CocCommand fzf-preview.GitBranches
    nnoremap ’cs :CocCommand fzf-preview.GitStashes
    nnoremap ’cr :CocCommand fzf-preview.GitReflogs
endif

if exists('g:loaded_git_messenger')
    nmap ’o <Plug>(git-messenger)
endif

" GitGutter mappings
if exists('g:loaded_gitgutter')
    nmap ’a <Plug>(GitGutterStageHunk)
    nmap ’u <Plug>(GitGutterUndoHunk)
    nmap ’v <Plug>(GitGutterPreviewHunk)

    " Git gutter text-objects (conflict with targets)
    " [h]unks
    omap ih <Plug>(GitGutterTextObjectInnerPending)
    omap ah <Plug>(GitGutterTextObjectOuterPending)
    xmap ih <Plug>(GitGutterTextObjectInnerVisual)
    xmap ah <Plug>(GitGutterTextObjectOuterVisual)
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
    nmap <silent> Ç <Plug>CamelCaseMotion_e
    nmap <silent> gç <Plug>CamelCaseMotion_ge
    nmap <silent> gÇ <Plug>CamelCaseMotion_b
    vmap <silent> ç <Plug>CamelCaseMotion_w
    vmap <silent> Ç <Plug>CamelCaseMotion_e
    vmap <silent> gç <Plug>CamelCaseMotion_ge
    vmap <silent> gÇ <Plug>CamelCaseMotion_b

    " CamelCase text-objects (ç)
    omap <silent> ç <Plug>CamelCaseMotion_w
    xmap <silent> ç <Plug>CamelCaseMotion_w
    omap <silent> Ç <Plug>CamelCaseMotion_e
    xmap <silent> Ç <Plug>CamelCaseMotion_e
    omap <silent> gç <Plug>CamelCaseMotion_ge
    xmap <silent> gç <Plug>CamelCaseMotion_ge
    omap <silent> gÇ <Plug>CamelCaseMotion_b
    xmap <silent> gÇ <Plug>CamelCaseMotion_b
    omap <silent> aç <Plug>CamelCaseMotion_iw
    xmap <silent> aç <Plug>CamelCaseMotion_iw
    omap <silent> iç <Plug>CamelCaseMotion_ib
    xmap <silent> iç <Plug>CamelCaseMotion_ib
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

" FIXME: check if it's loaded via either coc extension or vim
nnoremap ’h :Commits!<CR>
nnoremap ’H :BCommits!<CR>
" files
" nnoremap ,/ :<C-u>Rg<CR>
nnoremap ,/ :<C-u>FzfPreviewProjectGrep 
nnoremap <silent> ,\ :<C-u>FzfPreviewProjectGrep -resume<CR>
nnoremap <silent> ,, :<C-u>FzfPreviewDirectoryFiles<CR>
nnoremap <silent> ’’ :<C-u>FzfPreviewGitFiles<CR>
nnoremap <silent> <Tab> :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> ,<Tab> :<C-u>Windows<CR>
nnoremap <silent> ,~ :<C-u>FzfPreviewDirectoryFiles ~<CR>
nnoremap <silent> ,h :<C-u>FzfPreviewMruFiles<CR>
nnoremap <silent> ,H :<C-u>FzfPreviewMrwFiles<CR>
nnoremap <silent> ,<space> :<C-u>FzfPreviewProjectMruFiles<CR>
nnoremap <silent> ,: :<C-u>History:<CR>
nnoremap <silent> ,l :<C-u>FzfPreviewLines<CR>
nnoremap <silent> ,f     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> ,F     :<C-u>FzfPreviewLocationList<CR>
nnoremap <silent> ,m     :<C-u>Maps<CR>

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
