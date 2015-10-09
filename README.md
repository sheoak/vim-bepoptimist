# vim-bim
A vim plugin that remaps and adds vim keymaps for Bépo keyboard
*Bim* is for *Bépo IMproved*.

It does more than just remapping *jklm* and suggest a lot of keymaps that
have been designed to be easy to access in bépo layout. It also take advantage
of keys not available in qwerty or azerty layouts, like œ, æ, …

# Features

- Detecting keyboard layout
- Remapping *jklm* to *ctsr*
- Improving access to some keys like $, ", w…
- Adding new easy keymaps
- Fixing shortcuts for some famous plugins (surround, unite…)

**Under development.**


# Installation

vim-bim must be before [vim-surround](https://github.com/tpope/vim-surround) by
Tim Pope because it disables surround default mappings due to confict with "c"
key remapped to "l" in this plugin.

This plugin works better with "," as leader (better suggestions are welcome):

    " we also remap \ to , to avoid losing "f" reverse repeat
    let mapleader = ","
    noremap \ ,

This way you can save your file by hitting `,,` in normal mode (map defined in
the plugin).

To install using pathogen.vim:

    cd ~/.vim/bundle
    git clone https://github.com/sheoak/vim-bim.git

To install using [Vundle](https://github.com/gmarik/vundle):

    " add this line to your .vimrc file
    Plugin 'sheoak/vim-bim'

To checkout the source from repository:

    cd ~/.vim/bundle
    git clone https://github.com/sheoak/vim-bim.git

or:

    cd /tmp
    git clone https://github.com/sheoak/vim-bim.git
    cp vim-bim/plugin/bim.vim ~/.vim/plugin/

# License

Copyright (c) sheoak. Distributed under the same terms as Vim itself.
See `:help license`.


