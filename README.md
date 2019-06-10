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


# Installation

If you don't have any favorite installation method I recommand vim-plug.
Just put this line in your .vimrc or init.vim

    Plug 'sheoak/vim-bepoptimist'

Restart vim and install:

    :PlugInstall


# License

Copyright (c) sheoak. Distributed under the same terms as Vim itself.
See `:help license`.


