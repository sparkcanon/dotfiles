# My Dotfiles

In order to start from scratch use the link below in your terminal

## Contents

- vim & neovim
- tmux
- zsh
- kitty
- alacritty

## Dependencies

- Git
- Node

## Installation

`curl -Lks https://raw.githubusercontent.com/sparkcanon/dotfiles/master/install-dotfiles.sh | /bin/bash`

The above script installs the following;

- Homebrew
- vim
- pack
- tmux
- tmux plugin manager - TODO
- kitty
- alacritty
- tmuxinator
- fish -> tries to sets `$SHELL`
- git -> mac comes with an older version of git

Then the script clones this `bare` repo in the `$HOME` dir and displaces
existing `.dotfiles` to the `.config-backup` folder. 
Next just open (n)vim and `vim-plug` should install all necessary plugins.
