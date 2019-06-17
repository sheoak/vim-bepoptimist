# vim-bepoptimist

A vim plugin that remaps and adds vim keymaps for Bépo keyboard.

*Warning*: The documentation is outdated, I will work on it as soon as possible
but I'm currently refactoring all my dotfiles and mapping system.

It does more than just remapping *jklm* and suggest a lot of keymaps that
have been designed to be easy to access in bépo layout. It also take advantage
of keys not available in qwerty or azerty layouts, like œ, æ, …

# Features

- Remapping *jklm* to *tsrn* (not *ctsr*)
- Improving access to some keys like w or leader key
- Adding new easy keymaps using additional bepo keys
- Fugitive, sneak, tabular mappings for bépo


# Installation

vim-bepoptimist works better with "," as leader (better suggestions are 
welcome). You should remap it in your vim/neovim main configuration file.


If you don't have any favorite installation method I recommand vim-plug.
Just put this line in your .vimrc or init.vim

    Plug 'sheoak/vim-bepoptimist'

Restart vim and install:

    :PlugInstall

Don't use "," as leader key as it will most likely conflict with bepoptimist.

You need to add this block in your vim configuration to pre-configured
compatible plugins:

    let g:surround_no_mappings = 1
    let g:ranger_map_keys = 0
    let g:bexec_no_mappings = 1
    let g:bclose_no_plugin_maps = 1
    let g:nvimgdb_disable_start_keymaps = 1
    let g:user_emmet_leader_key='<C-y>'
    let g:jedi#documentation_command = 'gh'   " vim Jedi needs to use the same key
    let g:jedi#completions_command = ""
    let g:jedi#rename_command = ''
    let g:jedi#usages_command = ''
    let g:jedi#goto_assignments_command = ''
    let g:jedi#goto_command = ''
    let g:table_mode_map_prefix = ',\|'
    let g:sneak#target_labels = "auiectsrnovdl"
    " hack for vim-sneak, to avoid remapping
    nmap , <Nop>

# License

Copyright (c) sheoak. Distributed under the same terms as Vim itself.
See `:help license`.


