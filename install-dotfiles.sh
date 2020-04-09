#!/bin/bash

config() {
	/usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" $@
}

has() {
	type "${1:?too few arguments}" &>/dev/null
}

echoSeparator() {
	echo --------------------------------------------------
}

if ! has 'git'; then
	echo Please install git ❌
	exit 1
fi

# Install brew
if ! has 'brew'; then
	echo Installing brew.. 🍺
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echoSeparator

if has 'brew'; then

	if has 'fish'; then
		brew install fish
		curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
		echo /usr/local/bin/fish | sudo tee -a /etc/shells
		chsh -s /usr/local/bin/fish
	fi

	echoSeparator

	# Git
	if has 'git'; then
		echo Git is not installed
		brew install git
	fi

	echoSeparator

	# Tmux
	if ! has 'tmux'; then
		echo Installing tmux.. 🖥️
		brew install tmux
	fi

	echoSeparator

	# Tmuxinator
	if ! has 'tmuxinator'; then
		echo Installing tmuxinator..
		brew install tmuxinator
	fi

	echoSeparator

	# Kitty
	if ! has 'kitty'; then
		echo Installing kitty.. 🐈
		brew cask install kitty
	fi

	echoSeparator

	# Alacritty
	if ! has 'alacritty'; then
		echo Installing alacritty..
		brew cask install alacritty
	fi

	echoSeparator

	# Neovim
	if ! has 'neovim'; then
		echo Installing neovim.. 📟
		brew install neovim
	fi

	echoSeparator

	# Vim
	echo Installing latest vim.. 📟
	brew install vim

	echoSeparator

	# Autojump
	if ! has 'autojump'; then
		echo Installing autojump..
		brew install autojump
	fi

	echoSeparator

	# brew clean up
	echo Cleaning up brew 🧹
	brew cleanup

else
	exit 1
fi

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
fi
config checkout
config config status.showUntrackedFiles no/bin/bash

echo alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" >>"$HOME"/.bashrc
source "$HOME"/.bashrc

config submodule init
config submodule update

echo Configuration finished 🎉
echo Restart your terminal
