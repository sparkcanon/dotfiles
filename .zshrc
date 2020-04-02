# ZPLUG
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'themes/sorin', from:oh-my-zsh, defer:3
zplug 'plugins/tmux', from:oh-my-zsh, defer:3
zplug 'plugins/history', from:oh-my-zsh, defer:3
zplug "modules/git", from:prezto
zplug 'wfxr/forgit'

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug 'zsh-users/zsh-autosuggestions', use:'zsh-autosuggestions.zsh'
zplug "zsh-users/zsh-history-substring-search", from:oh-my-zsh
zplug 'zsh-users/zsh-completions', depth:1

zplug check || zplug install
zplug load

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
alias lc="colorls"
alias et="emacs -nw"
alias ec="TERM=xterm-24bit emacsclient -nw"
alias ew="TERM=xterm-24bit emacs"
alias ed="TERM=xterm-24bit emacs --bg-daemon"
alias edc="TERM=xterm-24bit emacs --bg-daemon && TERM=xterm-24bit ec"
alias emuand="$HOME/Library/Android/sdk/emulator/emulator"
alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias txd="tmuxinator delete"
alias config="/usr/bin/git --git-dir=/Users/praborde/.dotfiles/ --work-tree=/Users/praborde"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_COMPLETION_TRIGGER='**'

# autojump related
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# thefuck
eval $(thefuck --alias)
