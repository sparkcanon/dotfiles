#!/bin/bash

CHSH=${CHSH:-yes}
IS_BREW_AVAILABLE="$(brew --version)"
ZSH=${ZSH:-~/.oh-my-zsh}

config() {
   /usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" $@
}

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

echoSeparator() {
  echo --------------------------------------------------
}

echoSeparator

# Install brew
if [[ $IS_BREW_AVAILABLE == *"Homebrew"* ]]; then
  echo Brew is installed
else
  echo Installing brew.. 🍺
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echoSeparator

if ! command_exists zsh; then
  echo Installing zsh..
  brew install zsh

  # We're going to change the default shell, so back up the current one
  if [ -n "$SHELL" ]; then
    echo "$SHELL" > ~/.shell.pre-oh-my-zsh
  else
    grep "^$USER:" /etc/passwd | awk -F: '{print $7}' > ~/.shell.pre-oh-my-zsh
  fi

  # Actually change the default shell to zsh
  if ! chsh -s "$zsh"; then
    echo chsh commad unsuccessful. Change your default shell manually.
  else
    export SHELL="$zsh"
    echo Shell successfully changed to $zsh
  fi
else
  echo Zsh is available
fi

echoSeparator

# check to see is git command line installed in this machine
command_exists git || {
  echo Git is not installed
  brew install git
}

echo Git is available

echoSeparator

# Updating brew
echo Updating brew 🔁
brew update
brew upgrade

echoSeparator

echo Checking dependencies.. 📦

echoSeparator

# install tmux
if brew ls --versions tmux > /dev/null ; then
  # The package is installed
  echo tmux installed 🖥️
else
  # The package is not installed
  echo Installing tmux.. 🖥️
  brew install tmux
fi

echoSeparator

# install tmuxinator
if brew ls --versions tmuxinator > /dev/null ; then
  # The package is installed
  echo tmuxinator installed
else
  # The package is not installed
  echo Installing tmuxinator..
  brew install tmuxinator
fi

echoSeparator

# install kitty
if brew ls --versions kitty > /dev/null ; then
  # The package is installed
  echo kitty installed 🐈
else
  # The package is not installed
  echo Installing kitty.. 🐈
  brew cask install kitty
fi

echoSeparator

# install alacritty
if brew ls --versions alacritty > /dev/null ; then
  # The package is installed
  echo alacritty installed
else
  # The package is not installed
  echo Installing alacritty..
  brew cask install alacritty
fi

echoSeparator

# install neovim
if brew ls --versions neovim > /dev/null ; then
  # The package is installed
  echo neovim installed 📟
else
  # The package is not installed
  echo Installing neovim.. 📟
  brew install neovim
fi

echoSeparator

# install vim
echo Installing vim.. 📟
brew install vim

echoSeparator

# install iterm
if brew ls --versions iterm2 > /dev/null ; then
  # The package is installed
  echo iterm installed 📟
else
  # The package is not installed
  echo Installing iterm.. 📟
  brew cask install neovim
fi

echoSeparator

if brew ls --version autojump > /dev/null ; then
  echo autojump is installed
else
  echo Installing autojump..
  brew install autojump
fi

echoSeparator

# brew clean up
echo Cleaning up brew 🧹
brew cleanup

echoSeparator

echo Cloning dotfiles repo..

git clone --recursive --bare https://github.com/sparkcanon/dotfiles.git "$HOME"/.dotfiles

echoSeparator

echo Configuring dotfiles..

mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo Checked out config
  else
    echo Backing up pre-existing dot files
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no/bin/bash

echo alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" >> "$HOME"/.bashrc
source "$HOME"/.bashrc

config submodule init
config submodule update

echo Configuration finished 🎉
