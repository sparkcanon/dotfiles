function tks -d "ta alias to create a new tmux sessions"
    tmux kill-session -t $argv
end
