# git-jump
set -U fish_user_paths /usr/local/share/git-core/contrib/git-jump

# sbin
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# Flutter
set -g fish_user_paths "/Users/praborde/Documents/flutter/bin/" $fish_user_paths

# Python3
set -g fish_user_paths "/usr/local/opt/python/libexec/bin" $fish_user_paths

# Source autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# Starship
starship init fish | source
