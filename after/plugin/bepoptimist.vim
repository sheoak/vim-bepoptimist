"=============================================================================
" FILE: after/plugin/bepoptimist.vim
" AUTHOR:  Sheoak <contact at lightn.es>
" LICENSE: MIT license
"
" These maps are loaded after because the plugins must have been loaded, so we
" can make our test.
"=============================================================================

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
