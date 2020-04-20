function ta -d "ta alias to attach tmux sessions"
    tmux -2 attach-session -t $argv
end
