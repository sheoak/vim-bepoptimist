# vim-bepoptimist

A vim plugin that remaps and adds vim keymaps for Bépo keyboard
(previously "bepo-vim")

It does more than just remapping *jklm* and suggest a lot of keymaps that
have been designed to be easy to access in bépo layout. It also take advantage
of keys not available in qwerty or azerty layouts, like œ, æ, …

The documentation is currently not up to date due to a refactoring.

# Features

- Remapping *jklm* to *ctsr*
- Improving access to some keys like w or leader key
- Adding new easy keymaps using additional bepo keys
- Fugitive, sneak, tabular mappings for bépo

**Under development.**

# Abandonned features

- Detecting keyboard layout: it was too much trouble…

# Installation

vim-bepoptimist works better with "," as leader (better suggestions are 
welcome). To let the plugin remap leader:

    let g:bim_remap_leader = 1

This way you can save your file by hitting `,,` in normal mode (map defined in
the plugin).


To add [fugitive](https://github.com/tpope/vim-fugitive) shortcuts:

    let g:bim_map_fugitive = 1
    " change the default fugitive prefix (gy)
    let g:bim_fugitive_prefix = 'ç'

Then you can use fugitive like this:

    gys : :Gstatus (çs if you remaped)
    gyb : :Gblame  (çb if you remaped)
    …

# Installation

If you don't have any favorite installation method I recommand vim-plug.
Just put this line in your .vimrc or init.vim

    Plug 'sheoak/vim-bim'

And install:

    :PlugInstall

# Faq

    Where is the help file?

I'm on it but i'm still working on the mapping for now so I don't want to spent 
too much time changing the help file all the time.

# License

Copyright (c) sheoak. Distributed under the same terms as Vim itself.
See `:help license`.


