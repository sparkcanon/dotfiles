#/bin/bash

# Install brew
if which programname >/dev/null; then
    echo Brew is installed
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "--------------------------------------------------"

# Updating brew
echo "Updating brew 🔁"
brew update
brew upgrade

echo "--------------------------------------------------"

echo "Checking dependencies.. 📦"

echo "--------------------------------------------------"

# install tmux
if brew ls --versions tmux > /dev/null ; then
  # The package is installed
  echo "tmux installed 🖥️"
else
  # The package is not installed
  echo "Installing tmux.. 🖥️"
  brew install tmux
fi

echo "--------------------------------------------------"

# install tmuxinator
if brew ls --versions tmuxinator > /dev/null ; then
  # The package is installed
  echo "tmuxinator installed"
else
  # The package is not installed
  echo "Installing tmuxinator.."
  brew install tmuxinator
fi

echo "-------------------------------------------------"

# install kitty
if brew ls --versions kitty > /dev/null ; then
  # The package is installed
  echo "kitty installed 🐈"
else
  # The package is not installed
  echo "Installing kitty.. 🐈"
  brew cask install kitty
fi

echo "--------------------------------------------------"

# install alacritty
if brew ls --versions alacritty > /dev/null ; then
  # The package is installed
  echo "alacritty installed"
else
  # The package is not installed
  echo "Installing alacritty.."
  brew cask install alacritty
fi

echo "--------------------------------------------------"

# install neovim
if brew ls --versions neovim > /dev/null ; then
  # The package is installed
  echo "neovim installed 📟"
else
  # The package is not installed
  echo "Installing neovim.. 📟"
  brew install neovim
fi

echo "--------------------------------------------------"

# install iterm
if brew ls --versions iterm2 > /dev/null ; then
  # The package is installed
  echo "iterm installed 📟"
else
  # The package is not installed
  echo "Installing iterm.. 📟"
  brew cask install neovim
fi

echo "--------------------------------------------------"

if brew ls --version autojump > /dev/null ; then
  echo "autojump is installed"
else
  echo "Installing autojump.."
  brew install autojump
fi

echo "--------------------------------------------------"

# brew clean up
echo "Cleaning up brew 🧹"
brew cleanup

echo "--------------------------------------------------"

echo "Cloning dotfiles repo.."

git clone --recursive --bare https://github.com/sparkcanon/dotfiles.git $HOME/.dotfiles

echo "--------------------------------------------------"

echo "Configuring dotfiles.. "

function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no/bin/bash

echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
source .bashrc

config submodule init
config submodule update

echo "Configuration done 🎉"-
