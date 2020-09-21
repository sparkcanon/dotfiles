# ZPLUG
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'themes/sorin', from:oh-my-zsh, defer:3
zplug 'plugins/tmux', from:oh-my-zsh, defer:3
zplug 'plugins/history', from:oh-my-zsh, defer:3
zplug "plugins/git", from:oh-my-zsh, defer:2
zplug 'wfxr/forgit', defer:2

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug 'zsh-users/zsh-autosuggestions', use:'zsh-autosuggestions.zsh', defer:2
# TODO: This is not working very well
zplug "zsh-users/zsh-history-substring-search", defer:1
zplug 'zsh-users/zsh-completions', depth:1
zplug 'plugins/tmuxinator', from:oh-my-zsh, defer:3
zplug 'plugins/autojump', from:oh-my-zsh, defer:3
zplug 'plugins/fzf', from:oh-my-zsh, defer:3
zplug 'plugins/colored-man-pages', from:oh-my-zsh, defer:3

zplug check || zplug install
zplug load

# Utils
has() {
    type "${1:?too few arguments}" &>/dev/null
}

# Bind Keys
has 'history-substring-search-up' && bindkey '^[[A' history-substring-search-up
has 'history-substring-search-down' && bindkey '^[[B' history-substring-search-down

# Exports
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/share/git-core/contrib/git-jump:$PATH"
export VISUAL=vim
export EDITOR="${VISUAL}"
export GTAGSCONF=$HOME/.globalrc
export GTAGSLABEL=ctags

# Alias
alias v="vim"
alias nv="nvim"
alias emuand="$HOME/Library/Android/sdk/emulator/emulator"
alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias txd="tmuxinator delete"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias ls="ls -lhSG"
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"

# FZF
# export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_COMPLETION_TRIGGER='**'

# zcompdump location
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
