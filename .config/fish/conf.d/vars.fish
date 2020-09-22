set -U FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -U FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -U FZF_DEFAULT_OPTS "--ansi"
set -U EDITOR "vim"
set -U VISUAL "vim"
set -U TERM "xterm-256color"

set -x MANPAGER "vim -M +MANPAGER -"

set -x RIPGREP_CONFIG_PATH "/Users/praborde/.config/ripgrep/.ripgreprc"
