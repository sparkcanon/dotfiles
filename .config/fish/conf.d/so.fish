# Source autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# git-jump
set -U fish_user_paths /usr/local/share/git-core/contrib/git-jump

# Homebrew
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
