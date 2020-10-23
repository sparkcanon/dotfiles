# ZPLUG
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'themes/nicoulaj', from:oh-my-zsh, defer:3
zplug 'plugins/tmux', from:oh-my-zsh, defer:3
zplug 'plugins/history', from:oh-my-zsh, defer:3
zplug 'plugins/tmuxinator', from:oh-my-zsh, defer:3
zplug 'plugins/autojump', from:oh-my-zsh, defer:3
zplug 'plugins/fzf', from:oh-my-zsh, defer:3

zplug 'wfxr/forgit', defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:1
zplug 'zsh-users/zsh-autosuggestions', defer:2

zplug "zsh-users/zsh-history-substring-search", defer:1

zplug 'zsh-users/zsh-completions', depth:1

zplug check || zplug install
zplug load

# Utils
has() {
    type "${1:?too few arguments}" &>/dev/null
}

# Bind Keys
if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# Enable edit command in $EDITOR
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# Exports
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/share/git-core/contrib/git-jump:$PATH"
export VISUAL=vim
export EDITOR="${VISUAL}"
export GTAGSCONF=$HOME/.globalrc
export GTAGSLABEL=ctags
export TERM="xterm-256color"
export MANPAGER="vim -M +MANPAGER -"

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
alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude __snapshots__ --exclude macaw'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_COMPLETION_TRIGGER='**'

# zcompdump location
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
