set -U FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -U FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -U FZF_DEFAULT_OPTS "--ansi"
set -U EDITOR "vim"
set -U VISUAL "vim"

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
