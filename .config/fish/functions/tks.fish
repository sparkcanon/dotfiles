function tks -d "ta alias to create a new tmux sessions"
    tmux -2 kill-session -t $argv
end
